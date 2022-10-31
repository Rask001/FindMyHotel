//
//  DetailView.swift
//  FindMyHotel
//
//  Created by Антон on 26.10.2022.
//

import Foundation

import UIKit

//MARK: - VIEW
final class DetailView: UIViewController {
	
	//MARK: - CONSTANTS
	private enum Constants {
		static let hotelNameFont: UIFont = UIFont(name: "Helvetica Neue Medium", size: 20)!
		static let distanceNameFont: UIFont = UIFont(name: "Helvetica Neue", size: 16)!
		static let starsSize: UIFont = UIFont(name: "Helvetica Neue", size: 28)!
		static let imageHotel =	UIImage(named: "Hotel")
		static let mapImage =	UIImage(named: "Map")
		static let mapLabelText = "Open map"
	}
	
	//MARK: - SizeConstants
	private enum Size {
		static let stackViewSpacing: CGFloat = 10
		static let stackViewCornerRadius: CGFloat = 7
		static let mapViewImageCornerRadius: CGFloat = 7
		static let mapViewImageBorderWidth: CGFloat = 3
		static let tapLabelCornerRadius: CGFloat = 5
	}
	
	//MARK: - PROPERTY
	private let imageView = UIImageView()
	private let mapViewImage = UIImageView()
	private let spinnerView = UIView()
	private var spinner = UIActivityIndicatorView()
	private var stackView = UIStackView()
	private let hotelName = UILabel()
	private let hotelAdress = UILabel()
	private let stars = UILabel()
	private let distance = UILabel()
	private let suitsAvalibale = UILabel()
	private let tapLabel = UILabel()
	private var tapGesture: UITapGestureRecognizer!
	private var arrayForStackView: [UILabel]!
	var viewModel: DetailViewModelProtocol!
	
	
	//MARK: - LIVECYCLE
	override func viewDidLoad() {
		super.viewDidLoad()
		setupImageView()
		setupStackView()
		setupMapView()
		setupTapLabel()
		setupSpinner()
		setupHotelName()
		setupHotelAdress()
		setupStarsLabel()
		setupDistance()
		setHotel()
		setImage()
		addSubview()
		layout()
	}
	
	//MARK: - SETUP
	private func setupStackView() {
		arrayForStackView = [hotelName, stars, suitsAvalibale, distance, hotelAdress]
		stackView = UIStackView(arrangedSubviews: arrayForStackView)
		stackView.axis = .vertical
		stackView.spacing = Size.stackViewSpacing
		stackView.alignment = .center
		stackView.backgroundColor = .white
		stackView.layer.cornerRadius = Size.stackViewCornerRadius
		stackView.distribution = .fillEqually
	}
	
	private func setupSpinner() {
		spinner = UIActivityIndicatorView(style: .large)
		spinner.hidesWhenStopped = true
		spinner.color = .black
		spinner.startAnimating()
		spinnerView.isHidden = false
		spinnerView.alpha = 1
	}
	
	private func setupHotelName() {
		hotelName.font = Constants.hotelNameFont
		hotelName.numberOfLines = 0
		hotelName.adjustsFontSizeToFitWidth = true
	}
	
	private func setupHotelAdress() {
		hotelAdress.numberOfLines = 0
		hotelAdress.textAlignment = .center
		hotelAdress.adjustsFontSizeToFitWidth = true
	}
	
	private func setupStarsLabel() {
		self.stars.textColor = .systemYellow
		self.stars.font = Constants.starsSize
	}
	
	private func setupDistance() {
		distance.textColor = .systemGray
		distance.font = Constants.distanceNameFont
	}
	
	private func setupImageView() {
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		imageView.alpha = 0
		imageView.image = Constants.imageHotel
	}
	
	private func setupMapView() {
		tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnMap(sender:)))
		mapViewImage.addGestureRecognizer(tapGesture)
		mapViewImage.backgroundColor = .white
		mapViewImage.layer.cornerRadius = Size.mapViewImageCornerRadius
		mapViewImage.contentMode = .scaleAspectFill
		mapViewImage.clipsToBounds = true
		mapViewImage.layer.borderWidth = Size.mapViewImageBorderWidth
		mapViewImage.layer.borderColor = UIColor.white.cgColor
		mapViewImage.isUserInteractionEnabled = true
		mapViewImage.image = Constants.mapImage
	}
	
	private func setupTapLabel() {
		tapLabel.textAlignment = .center
		tapLabel.backgroundColor = .white
		tapLabel.clipsToBounds = true
		tapLabel.layer.cornerRadius = Size.tapLabelCornerRadius
		tapLabel.text = Constants.mapLabelText
		tapLabel.font = Constants.distanceNameFont
	}
	
	@objc func tapOnMap(sender: UITapGestureRecognizer) {
		print(#function)
		guard let lat = viewModel.lat else { return }
		guard let lon = viewModel.lon else { return }
		let mapView = ModuleBuilder.createMapView(lat: lat, lon: lon)
		navigationController?.show(mapView, sender: self)
	}
	
	private func setHotel() {
		title = viewModel.hotelName
		suitsAvalibale.text = viewModel.hotel.suites
		hotelName.text = viewModel.hotelName
		hotelAdress.text = viewModel.hotelAdress
		distance.text = viewModel.distance
		stars.text = viewModel.stars
	}
	
	private func setImage() {
		viewModel.downloadImage { [weak self] image in
			guard let self = self else { return }
			let croppedImg = image.crop(rect: CGRect(x: 1, y: 1, width: 0.9, height: 0.9))
			DispatchQueue.main.async {
				UIView.animate(withDuration: 0.5) {
					self.imageView.alpha = 1
					self.spinnerView.alpha = 0
					self.imageView.image = croppedImg
				}
				self.spinner.stopAnimating()
			}
		}
	}
}

//MARK: - LAYOUT
private extension DetailView {
	
	func addSubview() {
		view.backgroundColor = .systemGray5
		view.addSubview(imageView)
		view.addSubview(mapViewImage)
		view.addSubview(stackView)
		view.addSubview(spinnerView)
		mapViewImage.addSubview(tapLabel)
		spinnerView.addSubview(spinner)
	}
	
	func layout() {
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		imageView.heightAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
		
		mapViewImage.translatesAutoresizingMaskIntoConstraints = false
		mapViewImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
		mapViewImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
		mapViewImage.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
		mapViewImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
		
		tapLabel.translatesAutoresizingMaskIntoConstraints = false
		tapLabel.leadingAnchor.constraint(equalTo: mapViewImage.leadingAnchor, constant: 10).isActive = true
		tapLabel.topAnchor.constraint(equalTo: mapViewImage.topAnchor, constant: 10).isActive = true
		tapLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
		stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
		stackView.topAnchor.constraint(equalTo: mapViewImage.bottomAnchor, constant: 20).isActive = true
		stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
		
		spinnerView.translatesAutoresizingMaskIntoConstraints = false
		spinnerView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
		spinnerView.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
		spinnerView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
		spinnerView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
		
		spinner.translatesAutoresizingMaskIntoConstraints = false
		spinner.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
		spinner.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
	}
}
