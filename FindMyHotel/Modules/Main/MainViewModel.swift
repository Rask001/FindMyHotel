//
//  MainViewModel.swift
//  FindMyHotel
//
//  Created by Антон on 25.10.2022.
//

import Foundation
import UIKit

class MainViewModel: MainViewModelProtocol {
	
	//MARK: - PROPERTY
	var networkService: GettingHotelProtocol = NetworkService()
	var hotels: [Hotel] = []
	
	//MARK: - ACTIONS
	func fetchHotelsForMainView(completion: @escaping () -> Void) {
		networkService.fetchHotelsArray(url: .getHotelsListUrl) { result in
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
	
	func cellViewModel(indexPath: IndexPath) -> HotelCellVMProtocol {
		let hotel = hotels[indexPath.row]
		return HotelCellViewModel(hotel: hotel)
	}
	
	func numberOfRows() -> Int {
		hotels.count
	}
}
