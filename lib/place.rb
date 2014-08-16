require 'mechanize'

class Place
  def self.scrape 

    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'
    
    url = "http://factual.com/data/t/places#filters=%7B%22$and%22:%5B%7B%22country%22:%7B%22$eq%22:%22US%22%7D%7D,%7B%22region%22:%7B%22$eq%22:%22hi%22%7D%7D%5D%7D"
    page = agent.get(url)

    results = page.at(".results").text

    places = []
    rows = page.search(".slick-row")

    rows.each do |row|
      name = row.at(".li.r1").text
      places.push(name)
    end
    
    puts rows.inspect
    puts places.inspect
    puts results.inspect

  end 
end