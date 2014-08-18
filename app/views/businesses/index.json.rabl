collection @businesses

attributes :longitude, :latitude

node do |business|
  {:full_address => business.name.to_s + ", " + business.address.to_s + ", " + business.locality.to_s + ", HI " + business.postcode.to_s}
end