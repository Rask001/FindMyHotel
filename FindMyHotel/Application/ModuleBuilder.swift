//
//  Builder.swift
//  FindMyHotel
//
//  Created by Антон on 26.10.2022.
//

import Foundation
import UIKit
import MapKit

//MARK: - PROTOCOL
protocol ModuleBuilderProtocol {
	func createMainView() -> UIViewController
	func createDetailView(hotel: Hotel) -> UIViewController
	func createMapView(lat: Double, lon: Double) -> UIViewController
}

//MARK: - CLASS
final class ModuleBuilder: ModuleBuilderProtocol {
	func createMainView() -> UIViewController {
		let hotels = [Hotel]()
		let networkService = NetworkService()
		let animations = Animations()
		let allertService = AllertService()
		let builder = ModuleBuilder()
		let view = MainView()
		
		let viewModel = MainViewModel(hotels: hotels, networkService: networkService, animations: animations, allertService: allertService, builder: builder)
		view.viewModel = viewModel
		return view
	}
	
	func createDetailView(hotel: Hotel) -> UIViewController {
		let view = DetailView()
		let networkService = NetworkService()
		let builder = ModuleBuilder()
		let imageDownloader = ImageDownloader()
		let viewModel = DetailViewModel(hotel: hotel, networkService: networkService, imageDownloader: imageDownloader, modulBuilder: builder)
		view.viewModel = viewModel
		return view
	}
	
	func createMapView(lat: Double, lon: Double) -> UIViewController {

		let map = MKMapView()
		let view = MapView()
		let viewModel = MapViewModel(lat: lat, lon: lon, map: map)
		view.viewModel = viewModel
		return view
	}
}
