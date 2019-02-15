products = JSON.parse(content)
products_details=[]
products_ids=[]
products.each_with_index  do |product,i|
  data = product[1]
  products_ids<<data["id"]
  product_details = {
      # - - - - - - - - - - -
      RETAILER_ID: '105',
      RETAILER_NAME: 'leshop',
      GEOGRAPHY_NAME: 'CH',
      # - - - - - - - - - - -
      SCRAPE_INPUT_TYPE: page['vars']['input_type'],
      SCRAPE_INPUT_SEARCH_TERM: page['vars']['search_term'],
      SCRAPE_INPUT_CATEGORY: page['vars']['input_type'] == 'taxonomy' ? 'Energy Drinks' : '-',
      SCRAPE_URL_NBR_PRODUCTS: page['vars']['scrape_url_nbr_products'],
      # - - - - - - - - - - -
      SCRAPE_URL_NBR_PROD_PG1: page['vars']['nbr_products_pg1'],
      # - - - - - - - - - - -
      PRODUCT_BRAND: data['brand'],
      PRODUCT_RANK: i + 1,
      PRODUCT_PAGE: page['vars']['page'],
      PRODUCT_ID: data["id"],
      PRODUCT_NAME: data['name']['de'],
      EAN: data['eans'].join(','),
      PRODUCT_DESCRIPTION: data['description']['de'],
      PRODUCT_MAIN_IMAGE_URL: "https://www-leshop-ch-cld-res.cloudinary.com/image/upload/w_500,h_500,d_default_LS_nrd2c5.jpg,c_pad,g_center,dpr_1,fl_lossy,b_rgb:fff/f_auto/e_unsharp_mask:100/q_auto/v20190214/prod/catalog/product/product-" + data['id'].to_s,
      PRODUCT_ITEM_SIZE: data['size']['minimum'],
      PRODUCT_ITEM_SIZE_UOM: data['size']['unit'],
      PRODUCT_ITEM_QTY_IN_PACK: data['numberOfUnits'],
      IS_AVAILABLE: "1",
      EXTRACTED_ON: Time.now.to_s

  }



  products_details << product_details


end



headers = {

    "referer" => "https://www.leshop.ch/de/supermarket/getranke-kaffee-alkohol/soft-drinks/energy-drinks",
    "Host" => "www.leshop.ch",
    "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:65.0) Gecko/20100101 Firefox/65.0",
    "Accept" => "application/json, text/plain, */*",
    "Accept-Language" => "fr,fr-FR;q=0.8,en-US;q=0.5,en;q=0.3",
    "Accept-Encoding" => "gzip, deflate, br",
    "Referer" => "https://www.leshop.ch/de/supermarket/getranke-kaffee-alkohol/soft-drinks/energy-drinks",
    "leshopch" => "eyJsdmwiOiJVIiwiZW5jIjoiQTI1NkdDTSIsImFsZyI6ImRpciIsImtpZCI6IjlmNjcwNjMxLTg2NGYtNDJkMy04Yzc1LTA4M2RiOTJkYWY1MiJ9..22f9YEX53lwVU-Il.I0ToPOWsOdXsi-_YT7fMRvjdN1Gnh3Q6q_enKuvGDCx3lE90rICdqazP4YF8yAdcVOw1vpPLTk5eonZOMjgQ6pI1XxGL-7zjzFQRraDsoNhwIVWk6c-HFxy6gjMgktJsG6z6jg4TYaCuVacOZzKnP3LK7PsNUvhRlGFigTy7ZAvUy0LT82AcM-9zbRytcjx1uVlnaZZu8yUnCQsVIO-rapPrjP9wMm0oCfjSEJNeJ84CCBw13RypcS-IDnENaO7MRXO_6fjV5rC3nzVjokJ76IXRUqwg.t-gVEEZHm4nLwVUFcLptYw",
    "DNT" => "1",
    "Connection" => "keep-alive",


}

if products_ids.length>0
  pages << {
      page_type: 'products_prices',
      method: 'GET',
      url: "https://www.leshop.ch/catalog/public/v1/api/compatibility/prices/#{products_ids.join(',')}/warehouses/2?search_term=#{page['vars']['search_term']}&page=#{page['vars']['page']}",
      headers:headers,
      vars: {
          'products_details' => products_details

      }
  }



end
