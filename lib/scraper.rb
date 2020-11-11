require 'nokogiri'
require 'open-uri'

class Scraper
  attr_reader :base_url_left, :base_url_right

  def initialize(url_left, url_right)
    @base_url_left = url_left
    @base_url_right = url_right
  end

  def construct_url(product_name)
    arr = product_name.split
    product_name = arr.join('+')
    url = @base_url_left + product_name + @base_url_right
    url
  end

  def modify_url(url, pg_num)
    url + "&_pgn=#{pg_num}"
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
