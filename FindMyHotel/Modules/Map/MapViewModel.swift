//
//  MapViewModel.swift
//  FindMyHotel
//
//  Created by Антон on 27.10.2022.
//

import Foundation
import UIKit

final class MapViewModel: MapViewModelProtocol {
	
	//MARK: - PROPERTY
	var lat: Double
	var lon: Double
	
	required init(lat: Double, lon: Double) {
		self.lat = lat
		self.lon = lon
	}
}
