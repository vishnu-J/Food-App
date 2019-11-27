/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Popularity : Codable {
	let popularity : String?
	let nightlife_index : String?
	let nearby_res : [String]?
	let top_cuisines : [String]?
	let popularity_res : String?
	let nightlife_res : String?
	let subzone : String?
	let subzone_id : Int?
	let city : String?

	enum CodingKeys: String, CodingKey {

		case popularity = "popularity"
		case nightlife_index = "nightlife_index"
		case nearby_res = "nearby_res"
		case top_cuisines = "top_cuisines"
		case popularity_res = "popularity_res"
		case nightlife_res = "nightlife_res"
		case subzone = "subzone"
		case subzone_id = "subzone_id"
		case city = "city"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		popularity = try values.decodeIfPresent(String.self, forKey: .popularity)
		nightlife_index = try values.decodeIfPresent(String.self, forKey: .nightlife_index)
		nearby_res = try values.decodeIfPresent([String].self, forKey: .nearby_res)
		top_cuisines = try values.decodeIfPresent([String].self, forKey: .top_cuisines)
		popularity_res = try values.decodeIfPresent(String.self, forKey: .popularity_res)
		nightlife_res = try values.decodeIfPresent(String.self, forKey: .nightlife_res)
		subzone = try values.decodeIfPresent(String.self, forKey: .subzone)
		subzone_id = try values.decodeIfPresent(Int.self, forKey: .subzone_id)
		city = try values.decodeIfPresent(String.self, forKey: .city)
	}

}