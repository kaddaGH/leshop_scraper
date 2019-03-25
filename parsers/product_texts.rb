require './lib/headers'
product = JSON.parse(content)


short_description  = product[0]['sellingLine'].gsub(/[\n\s,]/,' ') rescue ''

description  = product[0]['foodFacts']['regulatedDescription'].gsub(/[\n\s,]/,' ') rescue ''
product_details = page['vars']['product_details']
product_details['PRODUCT_DESCRIPTION']= short_description+' '+product_details['PRODUCT_DESCRIPTION'] +' '+description
product_details['_collection'] = 'products'
product_details['EXTRACTED_ON'] = Time.now.to_s
outputs << product_details