require 'rubygems'
require 'mechanize'
require 'open-uri'

class Yelp
	def self.scrape 

		agent = Mechanize.new

		url = "http://www.yelp.com/biz/aloha-cones-honolulu"
		page = agent.get(url)

		image = page.at(".showcase-photo-box a img")

		puts image.attributes["src"]

	end

	def self.fill_form

		agent = Mechanize.new

		agent.get("http://www.yelp.com")
		form = agent.page.forms[0]

		form["find_desc"] = "Turtle Bay Resort"
		form["find_loc"] = "Kahuku, HI 96731"

		agent.page.forms[0].submit

		search_result = agent.page.search("//div[@data-key='1']")
		search_result_title = search_result.search("h3.search-result-title").text

		if search_result_title.downcase.include? "Turtle Bay Resort".downcase
			avatar = search_result.at("div.media-avatar img").attributes["src"]
			yelp_url = search_result.at("div.media-avatar a").attributes["href"]
			unless avatar.include? 'http'
				avatar = 'http:' + avatar
			end
			unless yelp_url.include? 'yelp.com'
				yelp_url = 'http://www.yelp.com' + yelp_url
			end
			
		end
			 
		# puts search_result
		puts avatar
		puts yelp_url

	end

end