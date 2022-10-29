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
	var lat: Double!
	var lon: Double!
	var coordinate: CLLocationCoordinate2D!
	
	//MARK: - LIVECYCLE
	override func viewDidLoad() {
		super.viewDidLoad()
		setupCoordinate()
		addCustomPin()
		setupMap()
		addSubview()
	}
	
	//MARK: - SETUP
	private func setupCoordinate() {
		lat = viewModel.lat
		lon = viewModel.lon
		coordinate = CLLocationCoordinate2D(latitude: self.lat, longitude: self.lon)
	}
	
	private func setupMap() {
		map.delegate = self
		map.setRegion(MKCoordinateRegion(center: coordinate,
																		 latitudinalMeters: 700,
																		 longitudinalMeters: 700),
									animated: false)
	}
	
	private func addCustomPin() {
		let pin = MKPointAnnotation()
		pin.coordinate = coordinate
		pin.title = "Your hotel"
		map.addAnnotation(pin)
	}
}


//MARK: - LAYOUT
private extension MapView {
	func addSubview() {
		view.addSubview(map)
		map.frame = view.bounds
	}
}

//MARK: - MKMapViewDelegate
extension MapView: MKMapViewDelegate {
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		guard !(annotation is MKUserLocation) else { return nil }
		var annotationView = map.dequeueReusableAnnotationView(withIdentifier: "custom")
		if annotationView == nil {
			annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
			annotationView?.canShowCallout = true
		} else {
			annotationView?.annotation = annotation
		}
		let pinImage = UIImage(named: "pin")
		annotationView?.image = pinImage
		annotationView?.frame.size = CGSize(width: 40, height: 40)
		return annotationView
	}
}


