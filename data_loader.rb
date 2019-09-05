class DataLoader
  attr_reader :date_about_product

  def initialize(url)
    page_with_info =  Curl.get(url).body_str
    @html_page_with_info = Nokogiri::HTML(page_with_info)
    @date_about_product = Hash.new(0);
  end

  def load_data
   find_image
   find_price
   find_name
   find_size
  end

  def find_image
    @html_page_with_info.xpath('//img[@id="bigpic"]/@src').each do |img_link|
      @date_about_product[:img] = img_link.value
    end
  end

  def find_price
    prices = Array.new();
    @html_page_with_info.xpath('//span[@class="price_comb"]').each do |price|
      prices << price.content
    end
    @date_about_product[:price] = prices
  end

  def find_name
    @html_page_with_info.xpath('//h1[@class="product_main_name"]').each do |name|
      @date_about_product[:name] = name.content
    end
    puts  @date_about_product[:name]
  end

  def find_size
    sizes = Array.new();
    @html_page_with_info.xpath('//span[@class="radio_label"]').each do |size|
      sizes << size.content
    end
    @date_about_product[:size] = sizes
  end
end
