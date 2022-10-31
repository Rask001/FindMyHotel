//
//  MapView.swift
//  FindMyHotel
//
//  Created by Антон on 27.10.2022.
//

import Foundation
import MapKit
import CoreLocation

final class MapView: UIViewController {
	
	//MARK: - CONSTANTS
	private enum Constants {
		static let pinImage =	UIImage(named: "pin")
		static let hotelPinText = "Your hotel"
		static let annotationViewIdentifier = "custom"
		static let annotationViewSize = CGSize(width: 40, height: 40)
	}
	
	//MARK: - PROPERTY
	var viewModel: MapViewModelProtocol!
	private let map = MKMapView()
	private var lat: Double!
	private var lon: Double!
	private var coordinate: CLLocationCoordinate2D!
	
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
		coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
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
		pin.title = Constants.hotelPinText
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
		var annotationView = map.dequeueReusableAnnotationView(withIdentifier: Constants.annotationViewIdentifier)
		if annotationView == nil {
			annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: Constants.annotationViewIdentifier)
			annotationView?.canShowCallout = true
		} else {
			annotationView?.annotation = annotation
		}
		let pinImage = Constants.pinImage
		annotationView?.image = pinImage
		annotationView?.frame.size = Constants.annotationViewSize
		return annotationView
	}
}
