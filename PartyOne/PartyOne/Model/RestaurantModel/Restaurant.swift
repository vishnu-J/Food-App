/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Restaurant : Codable {
	let r : R?
	let apiapikey : String?
	let id : String?
	let name : String?
	let url : String?
	let location : Location?
	let switch_to_order_menu : Int?
	let cuisines : String?
	let average_cost_for_two : Int?
	let price_range : Int?
	let currency : String?
	let offers : [String]?
	let opentable_support : Int?
	let is_zomato_book_res : Int?
	let mezzo_provider : String?
	let is_book_form_web_view : Int?
	let book_form_web_view_url : String?
	let book_again_url : String?
	let thumb : String?
	let user_rating : User_rating?
	let photos_url : String?
	let menu_url : String?
	let featured_image : String?
	let has_online_delivery : Int?
	let is_delivering_now : Int?
	let include_bogo_offers : Bool?
	let deeplink : String?
	let is_table_reservation_supported : Int?
	let has_table_booking : Int?
	let events_url : String?

	enum CodingKeys: String, CodingKey {

		case r = "R"
		case apiapikey = "apikey"
		case id = "id"
		case name = "name"
		case url = "url"
		case location = "location"
		case switch_to_order_menu = "switch_to_order_menu"
		case cuisines = "cuisines"
		case average_cost_for_two = "average_cost_for_two"
		case price_range = "price_range"
		case currency = "currency"
		case offers = "offers"
		case opentable_support = "opentable_support"
		case is_zomato_book_res = "is_zomato_book_res"
		case mezzo_provider = "mezzo_provider"
		case is_book_form_web_view = "is_book_form_web_view"
		case book_form_web_view_url = "book_form_web_view_url"
		case book_again_url = "book_again_url"
		case thumb = "thumb"
		case user_rating = "user_rating"
		case photos_url = "photos_url"
		case menu_url = "menu_url"
		case featured_image = "featured_image"
		case has_online_delivery = "has_online_delivery"
		case is_delivering_now = "is_delivering_now"
		case include_bogo_offers = "include_bogo_offers"
		case deeplink = "deeplink"
		case is_table_reservation_supported = "is_table_reservation_supported"
		case has_table_booking = "has_table_booking"
		case events_url = "events_url"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		r = try values.decodeIfPresent(R.self, forKey: .r)
		apiapikey = try values.decodeIfPresent(String.self, forKey: .apiapikey)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		location = try values.decodeIfPresent(Location.self, forKey: .location)
		switch_to_order_menu = try values.decodeIfPresent(Int.self, forKey: .switch_to_order_menu)
		cuisines = try values.decodeIfPresent(String.self, forKey: .cuisines)
		average_cost_for_two = try values.decodeIfPresent(Int.self, forKey: .average_cost_for_two)
		price_range = try values.decodeIfPresent(Int.self, forKey: .price_range)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		offers = try values.decodeIfPresent([String].self, forKey: .offers)
		opentable_support = try values.decodeIfPresent(Int.self, forKey: .opentable_support)
		is_zomato_book_res = try values.decodeIfPresent(Int.self, forKey: .is_zomato_book_res)
		mezzo_provider = try values.decodeIfPresent(String.self, forKey: .mezzo_provider)
		is_book_form_web_view = try values.decodeIfPresent(Int.self, forKey: .is_book_form_web_view)
		book_form_web_view_url = try values.decodeIfPresent(String.self, forKey: .book_form_web_view_url)
		book_again_url = try values.decodeIfPresent(String.self, forKey: .book_again_url)
		thumb = try values.decodeIfPresent(String.self, forKey: .thumb)
		user_rating = try values.decodeIfPresent(User_rating.self, forKey: .user_rating)
		photos_url = try values.decodeIfPresent(String.self, forKey: .photos_url)
		menu_url = try values.decodeIfPresent(String.self, forKey: .menu_url)
		featured_image = try values.decodeIfPresent(String.self, forKey: .featured_image)
		has_online_delivery = try values.decodeIfPresent(Int.self, forKey: .has_online_delivery)
		is_delivering_now = try values.decodeIfPresent(Int.self, forKey: .is_delivering_now)
		include_bogo_offers = try values.decodeIfPresent(Bool.self, forKey: .include_bogo_offers)
		deeplink = try values.decodeIfPresent(String.self, forKey: .deeplink)
		is_table_reservation_supported = try values.decodeIfPresent(Int.self, forKey: .is_table_reservation_supported)
		has_table_booking = try values.decodeIfPresent(Int.self, forKey: .has_table_booking)
		events_url = try values.decodeIfPresent(String.self, forKey: .events_url)
	}

}
