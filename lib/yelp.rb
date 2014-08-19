require 'mechanize'

class Yelp
  def self.scrape 

    agent = Mechanize.new

    url = "http://www.yelp.com/biz/aloha-cones-honolulu"
    page = agent.get(url)

    image = page.at(".showcase-photo-box a img")
    
    puts image.attributes["src"]

  end 
end