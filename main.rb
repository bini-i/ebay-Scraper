#! /usr/bin/env ruby

require 'nokogiri'
require 'httparty'
require 'open-uri'
require 'sinatra'

def fetch(url)
  Nokogiri::HTML(URI.open(url))
end

def scraper(url)
  doc = fetch(url)

  doc.css('#mainContent #srp-river-results .s-item')
end

url_left = 'https://www.ebay.com/sch/i.html?_from=R40&_trksid=m570.l1313&_nkw='
url_right = '&_sacat=0'

# routes
get '/' do
    erb :index
end

post '/search' do
    product_name = params['product_name']
    arr = product_name.split()
    product_name = arr.join('+')
    url = url_left + product_name + url_right
    @products = scraper(url)
    erb :search_result
end