require 'csv'
require 'nokogiri'
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
file.concat('.csv')
File.open(file, 'w') {|file| file.truncate(0) }
puts 'Start processing'
about_products = Array.new();
puts 'In progress ' << link << ' page'
page_loader = PageLoader.new(link, file)
page_loader.load_data_from_page
while !Curl.get(link.concat("?p=#{i}")).body_str.empty? do
  puts 'In progress ' << link << ' page'
  page_loader = PageLoader.new(link, file)
  page_loader.load_data_from_page
  link = link.gsub("?p=#{i}", '')
  i+=1
end
puts 'work is done. I maked it:)'
