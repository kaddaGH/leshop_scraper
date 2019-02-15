products = JSON.parse(content)


prices = {}

products_details = page['vars']['products_details']
products.each do |product|

  promotion_text = ""
  product_id = product[1]['productId']
  product_price = product[1]['price']['estimated']
  promotion_price = product[1]['promotionPrice']['estimated'] rescue nil
  unless promotion_price.nil?
    product_price = promotion_price
    promotion_text = (100 - (promotion_price * 100 / product_price)).to_i
    promotion_text = promotion_text.to_s + "%"
  end
  prices[product_id.to_s] = {'sale_price' => product_price, 'promotion_text' => promotion_text}
end


products_details.each do |product_details|

  product_id = product_details['PRODUCT_ID'].to_s


  if prices.keys.include? product_id
    product_details['SALES_PRICE'] = prices[product_id]['sale_price']
    product_details['PROMOTION_TEXT'] = prices[product_id]['promotion_text']

  end
  product_details['_collection'] = 'products'
  product_details['EXTRACTED_ON'] = Time.now.to_s
  outputs << product_details


end
