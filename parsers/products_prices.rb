require './lib/headers'
products = JSON.parse(content)


prices = {}

products_details = page['vars']['products_details']
products.each do |product|

  promotion_text = ""
  product_id = product[1]['productId']
  product_price = product[1]['price']['estimated']
  promotion_price = product[1]['promotionPrice']['estimated'] rescue nil
  pack = product[1]['multiplier'] rescue nil

  unless promotion_price.nil?
    promotion_text = (100 - (promotion_price * 100 / product_price)).to_i
    promotion_text = promotion_text.to_s + "%"
    product_price = promotion_price
  end
  prices[product_id.to_s] = {'sale_price' => product_price, 'promotion_text' => promotion_text,'pack'=>pack}
end


products_details.each do |product_details|

  product_id = product_details['PRODUCT_ID'].to_s


  if prices.keys.include? product_id
    product_details['SALES_PRICE'] = prices[product_id]['sale_price']
    product_details['PROMOTION_TEXT'] = prices[product_id]['promotion_text']
     unless  prices[product_id]['pack'].nil?
       if prices[product_id]['pack'].to_i>1

        product_details['PRODUCT_ITEM_QTY_IN_PACK'] = prices[product_id]['pack']
     end
    end


  end

  if product_details['PRODUCT_ITEM_QTY_IN_PACK'].to_i==1
    product_details['PRODUCT_NAME'] = product_details['PRODUCT_NAME'].gsub(/pack_size/,'')
    else

      product_details['PRODUCT_NAME'] = product_details['PRODUCT_NAME'].gsub(/pack_size/,product_details['PRODUCT_ITEM_QTY_IN_PACK'].to_s+'x')
  end
  pages << {
      page_type: 'product_texts',
      method: 'GET',
      url: "https://www.leshop.ch/supermarket/public/v3/api/productmetadata/language/de/products?id=#{product_details["PRODUCT_ID"]}&search_term=#{page['vars']['search_term']}&page=#{page['vars']['page']}",
      headers:ReqHeaders::SEARCH_PAGE_HEADER_REQ,
      vars: {
          'product_details' => product_details



      }
  }

end
