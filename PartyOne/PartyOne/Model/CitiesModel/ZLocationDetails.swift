//
//  ViewControllerViewModel.swift
//  PartyOne
//
//  Created by Vishnu on 26/11/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation

struct ZLocationDetails : Codable {
	let location_suggestions : [Location_suggestions]?
	let status : String?
	let has_more : Int?
	let has_total : Int?

	enum CodingKeys: String, CodingKey {

		case location_suggestions = "location_suggestions"
		case status = "status"
		case has_more = "has_more"
		case has_total = "has_total"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		location_suggestions = try values.decodeIfPresent([Location_suggestions].self, forKey: .location_suggestions)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		has_more = try values.decodeIfPresent(Int.self, forKey: .has_more)
		has_total = try values.decodeIfPresent(Int.self, forKey: .has_total)
	}

}
