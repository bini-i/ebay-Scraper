require 'nokogiri'
require 'httparty'
require 'open-uri'
require 'sinatra'
require_relative './lib/scraper'

class App < Sinatra::Base
  get '/' do
    erb :index
  end

  post '/search' do
    base_url_left = 'https://www.ebay.com/sch/i.html?_from=R40&_nkw='
    base_url_right = '&_sacat=0&rt=nc&LH_Auction=1&_sop=1'
    sc = Scraper.new(base_url_left, base_url_right)

    product_name = params['product_name']
    url = sc.construct_url(product_name)

    @products_arr = [sc.scrape(url)]
    pg_num = 1

    page_number_set = params['page_number'].to_i

    loop do
      new_url = sc.modify_url(url, pg_num)
      begin
        result = sc.scrape(new_url)
      rescue StandardError => e
        p "#{e.message} handled"
        break
      end

      break if pg_num == page_number_set

      @products_arr << result
      p "scraping page #{pg_num}"
      p new_url
      pg_num += 1
    end

    erb :search_result
  end
end
