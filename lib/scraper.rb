class Scraper
  def initialize(url_left, url_right)
    @base_url_left = url_left
    @base_url_right = url_right
  end

  def url_constructor(product_name)
    arr = product_name.split()
    product_name = arr.join('+')
    url = @base_url_left + product_name + @base_url_right
    url
  end

  def scrape(url)
    doc = fetch(url)
    doc.css('#mainContent #srp-river-results .s-item')
  end

  private

  def fetch(url)
    Nokogiri::HTML(URI.open(url))
  end
end
