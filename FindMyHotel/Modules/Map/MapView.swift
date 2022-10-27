//
//  MapView.swift
//  FindMyHotel
//
//  Created by Антон on 27.10.2022.
//

import Foundation
import MapKit
import CoreLocation

class MapView: UIViewController {
	
	//MARK: - PROPERTY
	var viewModel: MapViewModelProtocol!
	let map = MKMapView()
	let coordination = CLLocationCoordinate2D(latitude: 40.728,
																						longitude: -74)
	
		//MARK: - LIVECYCLE
		override func viewDidLoad() {
			super.viewDidLoad()
			addSubview()
			layout()
		}
		
		//MARK: - SETUP
		
		
		
		//MARK: - LAYOUT
		private func addSubview() {
			self.view.addSubview(map)
			map.frame = view.bounds
		}
		
		private func layout() {
			
		}
	}

	
