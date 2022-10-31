//
//  DetailViewModelProtocol.swift
//  FindMyHotel
//
//  Created by Антон on 26.10.2022.
//

import UIKit

//MARK: - PROTOCOL
protocol DetailViewModelProtocol {
	
	var hotel: Hotel { get }
	var hotelName: String { get }
	var hotelAdress: String { get }
	var distance: String { get }
	var stars: String { get }
	var lat: Double? { get }
	var lon: Double? { get }
	var image: String? { get }
	var networkService: NetworkServiceProtocol { get }
	var imageDownloader: ImageDownloaderProtocol { get }
	func downloadImage(completion: @escaping(UIImage) -> Void)
	func fetchHotelForDetailView(completion: @escaping() -> Void)
	func numberOfRows() -> Int
}
