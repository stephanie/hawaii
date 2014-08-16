
require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = "http://factual.com/data/t/places#filters=%7B%22$and%22:%5B%7B%22country%22:%7B%22$eq%22:%22US%22%7D%7D,%7B%22region%22:%7B%22$eq%22:%22hi%22%7D%7D%5D%7D"
page = Nokogiri::HTML(open(url))

puts page.at_css("title").text
