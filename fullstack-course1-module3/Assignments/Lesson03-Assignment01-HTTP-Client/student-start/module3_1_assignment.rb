require 'httparty'

class Recipe

	include HTTParty

	base_uri 'http://food2fork.com/api'
	default_params key: "#{ENV.fetch "FOOD2FORK_KEY"}"
	format :json

	def self.for(term)
		response = get('/search', query: {q: term})['recipes']
	end

end

# Recipe.for("chocolate")
