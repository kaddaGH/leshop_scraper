require './lib/headers'
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


if products_ids.length>0

  pages << {
      page_type: 'product_details',
      method: 'GET',
      url: "https://www.leshop.ch/catalog/public/v1/api/compatibility/products/#{products_ids.join(',')}?search_term=#{page['vars']['search_term']}&page=#{current_page}&language=de&shortVersion=false",
      headers:ReqHeaders::SEARCH_PAGE_HEADER_REQ,
      vars: {
          'input_type' => page['vars']['input_type'],
          'search_term' => page['vars']['search_term'],
          'page' => current_page,
          'nbr_products_pg1' => nbr_products_pg1,
          'scrape_url_nbr_products' => scrape_url_nbr_products

      }
  }

end

