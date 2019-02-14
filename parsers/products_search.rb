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
    "leshopch" => "eyJsdmwiOiJVIiwiZW5jIjoiQTI1NkdDTSIsImFsZyI6ImRpciIsImtpZCI6IjlmNjcwNjMxLTg2NGYtNDJkMy04Yzc1LTA4M2RiOTJkYWY1MiJ9..22f9YEX53lwVU-Il.I0ToPOWsOdXsi-_YT7fMRvjdN1Gnh3Q6q_enKuvGDCx3lE90rICdqazP4YF8yAdcVOw1vpPLTk5eonZOMjgQ6pI1XxGL-7zjzFQRraDsoNhwIVWk6c-HFxy6gjMgktJsG6z6jg4TYaCuVacOZzKnP3LK7PsNUvhRlGFigTy7ZAvUy0LT82AcM-9zbRytcjx1uVlnaZZu8yUnCQsVIO-rapPrjP9wMm0oCfjSEJNeJ84CCBw13RypcS-IDnENaO7MRXO_6fjV5rC3nzVjokJ76IXRUqwg.t-gVEEZHm4nLwVUFcLptYw",
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

