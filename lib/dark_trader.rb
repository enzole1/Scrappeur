require 'nokogiri'
require 'open-uri'



page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

all_cryptocurrency = page.xpath('//td[@class ="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--sort-by__symbol"]/div')

 
cryptocurrency_value = page.xpath('//td[@class ="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price"]')

all_cryptocurrency_array = []
all_cryptocurrency.each do |name_crypto|
  name_crypto = name_crypto.text
  all_cryptocurrency_array << name_crypto
end

cryptocurrency_value_array = []
cryptocurrency_value.each do |price|
price = price.text.delete!("$").to_f
cryptocurrency_value_array << price
end

result = Hash[all_cryptocurrency_array.zip(cryptocurrency_value_array)]

puts  result

currency_array = []
currency_array << result.map {|key, value| {key => value}}
print currency_array