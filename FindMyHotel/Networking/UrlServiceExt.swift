//
//  UrlService.swift
//  FindMyHotel
//
//  Created by Антон on 26.10.2022.
//

import Foundation

extension URL {
	static var getHotelsListUrl: URL {
		URL(string: "https://raw.githubusercontent.com/iMofas/ios-android-test/master/0777.json")!
	}
	
	static func getHotelUrl(withID id: Int) -> URL {
		URL(string: "https://raw.githubusercontent.com/iMofas/ios-android-test/master/\(id).json")!
	}
	
	static func getImageUrl(withImageId id: String) -> URL {
		URL(string: "https://github.com/iMofas/ios-android-test/raw/master/\(id)")!
	}
}
