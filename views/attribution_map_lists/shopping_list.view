view: shopping_list {
## UPDATED: 2022-07-22

  derived_table: {
    sql: with to_split as (SELECT ["Google Shopping",
                                  "IGShopping",
                                  "aax-us-east.amazon-adsystem.com",
                                  "aax.amazon-adsystem.com",
                                  "alibaba",
                                  "alibaba.com",
                                  "amazon",
                                  "amazon.co.uk",
                                  "amazon.com",
                                  "apps.shopify.com",
                                  "checkout.shopify.com",
                                  "checkout.stripe.com",
                                  "cr.shopping.naver.com",
                                  "cr2.shopping.naver.com",
                                  "ebay",
                                  "ebay.co.uk",
                                  "ebay.com",
                                  "ebay.com.au",
                                  "ebay.de",
                                  "etsy",
                                  "etsy.com",
                                  "m.alibaba.com",
                                  "m.shopping.naver.com",
                                  "mercadolibre",
                                  "mercadolibre.com",
                                  "mercadolibre.com.ar",
                                  "mercadolibre.com.mx",
                                  "message.alibaba.com",
                                  "msearch.shopping.naver.com",
                                  "nl.shopping.net",
                                  "no.shopping.net",
                                  "offer.alibaba.com",
                                  "one.walmart.com",
                                  "order.shopping.yahoo.co.jp",
                                  "partners.shopify.com",
                                  "s3.amazonaws.com",
                                  "se.shopping.net",
                                  "shop.app",
                                  "shopify",
                                  "shopify.com",
                                  "shopping.naver.com",
                                  "shopping.yahoo.co.jp",
                                  "shopping.yahoo.com",
                                  "shopzilla",
                                  "shopzilla.com",
                                  "simplycodes.com",
                                  "store.shopping.yahoo.co.jp",
                                  "stripe",
                                  "stripe.com",
                                  "uk.shopping.net",
                                  "walmart",
                                  "walmart.com"] as split_list)
                                  select sl
                                  from to_split,
                                  unnest(split_list) sl
      ;;
  }

  dimension: shopping_list_item {
    hidden: yes
    type: string
    sql: ${TABLE}.sl ;;
  }
}
