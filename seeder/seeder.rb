require 'cgi'
require './lib/headers'

pages << {
    page_type: 'products_search',
    method: 'GET',
    url: 'https://www.leshop.ch/supermarket/public/v3/api/products/languages/de/warehouses/2/categoryId/3857273?&sortOrder=asc',
    headers: ReqHeaders::SEARCH_PAGE_HEADER_REQ,
    vars: {
        'input_type' => 'taxonomy',
        'search_term' => '-',
        'page' => 1
    }


}

search_terms = ['Red Bull', 'RedBull', 'Energy Drink', 'Energy Drinks']
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