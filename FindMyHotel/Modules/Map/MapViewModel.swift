//
//  MapViewModel.swift
//  FindMyHotel
//
//  Created by Антон on 27.10.2022.
//

import Foundation
import UIKit
import MapKit

final class MapViewModel: MapViewModelProtocol {
	
	//MARK: - PROPERTY
	var lat: Double
	var lon: Double
	var map: MKMapView
	
	required init(lat: Double, lon: Double, map: MKMapView) {
		self.lat = lat
		self.lon = lon
		self.map = map
	}
}
