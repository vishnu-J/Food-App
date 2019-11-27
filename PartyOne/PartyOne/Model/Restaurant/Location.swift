/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Location : Codable {
	let address : String?
	let locality : String?
	let city : String?
	let city_id : Int?
	let latitude : String?
	let longitude : String?
	let zipcode : String?
	let country_id : Int?
	let locality_verbose : String?

	enum CodingKeys: String, CodingKey {

		case address = "address"
		case locality = "locality"
		case city = "city"
		case city_id = "city_id"
		case latitude = "latitude"
		case longitude = "longitude"
		case zipcode = "zipcode"
		case country_id = "country_id"
		case locality_verbose = "locality_verbose"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		locality = try values.decodeIfPresent(String.self, forKey: .locality)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		city_id = try values.decodeIfPresent(Int.self, forKey: .city_id)
		latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
		zipcode = try values.decodeIfPresent(String.self, forKey: .zipcode)
		country_id = try values.decodeIfPresent(Int.self, forKey: .country_id)
		locality_verbose = try values.decodeIfPresent(String.self, forKey: .locality_verbose)
	}

}