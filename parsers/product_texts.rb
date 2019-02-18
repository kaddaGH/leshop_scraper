require './lib/headers'
products = JSON.parse(content)
k = 1+"dd"
product_details = page['vars']['product_details']

product_details['_collection'] = 'products'
product_details['EXTRACTED_ON'] = Time.now.to_s