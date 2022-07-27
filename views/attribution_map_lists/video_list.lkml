view: video_list {
## UPDATED: 2022-07-27

  derived_table: {
    sql: with to_split as (SELECT ["blog.twitch.tv",
                                  "crackle",
                                  "crackle.com",
                                  "curiositystream",
                                  "curiositystream.com",
                                  "d.tube",
                                  "dailymotion",
                                  "dailymotion.com",
                                  "dashboard.twitch.tv",
                                  "disneyplus",
                                  "disneyplus.com",
                                  "fast.wistia.net",
                                  "help.hulu.com",
                                  "help.netflix.com",
                                  "hulu",
                                  "hulu.com",
                                  "id.twitch.tv",
                                  "iq.com",
                                  "iqiyi",
                                  "iqiyi.com",
                                  "jobs.netflix.com",
                                  "justin.tv",
                                  "m.twitch.tv",
                                  "m.youtube.com",
                                  "music.youtube.com",
                                  "netflix",
                                  "netflix.com",
                                  "player.twitch.tv",
                                  "player.vimeo.com",
                                  "ted",
                                  "ted.com",
                                  "twitch",
                                  "twitch.tv",
                                  "utreon",
                                  "utreon.com",
                                  "veoh",
                                  "veoh.com",
                                  "viadeo.journaldunet.com",
                                  "vimeo",
                                  "vimeo.com",
                                  "wistia",
                                  "wistia.com",
                                  "youku",
                                  "youku.com",
                                  "youtube",
                                  "youtube.com"] as split_list)
                                  select sl
                                  from to_split,
                                  unnest(split_list) sl
      ;;
  }

  dimension: video_list_item {
    hidden: yes
    type: string
    sql: ${TABLE}.sl ;;
  }
}
