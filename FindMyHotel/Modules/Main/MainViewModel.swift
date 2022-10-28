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
	var animations = Animations()
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
	
	func sorted(tag: Int) {
		switch tag {
		case 0: hotels.sort { $1.stars < $0.stars }
		case 1: hotels.sort { $1.distance > $0.distance }
		case 2: hotels.sort { $1.suitesArray.count < $0.suitesArray.count }
		default: print("check buttonSortName in MainView")
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
