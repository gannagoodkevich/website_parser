require 'csv'
require 'nokogiri'
require 'open-uri'
require 'curb'
require_relative 'data_loader'
require_relative 'page_loader'

i=2

link  = ''
file = ''

ARGV.each do |argument|
  link = argument.gsub('--link=', '') if argument.include?('link')
  file = argument.gsub('--file=', '') if argument.include?('file')
end

puts 'Start processing'

#puts Curl.get("https://www.petsonic.com/snacks-huesos-para-perros/?p=#{i}").body_str.empty?
puts Curl.get("https://www.petsonic.com/snacks-huesos-para-perros/?p=7").body_str.empty?
about_products = Array.new();
while !Curl.get(link.concat("?p=#{i}")).body_str.empty? do
  puts link
  page_loader = PageLoader.new(link, file)
  page_loader.load_data_from_page
  link = link.gsub("?p=#{i}", '')
  puts link
  i+=10
  puts "page #{i}"
end
