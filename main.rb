require 'nokogiri'
require 'httparty'
require 'open-uri'
require 'sinatra'
require_relative './lib/scraper'
require 'byebug'

# routes
class App < Sinatra::Base
  get '/' do
    erb :index
  end

  post '/search' do
    # https://www.ebay.com/sch/i.html?_from=R40&_trksid=m570.l1313&_nkw=led+battery&_sacat=0&rt=nc&LH_Auction=1&_pgn=2
    base_url_left = 'https://www.ebay.com/sch/i.html?_from=R40&_trksid=m570.l1313&_nkw='
    base_url_right = '&_sacat=0&rt=nc&LH_Auction=1&_sop=1'
    sc = Scraper.new(base_url_left, base_url_right)

    product_name = params['product_name']
    url = sc.url_constructor(product_name)

    @products = [sc.scrape(url)]
    pg_num = 1

    loop do
      url << "&_pgn=#{pg_num}"
      # debugger
      result = sc.scrape(url)
      break if pg_num == 6
      @products << result
      p "scraping page #{pg_num}"
      pg_num += 1
    end

    erb :search_result
  end
end
