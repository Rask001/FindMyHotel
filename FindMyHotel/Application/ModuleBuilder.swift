//
//  Builder.swift
//  FindMyHotel
//
//  Created by Антон on 26.10.2022.
//

import Foundation
import UIKit

//MARK: - PROTOCOL
protocol ModuleBuilderProtocol {
	func createMainView() -> UIViewController
	func createDetailView(hotel: Hotel) -> UIViewController
	func createMapView(lat: Double, lon: Double) -> UIViewController
}

//MARK: - CLASS
final class ModuleBuilder: ModuleBuilderProtocol {
	
	func createMainView() -> UIViewController {
		let view = MainView()
		return view
	}
	
	func createDetailView(hotel: Hotel) -> UIViewController {
		let view = DetailView()
		let viewModel = DetailViewModel(hotel: hotel)
		view.viewModel = viewModel
		return view
	}
	
	func createMapView(lat: Double, lon: Double) -> UIViewController {
		let view = MapView()
		let viewModel = MapViewModel(lat: lat, lon: lon)
		view.viewModel = viewModel
		return view
	}
}
