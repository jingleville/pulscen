# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


10.times do |i|
	page = Page.new(name: "page_#{i}", title: FFaker::Lorem.phrase, body: FFaker::HTMLIpsum.body, path: "page_#{i}")
	page.save!
	3.times do |j|
		page.children.create(name: "page_#{i}_#{j}", title: FFaker::Lorem.phrase, body: FFaker::HTMLIpsum.body, path: page.path + '/' + "page_#{i}_#{j}")
	end
end