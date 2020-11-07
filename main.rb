#! /usr/bin/env ruby

require 'nokogiri'
require 'httparty'
require 'open-uri'

def fetch (url) 
    Nokogiri::HTML(open(url))
end

url = "https://www.ebay.com/sch/i.html?_from=R40&_trksid=m570.l1313&_nkw=iphone+11&_sacat=0"

p fetch(url)
