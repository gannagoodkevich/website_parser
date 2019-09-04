class PageLoader
  def initialize(url)
    @url = url
    @about_products = Array.new(0)
  end

  def load_data_from_page
    curr_page =  Curl.get(@url).body_str
    html_curr_page = Nokogiri::HTML(curr_page)
    html_curr_page.xpath('//a[@class="product-name"]/@href').each do |link|
      link.to_s.gsub(".html", "/")
      data_loader = DataLoader.new(link)
      data_loader.load_data
      @about_products << data_loader.date_about_product
    end
    puts @about_products
  end
end
