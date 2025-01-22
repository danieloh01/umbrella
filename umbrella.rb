require "dotenv/load"
require "http"
require "json"

# pp ENV.fetch("PIRATE_WEATHER_KEY")
# pp ENV.fetch("GMAPS_KEY")

#start by hardcoding a string
# first goal is to set lattitude and longitude; then assemble pirate_weather url
# make invisible visible by printing things


pp "Where are you today?"

user_location = gets.chomp.gsub(" ","%20")

pp user_location.capitalize

maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GMAPS_KEY")

resp = HTTP.get(maps_url)
raw_response =  resp.to_s
parsed_response = JSON.parse(resp)
results = parsed_response.fetch("results")

first_result = results.at(0)
geo = first_result.fetch("geometry")
loc = geo.fetch("location")

latitude = loc.fetch("lat")
longitude = loc.fetch("lng")

pp "Your coordinates are #{latitude}, #{longitude}."

pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")
pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/" + latitude.to_s + "," + longitude.to_s

raw_response_weather = HTTP.get(pirate_weather_url)
parsed_response_weather = JSON.parse(raw_response_weather)
currently_hash = parsed_response_weather.fetch("currently")
current_temp = currently_hash.fetch("temperature")

next_hour_hash = parsed_response_weather.fetch("hourly")
first_hour_hash = next_hour_hash.fetch("data")
first_hour_hash_sub = first_hour_hash.at(1)
first_hour_temp = first_hour_hash_sub.fetch("temperature")

puts "It is currently #{current_temp} Fahrenheit."

puts "It will be #{first_hour_temp} Fahrenheit in one hour."

# require "ascii_charts"




# pp raw_response
# pp parsed_response
