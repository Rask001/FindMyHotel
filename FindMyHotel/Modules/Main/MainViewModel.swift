//
//  MainViewModel.swift
//  FindMyHotel
//
//  Created by Антон on 25.10.2022.
//

import Foundation
import UIKit

final class MainViewModel: MainViewModelProtocol {
	
	//MARK: - PROPERTY
	var networkService: NetworkServiceProtocol = NetworkService()
	let animations = Animations()
	var allert = AllertService()
	var hotels: [Hotel] = []
	
	//MARK: - ACTIONS
	func fetchHotelsForMainView(completion: @escaping () -> Void) {
		networkService.loadFromJsonFromURL(.getHotelsListUrl, [Hotel].self) { [weak self] result in
			guard let self else { return }
			self.hotels = result
			completion()
		}
	}
	
	func allert(notification: NSNotification) -> UIAlertController? {
		guard let userInfo = notification.userInfo else { return nil }
		guard let error = userInfo["error"] else { return nil }
		guard let textError: String = error as? String else { return nil }
		let allert = allert.allert(title: "Error", text: textError)
		return allert
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
