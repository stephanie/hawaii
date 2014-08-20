require 'rubygems'
require 'mechanize'
require 'open-uri'
require 'similar_text'

class Yelp
	def self.scrape 

		agent = Mechanize.new

		url = "http://www.yelp.com/biz/aloha-cones-honolulu"
		page = agent.get(url)

		image = page.at(".showcase-photo-box a img")

		puts image.attributes["src"]

	end

	def self.fill_form

		# last_updated = Business.where("yelp_url IS NOT NULL").order("id DESC").limit(1)
  # 	last_updated_id = last_updated[0][:id]

  	@businesses = Business.all.where({:id => 37}) #for testing
  	# @businesses = Business.all.where({:yelp_url => nil}).order("id ASC")
		# @businesses = Business.where({:yelp_url => nil}).where("id > ?", last_updated_id).order(:id)

		@businesses.each do |business|

			agent = Mechanize.new

			agent.get("http://www.yelp.com")
			form = agent.page.forms[0]

			business_name = business["name"]
			business_location = business["address"].to_s + ", " + business["locality"].to_s + ", HI " + business["postcode"].to_s

			form["find_desc"] = business_name
			form["find_loc"] = business_location

			begin 
				agent.page.forms[0].submit
			rescue Mechanize::ResponseCodeError => e
				puts "Error: " + e.response_code
			end			

			search_result = agent.page.search("//div[@data-key='1']")
			search_result2 = agent.page.search("//div[@data-key='2']")
			yelp_result1 = search_yelp_results(search_result, business)

			if yelp_result1
				puts 'match in result 1'
				yelp_result1.each do |yelp|
				  business.update(yelp)
				end
			else
				yelp_result2 = search_yelp_results(search_result2, business)
				if yelp_result2
					puts 'match in result 2'
					yelp_result2.each do |yelp|
					  business.update(yelp)
					end
				end
			end

		end

	end

	private

	def self.search_yelp_results(search_result, business)
		search_result_title = search_result.search("h3.search-result-title").text

		yelp_data = []
		search_result_title = search_result_title.downcase.squish
		search_result_title.slice!(0..2)
		business_name = business["name"]
		business_name = business_name.downcase

		puts business_name.similar(search_result_title)

		if search_result_title.include? business_name or business_name.include? search_result_title
			avatar = search_result.at("div.media-avatar img").attributes["src"]
			yelp_url = search_result.at("div.media-avatar a").attributes["href"]
			unless avatar.include? 'http'
				avatar = 'http:' + avatar
			end
			unless yelp_url.include? 'yelp.com'
				yelp_url = 'http://www.yelp.com' + yelp_url
			end

			yelp_data.push({
				yelp_avatar: avatar,
				yelp_url: yelp_url
			})

		end
		puts search_result_title
		puts business_name
		puts business.inspect

		unless yelp_data[0].nil? && yelp_data[1].nil?
			yelp_data 
		end

	end

end