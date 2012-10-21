require 'xmlsimple'
require 'rqrcode'

class QrcodegeneratorController < ApplicationController

	def index

		@buildingForView = "78"
		@roomsForView = []

		config = XmlSimple.xml_in('public/buildingData.xml', { 'KeyAttr' => 'name' })

		for i in 0...config['building'].length
			#puts config['building'][i]['name'][0]
			if config['building'][i]['name'][0] == "General Purpose South"
				#For each room in the building, get it and put it into the hash
				for j in 0...config['building'][i]['rooms'][0]['room'].length
					#puts "**********" + i.to_s
					#puts config['building'][i]['rooms'][0]['room'][j]
					#Put the room number onto the stack
					newHash = {}
					newHash['roomNo'] = config['building'][i]['rooms'][0]['room'][j]
					newHash['qrCode'] = RQRCode::QRCode.new('http://wit.emilevictor.com/index.html?b='+config['building'][i]['number'][0]+'&r='+config['building'][i]['rooms'][0]['room'][j]+'&c=STLUC', :size => 7, :level => :h)



					@roomsForView.push(newHash)
				end

			end


		end
	end
end
