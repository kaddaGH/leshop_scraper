require './lib/headers'
product = JSON.parse(content)

description  = product[0]['foodFacts']['regulatedDescription'] rescue ''
description = description.gsub(/[\n\s]/,' ').gsub(/,/,' ')
product_details = page['vars']['product_details']
product_details['PRODUCT_DESCRIPTION']= description
product_details['_collection'] = 'products'
product_details['EXTRACTED_ON'] = Time.now.to_s
outputs << product_details