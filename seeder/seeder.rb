require 'cgi'

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
pages << {
    page_type: 'products_search',
    method: 'GET',
    url: 'https://www.leshop.ch/supermarket/public/v3/api/products/languages/de/warehouses/2/categoryId/3857273?&sortOrder=asc',
    headers: headers,
    vars: {
        'input_type' => 'taxonomy',
        'search_term' => '-',
        'page' => 1
    }


}

search_terms = ['Red Bull', 'RedBull', 'Energidryck', 'Energidrycker']
search_terms.each do |search_term|
  break
  pages << {
      page_type: 'products_search',
      method: 'GET',
      url: "https://api.mathem.io/product-search/noauth/search/query?q=#{CGI.escape(search_term)}&brands=&badges=&categories=&storeId=10&size=25&index=0&sortTerm=&sortOrder=&supplier=&searchToCart=true",
      vars: {
          'input_type' => 'search',
          'search_term' => search_term,
          'page' => 1
      }


  }

end