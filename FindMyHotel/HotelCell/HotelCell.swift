//
//  HotelCell.swift
//  FindMyHotel
//
//  Created by Антон on 25.10.2022.
//

import Foundation
import UIKit

fileprivate enum Constants {
	static var hotelNameFont: UIFont { UIFont(name: "Helvetica Neue Medium", size: 20)!}
	static var distanceNameFont: UIFont { UIFont(name: "Helvetica Neue", size: 16)!}
}

//MARK: - VIEW
final class HotelCell: UITableViewCell {
	
	//MARK: - PROPERTY
	static let identifire = "HotelCell"
	private let backgroundViewCell = UIView()
	internal var myImageView = UIImageView()
	private let hotelName = UILabel()
	private let hotelAdress = UILabel()
	private let stars = UILabel()
	private let distance = UILabel()
	private let suitsAvalibaleCount = UILabel()
	private var stackView = UIStackView()
	private var spinner = UIActivityIndicatorView()
	
	var viewModel: HotelCellVMProtocol! {
		didSet {
			hotelName.text = viewModel.hotelName
			distance.text = viewModel.distance
			suitsAvalibaleCount.text = viewModel.suitsAvalibaleCount
			stars.text = viewModel.stars
			hotelAdress.text = viewModel.hotelAdress
			viewModel.fetchImage { [weak self] image in
				guard let self else { return }
				let croppedImg = image.crop(rect: CGRect(x: 1, y: 1, width: 0.99, height: 0.9))
				DispatchQueue.main.async {
					self.myImageView.image = croppedImg
					self.spinner.stopAnimating()
				}
			}
		}
	}
	
	//MARK: - INIT
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupBackgroundViewCell()
		backgroundViewCellShadow()
		setupImageView()
		setupStackView()
		setupSpinner()
		setupHotelName()
		setupHotelAdress()
		setupStarsLabel()
		setupDistance()
		setupSuitsAvalibaleCount()
		addSubviewAndConfigure()
		layout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - SETUP
	private func setupStackView() {
		let arrayForStackView = [hotelName, stars, suitsAvalibaleCount, distance, hotelAdress]
		self.stackView = UIStackView(arrangedSubviews: arrayForStackView)
		self.stackView.axis = .vertical
		self.stackView.spacing = 10
		self.stackView.backgroundColor = backgroundViewCell.backgroundColor
		self.stackView.distribution = .fillEqually
	}
	
	private func setupSpinner() {
		spinner = UIActivityIndicatorView(style: .large)
		spinner.hidesWhenStopped = true
		spinner.color = .black
		spinner.isHidden = false
		spinner.startAnimating()
	}
	
	private func setupHotelName() {
		self.hotelName.font = Constants.hotelNameFont
		self.hotelName.numberOfLines = 0
		self.hotelName.adjustsFontSizeToFitWidth = true
	}
	
	private func setupHotelAdress() {
		self.hotelAdress.numberOfLines = 0
		self.hotelAdress.adjustsFontSizeToFitWidth = true
	}
	
	private func setupStarsLabel() {
		self.stars.textColor = .systemYellow
	}
	
	private func setupDistance() {
		self.distance.textColor = .systemGray
		self.distance.font = Constants.distanceNameFont
	}
	
	private func setupSuitsAvalibaleCount() {
		
	}
	
	private func setupImageView() {
		self.myImageView.contentMode = .scaleAspectFill
		self.myImageView.clipsToBounds = true
	}
	
	private func setupBackgroundViewCell() {
		backgroundViewCell.backgroundColor = .white
		backgroundViewCell.layer.cornerRadius = 7
		backgroundViewCell.clipsToBounds = true
	}
	
	private func backgroundViewCellShadow() {
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowRadius = 4
		self.layer.shadowOpacity = 0.2
		self.layer.shadowOffset = CGSize(width: 0, height: 3 )
	}
	
	//MARK: - LAYOUT
	private func addSubviewAndConfigure() {
		self.backgroundColor = .clear
		self.contentView.addSubview(backgroundViewCell)
		self.backgroundViewCell.addSubview(self.myImageView)
		self.backgroundViewCell.addSubview(self.stackView)
		self.myImageView.addSubview(self.spinner)
	}
	
	internal func layout() {
		self.backgroundViewCell.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6).isActive = true
		self.backgroundViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6).isActive = true
		self.backgroundViewCell.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		self.backgroundViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6).isActive = true
		
		self.myImageView.translatesAutoresizingMaskIntoConstraints = false
		self.myImageView.leadingAnchor.constraint(equalTo: self.backgroundViewCell.leadingAnchor).isActive = true
		self.myImageView.topAnchor.constraint(equalTo: self.backgroundViewCell.topAnchor).isActive = true
		self.myImageView.bottomAnchor.constraint(equalTo: self.backgroundViewCell.bottomAnchor).isActive = true
		self.myImageView.widthAnchor.constraint(equalToConstant: self.bounds.width/2.5).isActive = true
		
		self.stackView.translatesAutoresizingMaskIntoConstraints = false
		self.stackView.leadingAnchor.constraint(equalTo: self.myImageView.trailingAnchor, constant: 10).isActive = true
		self.stackView.topAnchor.constraint(equalTo: self.backgroundViewCell.topAnchor, constant: 20).isActive = true
		self.stackView.bottomAnchor.constraint(equalTo: self.backgroundViewCell.bottomAnchor, constant: -20).isActive = true
		self.stackView.trailingAnchor.constraint(equalTo: self.backgroundViewCell.trailingAnchor, constant: -10).isActive = true
		
		self.spinner.translatesAutoresizingMaskIntoConstraints = false
		self.spinner.centerXAnchor.constraint(equalTo: self.myImageView.centerXAnchor).isActive = true
		self.spinner.centerYAnchor.constraint(equalTo: self.myImageView.centerYAnchor).isActive = true
	}
}
