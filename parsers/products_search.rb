data = JSON.parse(content)
scrape_url_nbr_products = data['numberOfProducts'].to_i
current_page = page['vars']['page']
products_ids = data['productIds']

# if ot's first page , generate pagination
if  1>2
  nbr_products_pg1 = products.length
  step_page = 1
  while step_page * products.length <= scrape_url_nbr_products
    pages << {
        page_type: 'products_search',
        method: 'GET',
        url: page['url'].gsub(/index=0/, "index=#{step_page}"),
        vars: {
            'input_type' => page['vars']['input_type'],
            'search_term' => page['vars']['search_term'],
            'page' => step_page + 1,
            'nbr_products_pg1' => nbr_products_pg1
        }
    }

    step_page = step_page + 1


  end
elsif current_page == 1 and products_ids.length <= scrape_url_nbr_products
  nbr_products_pg1 = products_ids.length
else
  nbr_products_pg1 = page['vars']['nbr_products_pg1']
end


headers = {

    "referer" => "https://www.leshop.ch/de/supermarket/getranke-kaffee-alkohol/soft-drinks/energy-drinks",
    "Host" => "www.leshop.ch",
    "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:65.0) Gecko/20100101 Firefox/65.0",
    "Accept" => "application/json, text/plain, */*",
    "Accept-Language" => "fr,fr-FR;q=0.8,en-US;q=0.5,en;q=0.3",
    "Accept-Encoding" => "gzip, deflate, br",
    "Referer" => "https://www.leshop.ch/de/supermarket/getranke-kaffee-alkohol/soft-drinks/energy-drinks",
    "leshopch" => "eyJsdmwiOiJVIiwiZW5jIjoiQTI1NkdDTSIsImFsZyI6ImRpciIsImtpZCI6ImNlMjk5Yzk1LTBlODQtNDM3Yy1hZTJjLWVlMWE4NzlkNzMwNCJ9..FSScd-1w56LjukOO.xyANQUxuuMfFMkRCQyMYyRtmuMsGvEYokFsDStd-oLYQ-wLL7RCpB5hJk3D63WVgJtfnP0hS3gmtJjzme18IrkvwTURgpBYlyd3DE3HTE-gg4TFqhJYcyPPsaP3iQQvhrdjvlAxO8zT4QNfaIonOgSuTqyWBGKjJAQO15o5m-xzB41YLE3D195g9KQvptYTxBbmLRIb5w3PrcKio40KuvrvHfXpkvR2bxhzaJypjgvSu5HiLsO8DFiNvui5kYsl61SAejYgH03PZbhM_grxI3Mnwb9pC.gyCpeERDcWVKlNz68BjbtA",
    "DNT" => "1",
    "Connection" => "keep-alive",


}


if products_ids.length>0

  pages << {
      page_type: 'product_details',
      method: 'GET',
      url: "https://www.leshop.ch/catalog/public/v1/api/compatibility/products/#{products_ids.join(',')}?search_term=#{page['vars']['search_term']}&page=#{current_page}&language=de&shortVersion=false",
      headers:headers,
      vars: {
          'input_type' => page['vars']['input_type'],
          'search_term' => page['vars']['search_term'],
          'page' => current_page,
          'nbr_products_pg1' => nbr_products_pg1,
          'scrape_url_nbr_products' => scrape_url_nbr_products

      }
  }

end

