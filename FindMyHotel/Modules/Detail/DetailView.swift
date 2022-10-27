//
//  DetailView.swift
//  FindMyHotel
//
//  Created by Антон on 26.10.2022.
//

import Foundation

import UIKit

//MARK: - CONSTANTS
fileprivate enum Constants {
	static var hotelNameFont: UIFont { UIFont(name: "Helvetica Neue Medium", size: 20)!}
	static var distanceNameFont: UIFont { UIFont(name: "Helvetica Neue", size: 16)!}
	static var starsSize: UIFont { UIFont(name: "Helvetica Neue", size: 28)!}
	static var imageHotel =	UIImage(named: "Hotel")
}

//MARK: - VIEW
class DetailView: UIViewController {
	
	//MARK: - PROPERTY
	private let imageView = UIImageView()
	private let mapViewImage = UIImageView()
	private var spinnerView = UIView()
	private var spinner = UIActivityIndicatorView()
	private var stackView = UIStackView()
	private var hotelName = UILabel()
	private let hotelAdress = UILabel()
	private let stars = UILabel()
	private let distance = UILabel()
	private let suitsAvalibale = UILabel()
	var viewModel: DetailViewModelProtocol!
	
	
	//MARK: - LIVECYCLE
	override func viewDidLoad() {
		super.viewDidLoad()
		setupImageView()
		setupStackView()
		setupMapView()
		setupSpinner()
		setupHotelName()
		setupHotelAdress()
		setupStarsLabel()
		setupDistance()
		setupSuitsAvalibale()
		setHotel()
		setImage()
		addSubview()
		layout()
	}
	
	//MARK: - SETUP
	private func setupStackView() {
		let arrayForStackView = [hotelName, stars, suitsAvalibale, distance, hotelAdress]
		self.stackView = UIStackView(arrangedSubviews: arrayForStackView)
		self.stackView.axis = .vertical
		self.stackView.spacing = 10
		self.stackView.alignment = .center
		self.stackView.backgroundColor = .white
		self.stackView.layer.cornerRadius = 7
		self.stackView.distribution = .fillEqually
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
		self.hotelName.font = Constants.hotelNameFont
		self.hotelName.numberOfLines = 0
		self.hotelName.adjustsFontSizeToFitWidth = true
	}
	
	private func setupHotelAdress() {
		self.hotelAdress.numberOfLines = 0
		self.hotelAdress.textAlignment = .center
		self.hotelAdress.adjustsFontSizeToFitWidth = true
	}
	
	private func setupStarsLabel() {
		self.stars.textColor = .systemYellow
		self.stars.font = Constants.starsSize
	}
	
	private func setupDistance() {
		self.distance.textColor = .systemGray
		self.distance.font = Constants.distanceNameFont
	}
	
	private func setupSuitsAvalibale() {
		
	}
	
	private func setupImageView() {
		self.imageView.contentMode = .scaleAspectFit
		self.imageView.clipsToBounds = true
		self.imageView.alpha = 0
		self.imageView.image = Constants.imageHotel
	}
	
	private func setupMapView() {
		self.mapViewImage.backgroundColor = .white
		self.mapViewImage.layer.cornerRadius = 7
	}
	
	private func setHotel() {
		self.title = self.viewModel.hotelName
		self.suitsAvalibale.text = self.viewModel.hotel.suites
		self.hotelName.text = self.viewModel.hotelName
		self.hotelAdress.text = self.viewModel.hotelAdress
		self.distance.text = self.viewModel.distance
		self.stars.text = self.viewModel.stars
	}
	
	private func setImage() {
		self.viewModel.fetchImage { [weak self] image in
			guard let self else { return }
			let croppedImg = image.crop(rect: CGRect(x: 1, y: 1, width: 0.9, height: 0.9))
			DispatchQueue.main.async {
				UIView.animate(withDuration: 0.8) {
					self.imageView.alpha = 1
					self.spinnerView.alpha = 0
					self.imageView.image = croppedImg
				}
				self.spinner.stopAnimating()
			}
		}
	}
	
	//MARK: - LAYOUT
	private func addSubview() {
		self.view.backgroundColor = .systemGray5
		self.view.addSubview(self.imageView)
		self.view.addSubview(self.mapViewImage)
		self.view.addSubview(self.stackView)
		self.view.addSubview(self.spinnerView)
		self.spinnerView.addSubview(self.spinner)
	}
	
	private func layout() {
		self.imageView.translatesAutoresizingMaskIntoConstraints = false
		self.imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		self.imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		self.imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
		self.imageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
		
		self.mapViewImage.translatesAutoresizingMaskIntoConstraints = false
		self.mapViewImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
		self.mapViewImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
		self.mapViewImage.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20).isActive = true
		self.mapViewImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
		//self.mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
		
		self.stackView.translatesAutoresizingMaskIntoConstraints = false
		self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
		self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
		self.stackView.topAnchor.constraint(equalTo: self.mapViewImage.bottomAnchor, constant: 20).isActive = true
		self.stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
		
		self.spinnerView.translatesAutoresizingMaskIntoConstraints = false
		self.spinnerView.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor).isActive = true
		self.spinnerView.topAnchor.constraint(equalTo: self.imageView.topAnchor).isActive = true
		self.spinnerView.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor).isActive = true
		self.spinnerView.trailingAnchor.constraint(equalTo: self.imageView.trailingAnchor).isActive = true
		
		self.spinner.translatesAutoresizingMaskIntoConstraints = false
		self.spinner.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor).isActive = true
		self.spinner.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor).isActive = true
	}
}
