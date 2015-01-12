namespace :db do

	desc 'seed cities from geonames.org'
	task :seed_geoobjects => :environment do
		
		doc = Nokogiri::HTML(open("http://api.geonames.org/search?country=IN&username=ayurvedayu&cities=cities15000"))
		doc.xpath('//toponymname').each do |line|
			Spree::City.create name: line.text
		end
	end
end