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
class ModuleBuilder: BuilderProtocol {
	 
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
}
