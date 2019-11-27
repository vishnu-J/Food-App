/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct User_rating : Codable {
	let aggregate_rating : String?
	let rating_text : String?
	let rating_color : String?
	let rating_obj : Rating_obj?
	let votes : String?

	enum CodingKeys: String, CodingKey {

		case aggregate_rating = "aggregate_rating"
		case rating_text = "rating_text"
		case rating_color = "rating_color"
		case rating_obj = "rating_obj"
		case votes = "votes"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		aggregate_rating = try values.decodeIfPresent(String.self, forKey: .aggregate_rating)
		rating_text = try values.decodeIfPresent(String.self, forKey: .rating_text)
		rating_color = try values.decodeIfPresent(String.self, forKey: .rating_color)
		rating_obj = try values.decodeIfPresent(Rating_obj.self, forKey: .rating_obj)
		votes = try values.decodeIfPresent(String.self, forKey: .votes)
	}

}