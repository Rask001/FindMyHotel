//
//  DetailViewModelProtocol.swift
//  FindMyHotel
//
//  Created by Антон on 26.10.2022.
//

import UIKit

protocol DetailViewModelProtocol {
	
	var hotel: Hotel { get }
	var hotelName: String { get }
	var hotelAdress: String { get }
	var distance: String { get }
	var stars: String { get }
	var networkService: GettingHotelProtocol { get }
	func fetchImage(completion: @escaping(UIImage) -> Void)
	func fetchHotelForDetailView(completion: @escaping() -> Void)
	func numberOfRows() -> Int
	
}
