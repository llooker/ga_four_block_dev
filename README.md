# Google Analytics 4

# What does this Looker Block do for me?

This block allows GA4 users to continue to view the dashboards and metrics that they are familiar with from GA360.
In order to mirror a lot of the high level dashboards you see in your existing GA 360 UI by looking at an Overview, Behavior, Audiences,  Acquisition, and Custom Goal Conversions, this block creates:
- a pdt to sessionize the event date (sessions.view)
- retention cohort analysis capabilities (audience_cohorts.view)
- looker dimension for every combination of \_event\_name\_ / \_event\_params.key\_ and \_user_properties_ (event\_data\_dimensions folder)


GA4 data is exported (in this case, through [Transfer Services](https://cloud.google.com/bigquery/transfer/) in the format of a single flat table with a new entry for each session. Rather than creating new tables for each entity attribute, Google places aggregate or attribute information in nested fields in the single table.  GA4 exports comprehensive event-based data, nested within categorized table columns. Similar to Google's Firebase output, this is difficult to query due to date-based partitioned tables and a need for unnesting in all but the most high-level queries.


Non-Repeating Nested Fields (such as events.user\_properties) can be referenced to by ${TABLE}.user\_ltv.KEY\_NAME.  However, Some elements within GA4 are packaged as repeating key/value pairs. If we unnest these elements, we will have several rows with a key column and one or more value columns:

| Row* | Key | String Value | Int Value | Double Value | Float Value |
|------|-----|--------------|------------|-------------|-------------|
| 1    |  a  |     null     |    null   |     1.1      |     null    |
| 2    |  b  |     abc      |    null   |     null     |     null    |
| 3    |  c  |     null     |    61     |     null     |     null    |
 *Row Implied

Each key will have a value populated in one of 4 possible corresponding value fields by default:
1. STRING Value (value.string_value)
2. INT Value (value.int_value)
3. DOUBLE Value (value.double_value)
4. FLOAT Value (value.float_value)
  Other value types may be possible on some fields (TIMESTAMP_MICROS, etc...)

When defining the field that refers to the value half of each key/value pair, you will need to specify which value field is associated with the key.
For example. If you had an event parameter that tracked the UTM Campaign data for each event, where the key = "campaign" and the value is stored in the string_value field, the dimension would be defined as:
    dimension: event\_param\_campaign {
      group_label: "Parameters"
      label: "Event Campaign"
      type: string
      sql: (SELECT value.string_value FROM UNNEST(event_params) WHERE key = "campaign") ;;
    }

Another example would be extracting GA Session ID from event parameters. This would be using INT Value:
    dimension: event_param_ga_session_id {
      group_label: "Session"
      label: "GA Session ID"
      type: number
      sql: (SELECT value.int_value FROM UNNEST(event_params) WHERE key = "ga_session_id") ;;
    }



Google's documentation on the data included in the export can be found [here](https://support.google.com/analytics/answer/7029846?hl=en).

For more information on Nested Fields, and why Google chooses to use them, please refer to this overview on Why [Nesting is so Cool](https://looker.com/blog/why-nesting-is-so-cool).



# Block Structure
Core project: XXXXXXX is the read-only project where the block’s base Explores, views, and dashboards are defined. The core project’s initial views and Explores are defined in the core project and extended in the config project, where they can be modified. Then the config project and its files are imported into the core project. Finally, the core project defines the block’s content layer, or the dashboards and Explores that are surfaced in the Looker UI.

Config project: XXXXXXXX-config is the project that can be modified by LookML developers. This project extends the core project. Its files are also imported into the core project and extended in the core project’s content layer, so that changes made to files in the config project are brought into the core project. You can read more about customizing the block here.

One thing we have taken into account when building this block is the different levels of aggregations between users, sessions, and hits. We have made sure that all of the metrics shown in the explore section can be grouped by these differing levels of aggregation without fanning out the numbers.

Our main view is the sessions view, which sessionizes the data from the event_table....


# Customizations
<!-- Because every Firebase schema has some similarities but different event types and user properties, the block will generate a unique schema for your event structure. It uses a Python notebook to connect to Looker's API and query your database and output some lovely LookML. -->

## How do you do use it?

<!-- ### Prep Looker Side

1. Start by creating a new project by cloning this public repo: https://docs.looker.com/data-modeling/getting-started/create-projects#cloning_a_public_git_repository
2. Add your own Git repo, change the connection name and the name of the event table in _events.view.lkml_ and the datagroup for _sessions.view.lkml_ and push to production.
3. Create yourself a new API3 key https://docs.looker.com/admin-options/settings/users#api3_keys -->


## Run the Python Code to Generate your Model

1. Download the Firebase Python Notebook and open it with your favorite Notebook runner. I use Google Colab https://github.com/llooker/firebase_block_v3/blob/master/Firebase_Block_v3.ipynb or just open it here:

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/llooker/firebase_block_v3/blob/master/Firebase_Block_v3.ipynb)

3. Enter your _base_url_ _client_id_ and _client_secret_  (this is your API3 key)
4. Run the Python notebook
5. Copy the results of the _event_properties_ section into _events_generated.view.lkml_ (replace the entire file)
6. Copy the results of t


# Notes and Other Known Issues

*We are querying the raw events log which might be expensive to query, we've added a _SQL_ALWAYS_WHERE_ clause to the model and only query this year's data for the sessions PDT. Adjust accordingly

*If you have duplicate dimensions with the same name (firebase allows same event name , keys but different types)
Change the part of events “Event Properties” python code  like this:
 `print("dimension: "+event_name+"."+key+ "_" + type[0]+" {")`(thanks @nishimix for the fix!)



# Coming Soon
1. Leverage advanced analytics to be able to predict which customers are likely to make another purchase in the future based off of their historical actions. This leverages the out of the box BQML capabilities of BigQuery that you can read up on here
2. Better understand your customers by looking at their natural pathing through pages and events through your pages alongside the ability to create completely custom page and event paths to conduct any A/B testing to see how customers are trending.
3. You can look at the successes of your marketing campaigns as well by using the campaign impact dashboard to identify a specific cohort of customers you targeted with a campaign and seeing how that particular customer base has trended over time to see if the campaign had any effect.
4. Looker will offer an out of the box data action to enable you to push data back into your GA console.
