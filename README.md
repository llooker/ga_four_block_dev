# Google Analytics 4

# What does this Looker Block do for me?

This block allows GA4 users to continue to view the dashboards and metrics that they are familiar with from GA360.
In order to mirror a lot of the high level dashboards you see in your existing GA 360 UI by looking at an Overview, Behavior, Audiences,  Acquisition, and Custom Goal Conversions, this block creates:
- An Incremental Persistent Derived Table that Sessionizes the Event Data (Sessions.view)
- Event Level Data linked to a specific Session (events.view + extended views)
- Retention Cohort Analysis capabilities (audience_cohorts.view)
- Looker dimension for every combination of \_event\_name\_ / \_event\_params.key\_ and \_user_properties_ (event\_data\_dimensions folder) for the automatically collected data.


# GA4 Data Structure
GA4 exports comprehensive event-based data, nested within categorized table columns. Similar to Google's Firebase output, this structure requires additional steps to retrieve session data, due to date-based partitioned tables and a need for unnesting in all but the most high-level queries.
Google's documentation on the data included in the export can be found [here](https://support.google.com/analytics/answer/7029846?hl=en).

Each event row will have several columns that contain nested data, specific to that event.
Nested Fields (such as device: mobile\_model\_name) can be referenced to with dot notation.

Sample "Device" column output.
To extract the "mobile\_brand\_name" in this sample, use "device.mobile\_brand\_name":
```
{  "mobile_model_name":"Pixel 3"
 , "mobile_brand_name":"Google"
 , "operating_system_version":"Android 10" }
```
However, Some elements within GA4 are packaged as repeating key/value pairs.
If we unnest these elements, we will have several rows with a key column and one or more value columns:

| Row* | Key | String Value | Int Value | Double Value | Float Value |
|------|-----|--------------|------------|-------------|-------------|
| 1    |  a  |     null     |    null   |     1.1      |     null    |
| 2    |  b  |     abc      |    null   |     null     |     null    |
| 3    |  c  |     null     |    61     |     null     |     null    |
 *Row Implied

Each key will have a value populated in one of 4 possible corresponding value fields by default:

1. STRING Value (value.string\_value)
2. INT Value (value.int\_value)
3. DOUBLE Value (value.double\_value)
4. FLOAT Value (value.float\_value)
  Other value types may be possible on some fields (TIMESTAMP\_MICROS, etc...)

Unnesting data in general at the join level adds a new row to the resultset for each nested element you are unnesting.
eg:```SELECT * FROM EVENTS, UNNEST(EVENT_PARAMS) AS EVENT_PARAMS```

This is desired on some data, such as the nested ITEMS records. In the case of ITEMS each nested record is a unique ITEM from the user's purchase, and expanding these into new rows makes sense for filtering and accurate aggregate measures.

When extracting data from the Key/Value pair data in GA4 (event_params, user_properties), the multiple unique key values are also unique to the parent event. If we unnest at the join level, we will end up with rows containing one unique value for each key. For the purposes of analysis at the event-level, we want one row with columns representing all of these possible keys. In order to extract the value and maintain one row for each event, we can unnest directly at the dimension sql definition:
```sql: (SELECT value.MATCHING\_VALUE_TYPE FROM UNNEST(event\_params) WHERE key = "KEY\_NAME") ;```

When defining the field that refers to the value half of each key/value pair, you will need to specify which value field is associated with the key.
For example. If you had an event parameter that tracked the UTM Campaign data for each event, where the key = "campaign" and the value is stored in the string_value field, the dimension would be defined as:

```
    dimension: event_param_campaign {
      label: "Event Campaign"
      type: string
      sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = "campaign") ;;
    }
```

Another example would be extracting GA Session ID from event parameters. This would be using INT Value:

```
    dimension: event_param_ga_session_id {
      label: "GA Session ID"
      type: number
      sql: (SELECT value.int_value FROM UNNEST(event_params) WHERE key = "ga_session_id") ;;
    }
```

For more information on Nested Fields, and why Google chooses to use them, please refer to this overview on Why [Nesting is so Cool](https://looker.com/blog/why-nesting-is-so-cool).


# Block Structure
Core project: XXXXXXX is the read-only project where the block’s base Explores, views, and dashboards are defined. The core project’s initial views and Explores are defined in the core project and extended in the config project, where they can be modified. Then the config project and its files are imported into the core project. Finally, the core project defines the block’s content layer, or the dashboards and Explores that are surfaced in the Looker UI.

Config project: XXXXXXXX-config is the project that can be modified by LookML developers. This project extends the core project. Its files are also imported into the core project and extended in the core project’s content layer, so that changes made to files in the config project are brought into the core project. You can read more about customizing the block here.

One thing we have taken into account when building this block is the different levels of aggregations between users, sessions, and hits. We have made sure that all of the metrics shown in the explore section can be grouped by these differing levels of aggregation without fanning out the numbers.

Our main view is the sessions view, which sessionizes the data from the event_table....


# Customizations
* Event Parameters

Each Event Parameter you enable on GA4 will need to have a new dimension and any applicable measures created, the dimensions included in this block correspond to the list of automatically tracked events [here] (https://support.google.com/analytics/answer/9234069?hl=en).

Sample Query for obtaining a list of all event parameter keys and what value they use:
```
 SELECT  ep.key
 , case when count(value.string_value) > 0 then true else false end as string_value_populated
 , case when count(value.int_value) > 0 then true else false end as int_value_populated
 , case when count(value.double_value) > 0 then true else false end as double_value_populated
 , case when count(value.float_value) > 0 then true else false end as float_value_populated
 FROM \`YOUR\_PROJECT.GA4\_DATASET.events\_\*\` e
 , UNNEST(event_params) ep
 group by 1
 order by 1 asc
```

* Goals
The Custom Goal Conversions by default are only focused on Event Type and Page Name. Typically the goals would include fields that are populated in instance-specific event parameters. To enable new goal filters, please see the goals.view file for guidance.


# Notes and Other Known Issues

* The initial run of the Incremental Persistent Derived Table will execute with a where clause of "WHERE 1=1". This will query all historical data in your GA4 Dataset across all date-partitioned tables. If you do not wish to have all historical data, you can add a hard date filter to the where clause within the "session\_list\_with\_event\_history" cte on sessions.view's derived table definition.
* If you are utilizing user\_id instead of user\_pseudo\_id, you will need to replace references to the user\_pseudo\_id with user\_id in the derived key ("sl\_key") definition in sessions.view's derived table definition, and in the user-centric measure definitions.
*


# Coming Soon
1. Leverage advanced analytics to be able to predict which customers are likely to make another purchase in the future based off of their historical actions. This leverages the out of the box BQML capabilities of BigQuery that you can read up on here
2. Better understand your customers by looking at their natural pathing through pages and events through your pages alongside the ability to create completely custom page and event paths to conduct any A/B testing to see how customers are trending.
3. You can look at the successes of your marketing campaigns as well by using the campaign impact dashboard to identify a specific cohort of customers you targeted with a campaign and seeing how that particular customer base has trended over time to see if the campaign had any effect.
4. Looker will offer an out of the box data action to enable you to push data back into your GA console.
