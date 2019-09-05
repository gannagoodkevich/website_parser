class PageLoader
  attr_reader :about_products

  def initialize(url, file)
    @url = url
    @about_products = Array.new(0)
    @file = file
  end

  def load_data_from_page
    curr_page =  Curl.get(@url).body_str
    html_curr_page = Nokogiri::HTML(curr_page)
    html_curr_page.xpath('//a[@class="product-name"]/@href').each do |link|
      link.to_s.gsub(".html", "/")
      data_loader = DataLoader.new(link)
      data_loader.load_data
      write_info_to_csv(data_loader.date_about_product)
    end
  end

  def write_info_to_csv(date_about_product)
    CSV.open(@file, "a+") do |csv|
      index = 0
      date_about_product[:size].each do |size|
        size = size.insert(0, ' - ')
        csv << [date_about_product[:name] + size, date_about_product[:price][index], date_about_product[:img]]
        index+=1
      end
    end
  end
end
