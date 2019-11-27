/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct User : Codable {
	let name : String?
	let foodie_level : String?
	let foodie_level_num : Int?
	let foodie_color : String?
	let profile_url : String?
	let profile_image : String?
	let profile_deeplink : String?

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case foodie_level = "foodie_level"
		case foodie_level_num = "foodie_level_num"
		case foodie_color = "foodie_color"
		case profile_url = "profile_url"
		case profile_image = "profile_image"
		case profile_deeplink = "profile_deeplink"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		foodie_level = try values.decodeIfPresent(String.self, forKey: .foodie_level)
		foodie_level_num = try values.decodeIfPresent(Int.self, forKey: .foodie_level_num)
		foodie_color = try values.decodeIfPresent(String.self, forKey: .foodie_color)
		profile_url = try values.decodeIfPresent(String.self, forKey: .profile_url)
		profile_image = try values.decodeIfPresent(String.self, forKey: .profile_image)
		profile_deeplink = try values.decodeIfPresent(String.self, forKey: .profile_deeplink)
	}

}