//
//  MainViewModel.swift
//  FindMyHotel
//
//  Created by Антон on 25.10.2022.
//

import Foundation
import UIKit

enum links {
	static var url: URL { URL(string: "https://raw.githubusercontent.com/iMofas/ios-android-test/master/0777.json")! }
}

protocol MainViewModelProtocol {
	var hotels: [Hotel] { get }
	var networkService: GettingHotelProtocol { get }
	func fetchHotels(completion: @escaping() -> Void)
	func numberOfRows() -> Int
}

class MainViewModel: MainViewModelProtocol {
	var networkService: GettingHotelProtocol = NetworkService()
	var hotels: [Hotel] = []
	
	func fetchHotels(completion: @escaping () -> Void) {
		networkService.fetchHotelsArray(item: links.url) { result in
			switch result {
			case .success(let data):
				self.hotels = data
				completion()
			case .failure(let error):
				print(error.localizedDescription)
				completion()
			}
		}
	}
	
	func numberOfRows() -> Int {
		hotels.count
	}
}
