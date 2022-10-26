//
//  MainViewModelProtocol.swift
//  FindMyHotel
//
//  Created by Антон on 26.10.2022.
//

import Foundation

protocol MainViewModelProtocol {
	
	var hotels: [Hotel] { get }
	func cellViewModel(indexPath: IndexPath) -> HotelCellVMProtocol
	var networkService: GettingHotelProtocol { get }
	func fetchHotelsForMainView(completion: @escaping() -> Void)
	func numberOfRows() -> Int
	
}
