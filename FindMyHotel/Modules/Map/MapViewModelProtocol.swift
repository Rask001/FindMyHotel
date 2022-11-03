//
//  MapViewModelProtocol.swift
//  FindMyHotel
//
//  Created by Антон on 27.10.2022.
//

import Foundation
import MapKit

//MARK: - PROTOCOL
protocol MapViewModelProtocol {
	var lat: Double { get }
	var lon: Double { get }
	var map: MKMapView { get }
}
