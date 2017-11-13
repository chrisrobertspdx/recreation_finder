require 'pry'
require 'nokogiri'
require 'open-uri'

require "recreation_finder/version"
require "recreation_finder/cli"
require "recreation_finder/facility"
require "recreation_finder/scraper"

module RecreationFinder
  def self.hello 
  	puts "I will help you find a cool place to recreate"
  end
end
