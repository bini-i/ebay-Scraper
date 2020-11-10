require 'nokogiri'
require 'httparty'
require 'open-uri'
require 'sinatra'
require_relative './lib/scraper'

# routes
class App < Sinatra::Base
  get '/' do
    erb :index
  end

  post '/search' do
    base_url_left = 'https://www.ebay.com/sch/i.html?_from=R40&_trksid=m570.l1313&_nkw='
    base_url_right = '&_sacat=0&rt=nc&LH_Auction=1&_sop=1'
    sc = Scraper.new(base_url_left, base_url_right)

    product_name = params['product_name']
    url = sc.construct_url(product_name)

    @products = [sc.scrape(url)]
    pg_num = 1

    loop do
      new_url = sc.modify_url(url, pg_num)
      result = sc.scrape(url)
      break if pg_num == 15

      @products << result
      p "scraping page #{pg_num}"
      pg_num += 1
    end

    erb :search_result
  end
end
