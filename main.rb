#! /usr/bin/env ruby

require 'nokogiri'
require 'httparty'
require 'open-uri'

def fetch (url) 
    Nokogiri::HTML(open(url))
end

def scraper(url)
    doc = fetch(url)

    doc.css('#mainContent #srp-river-results .s-item__info');
end

def display_product(doc)
    doc.each_with_index do |item, indx|
        puts "*********************"
        # product name
        product_name = item.at_css('.s-item__title').text
        puts "#{indx} + product name = #{product_name}"
        
        # condition
        condition = item.at_css('.SECONDARY_INFO').text
        puts "condition = #{condition}"
        
        # price
        price = item.at_css('.s-item__price').text
        puts "price = #{price}"
        
        # bid count
        bid_count = item.at_css('.s-item__bidCount')
        bid_count = bid_count.text unless bid_count.nil?
        puts "bid count = #{bid_count}"
        
        # bid time left
        bid_time_left = item.at_css('.s-item__time-left')
        bid_time_left = bid_time_left.text unless bid_time_left.nil?
        puts "bid time left = #{bid_time_left}"
        
        # location
        location = item.at_css('.s-item__location').text
        puts "location = #{location}"
        
        # shipping cost
        shipping_cost = item.at_css('.s-item__shipping').text
        puts "shipping cost = #{shipping_cost}"
    end
end

url = "https://www.ebay.com/sch/i.html?_from=R40&_trksid=m570.l1313&_nkw=iphone+11&_sacat=0"

doc = scraper(url)

puts doc.count

gets

display_product(doc)