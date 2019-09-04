require 'csv'
require 'nokogiri'
require 'open-uri'
require 'curb'
require_relative 'data_loader'
require_relative 'page_loader'

CSV.open("b.csv", "w", :write_headers=> true, :headers => ["Name","Price","Image"]) do |csv|
  csv << [1, 2]
end

require 'open-uri'

i=2

#puts Curl.get("https://www.petsonic.com/snacks-huesos-para-perros/?p=#{i}").body_str.empty?

about_products = Array.new();

while !Curl.get("https://www.petsonic.com/snacks-huesos-para-perros/?p=#{i}").body_str.empty? do
  page_loader = PageLoader.new("https://www.petsonic.com/snacks-huesos-para-perros/?p=#{i}")
  page_loader.load_data_from_page
  i+=1
end

puts about_products.inspect
