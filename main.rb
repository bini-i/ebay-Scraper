require 'nokogiri'
require 'httparty'
require 'open-uri'
require 'sinatra'
require_relative './lib/scraper'
# require 'byebug'

# routes
class App < Sinatra::Base
  get '/' do
    erb :index
  end

  post '/search' do
    base_url_left = 'https://www.ebay.com/sch/i.html?_from=R40&_trksid=p2380057.m570.l1313&_nkw='
    base_url_right = '&_sacat=0&rt=nc&LH_Auction=1&_sop=1'
    sc = Scraper.new(base_url_left, base_url_right)

    product_name = params['product_name']
    url = sc.construct_url(product_name)

    @products = [sc.scrape(url)]
    pg_num = 1
    # debugger
    page_number_set = params['page_number'].to_i

    loop do
      new_url = sc.modify_url(url, pg_num)
      begin
        result = sc.scrape(new_url)
      rescue StandardError => e
        p "#{e} handled"
        break
      end

      break if pg_num == page_number_set

      @products << result
      p "scraping page #{pg_num}"
      p new_url
      # p @products[pg_num-1].at_css('.s-item__title').text
      pg_num += 1
    end

    erb :search_result
  end
end
