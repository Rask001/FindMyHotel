//
//  MainViewModelProtocol.swift
//  FindMyHotel
//
//  Created by Антон on 26.10.2022.
//

import Foundation
import UIKit

//MARK: - PROTOCOL
protocol MainViewModelProtocol {
	var hotels: [Hotel] { get }
	func cellViewModel(indexPath: IndexPath) -> HotelCellVMProtocol
	var networkService: NetworkServiceProtocol { get }
	var animations: AnimationsProtocol { get }
	var allertService: AllertService { get }
	func allert(notification: NSNotification) -> UIAlertController?
	func fetchHotelsForMainView(completion: @escaping() -> Void)
	func numberOfRows() -> Int
	func sorted(tag: Int)
	func checkConnectStatus()
	func createDetailView(index: Int) -> UIViewController
}
