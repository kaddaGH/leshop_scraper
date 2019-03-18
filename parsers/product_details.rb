require './lib/headers'
products = JSON.parse(content)
products_details=[]
products_ids=[]
products.each_with_index  do |product,i|
  data = product[1]
  products_ids<<data["id"]

  name = data['description']['de']
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
      PRODUCT_NAME: name,
      EAN: data['eans'].join(','),
      PRODUCT_DESCRIPTION: data['benefits']['de'],
      PRODUCT_MAIN_IMAGE_URL: "https://www-leshop-ch-cld-res.cloudinary.com/image/upload/w_500,h_500,d_default_LS_nrd2c5.jpg,c_pad,g_center,dpr_1,fl_lossy,b_rgb:fff/f_auto/e_unsharp_mask:100/q_auto/v20190214/prod/catalog/product/product-" + data['id'].to_s,
      PRODUCT_ITEM_SIZE: data['size']['minimum'],
      PRODUCT_ITEM_SIZE_UOM: data['size']['unit'],
      PRODUCT_ITEM_QTY_IN_PACK: data['numberOfUnits'],
      IS_AVAILABLE: "1"

  }

  products_details << product_details

end


if products_ids.length>0
  pages << {
      page_type: 'products_prices',
      method: 'GET',
      url: "https://www.leshop.ch/catalog/public/v1/api/compatibility/prices/#{products_ids.join(',')}/warehouses/1?search_term=#{page['vars']['search_term']}&page=#{page['vars']['page']}",
      headers:ReqHeaders::SEARCH_PAGE_HEADER_REQ,
      vars: {
          'products_details' => products_details,
          'input_type' => page['vars']['input_type'],
          'search_term' => page['vars']['search_term'],
          'page' => page['vars']['page']

      }
  }



end
