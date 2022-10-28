//
//  Builder.swift
//  FindMyHotel
//
//  Created by Антон on 26.10.2022.
//

import Foundation
import UIKit

//MARK: - PROTOCOL
protocol BuilderProtocol {
	static func createMainView() -> UIViewController
	static func createDetailView(hotel: Hotel) -> UIViewController
}

//MARK: - CLASS
final class ModuleBuilder: BuilderProtocol {
	 
	static func createMainView() -> UIViewController {
		let view = MainView()
		return view
	}
	
	static func createDetailView(hotel: Hotel) -> UIViewController {
		let view = DetailView()
		let viewModel = DetailViewModel(hotel: hotel)
		view.viewModel = viewModel
		return view
	}
	
	static func createMapView(lat: Double, lon: Double) -> UIViewController {
		let view = MapView()
		let viewModel = MapViewModel(lat: lat, lon: lon)
		view.viewModel = viewModel
		return view
	}
}
