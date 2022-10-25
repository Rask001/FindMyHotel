//
//  Helper.swift
//  FindMyHotel
//
//  Created by Антон on 25.10.2022.
//

import Foundation

final class Helper {
	
	class func starsToString(stars: Double) -> String {
		switch stars {
		case 0:   return "☆ ☆ ☆ ☆ ☆"
		case 1.0: return "★ ☆ ☆ ☆ ☆"
		case 2.0: return "★ ★ ☆ ☆ ☆"
		case 3.0: return "★ ★ ★ ☆ ☆"
		case 4.0: return "★ ★ ★ ★ ☆"
		case 5.0: return "★ ★ ★ ★ ★"
		default: return "check the JSON, maybe it will change"
		}
	}
}
