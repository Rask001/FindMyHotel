//
//  HotelCellVMProtocol.swift
//  FindMyHotel
//
//  Created by Антон on 26.10.2022.
//

import UIKit

protocol HotelCellVMProtocol {
	
	var hotel: Hotel { get }
	var hotelWithStr: Hotel! { get }
	var hotelName: String { get }
	var hotelAdress: String { get }
	var distance: String { get }
	var suitsAvalibaleCount: String { get }
	var stars: String { get }
	var networkService: NetworkServiceProtocol { get }
	func fetchImage(completion: @escaping(UIImage) -> Void)
	
}
