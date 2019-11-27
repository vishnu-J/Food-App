 //
 //  ViewControllerViewModel.swift
 //  PartyOne
 //
 //  Created by Vishnu on 26/11/19.
 //  Copyright © 2019 GreedyGame. All rights reserved.
 //

import Foundation
 
struct Location_suggestions : Codable {
	let id : Int?
	let name : String?
	let country_id : Int?
	let country_name : String?
	let country_flag_url : String?
	let should_experiment_with : Int?
	let has_go_out_tab : Int?
	let discovery_enabled : Int?
	let has_new_ad_format : Int?
	let is_state : Int?
	let state_id : Int?
	let state_name : String?
	let state_code : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case country_id = "country_id"
		case country_name = "country_name"
		case country_flag_url = "country_flag_url"
		case should_experiment_with = "should_experiment_with"
		case has_go_out_tab = "has_go_out_tab"
		case discovery_enabled = "discovery_enabled"
		case has_new_ad_format = "has_new_ad_format"
		case is_state = "is_state"
		case state_id = "state_id"
		case state_name = "state_name"
		case state_code = "state_code"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		country_id = try values.decodeIfPresent(Int.self, forKey: .country_id)
		country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
		country_flag_url = try values.decodeIfPresent(String.self, forKey: .country_flag_url)
		should_experiment_with = try values.decodeIfPresent(Int.self, forKey: .should_experiment_with)
		has_go_out_tab = try values.decodeIfPresent(Int.self, forKey: .has_go_out_tab)
		discovery_enabled = try values.decodeIfPresent(Int.self, forKey: .discovery_enabled)
		has_new_ad_format = try values.decodeIfPresent(Int.self, forKey: .has_new_ad_format)
		is_state = try values.decodeIfPresent(Int.self, forKey: .is_state)
		state_id = try values.decodeIfPresent(Int.self, forKey: .state_id)
		state_name = try values.decodeIfPresent(String.self, forKey: .state_name)
		state_code = try values.decodeIfPresent(String.self, forKey: .state_code)
	}

}
