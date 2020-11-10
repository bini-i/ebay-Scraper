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
    base_url_right = '&_sacat=0&rt=nc&LH_Auction=1'
    sc = Scraper.new(base_url_left, base_url_right)

    product_name = params['product_name']
    url = sc.url_constructor(product_name)

    @products = sc.scrape(url)
    erb :search_result
  end
end
