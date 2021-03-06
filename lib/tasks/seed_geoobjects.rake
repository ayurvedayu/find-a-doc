namespace :db do

	desc 'seed cities from geonames.org'
	task :seed_geoobjects => :environment do
		begin
			doc = Nokogiri::HTML(open("http://api.geonames.org/search?country=IN&username=ayurvedayu&cities=cities15000"))
		rescue SocketError => e
			puts 'no internet connection - unable to seed cities'
		end
		
		Spree::City.delete_all

		doc.xpath('//toponymname').each do |line|
			Spree::City.create name: line.text
		end
	end
end