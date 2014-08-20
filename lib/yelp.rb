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

		# last_updated = Business.where("yelp_url IS NOT NULL").order("id DESC").limit(1)
  # 	last_updated_id = last_updated[0][:id]

  	@businesses = Business.all.where({:yelp_url => nil})
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

			if search_result
				search_result_title = search_result.search("h3.search-result-title").text

				yelp_data = []

				if search_result_title.downcase.include? business_name.downcase || business_name.downcase.include? search_result_title.downcase
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

					unless yelp_data[0].nil? && yelp_data[1].nil?
						yelp_data.each do |yelp|
						  business.update(yelp)
						end
					end

					# puts yelp_data
				end
				# puts search_result_title
				# puts business_name + business_location
				# puts business.inspect
			end
		end
			 
	end

end