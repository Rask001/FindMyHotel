//
//  MainViewModelProtocol.swift
//  FindMyHotel
//
//  Created by Антон on 26.10.2022.
//

import Foundation

//MARK: - PROTOCOL
protocol MainViewModelProtocol {
	var hotels: [Hotel] { get }
	func cellViewModel(indexPath: IndexPath) -> HotelCellVMProtocol
	var networkService: NetworkServiceProtocol { get }
	var animations: Animations { get }
	func fetchHotelsForMainView(completion: @escaping() -> Void)
	func numberOfRows() -> Int
	func sorted(tag: Int)
}
