//
//  HotelCell.swift
//  FindMyHotel
//
//  Created by Антон on 25.10.2022.
//

import Foundation
import UIKit

//MARK: - VIEW
final class HotelCell: UITableViewCell {
	
	//MARK: - CONSTANTS
	private enum Constants {
		static let identifire = "HotelCell"
		static let myImageViewImage = UIImage(named: "Hotel")
		static let hotelNameFont: UIFont = UIFont(name: "Helvetica Neue Medium", size: 20)!
		static var distanceNameFont: UIFont = UIFont(name: "Helvetica Neue", size: 16)!
	}
	
	//MARK: - CONSTANTS SIZE
	private enum Size {
		static let stackViewSpacing: CGFloat = 10
		static let myImageViewCornerRadius: CGFloat = 10
		static let backgroundViewCornerRadius: CGFloat = 10
		static let backgroundViewShadowRadius: CGFloat = 4
		static let backgroundViewShadowOpacity: Float = 0.2
		static let backgroundViewShadowOffset: CGSize = CGSize(width: 0, height: 3)
	}
	
	//MARK: - PROPERTY
	static let identifire = Constants.identifire
	private let backgroundViewCell = UIView()
	internal var myImageView = UIImageView()
	private let hotelName = UILabel()
	private let hotelAdress = UILabel()
	private let stars = UILabel()
	private let distance = UILabel()
	private let suitsAvalibaleCount = UILabel()
	private var stackView = UIStackView()
	private var spinnerView = UIView()
	private var spinner = UIActivityIndicatorView()
	
	var viewModel: HotelCellVMProtocol! {
		didSet {
			hotelName.text = viewModel.hotelName
			distance.text = viewModel.distance
			suitsAvalibaleCount.text = viewModel.suitsAvalibaleCount
			stars.text = viewModel.stars
			hotelAdress.text = viewModel.hotelAdress
			viewModel.fetchImage { [weak self] image in
				guard let self = self else { return }
				DispatchQueue.main.async {
					UIView.animate(withDuration: 0.5) {
						self.myImageView.alpha = 1
						self.spinnerView.alpha = 0
						self.myImageView.image = image
					}
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
		stackView = UIStackView(arrangedSubviews: arrayForStackView)
		stackView.axis = .vertical
		stackView.spacing = Size.stackViewSpacing
		stackView.backgroundColor = backgroundViewCell.backgroundColor
		stackView.distribution = .fillEqually
	}
	
	private func setupSpinner() {
		spinner = UIActivityIndicatorView(style: .large)
		spinner.hidesWhenStopped = true
		spinner.color = .black
		spinner.isHidden = false
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
		hotelAdress.adjustsFontSizeToFitWidth = true
	}
	
	private func setupStarsLabel() {
		stars.textColor = .systemYellow
	}
	
	private func setupDistance() {
		distance.textColor = .systemGray
		distance.font = Constants.distanceNameFont
	}
	
	private func setupSuitsAvalibaleCount() {
		suitsAvalibaleCount.numberOfLines = 0
	}
	
	private func setupImageView() {
		myImageView.contentMode = .scaleAspectFill
		myImageView.clipsToBounds = true
		myImageView.alpha = 0
		myImageView.layer.cornerRadius = Size.myImageViewCornerRadius
		myImageView.image = Constants.myImageViewImage
	}
	
	private func setupBackgroundViewCell() {
		backgroundViewCell.backgroundColor = .white
		backgroundViewCell.layer.cornerRadius = Size.backgroundViewCornerRadius
		backgroundViewCell.clipsToBounds = true
	}
	
	private func backgroundViewCellShadow() {
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowRadius = Size.backgroundViewShadowRadius
		layer.shadowOpacity = Size.backgroundViewShadowOpacity
		layer.shadowOffset = Size.backgroundViewShadowOffset
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		hotelName.text?.removeAll()
		distance.text?.removeAll()
		suitsAvalibaleCount.text?.removeAll()
		stars.text?.removeAll()
		hotelAdress.text?.removeAll()
		myImageView.image = nil
	}
}
//MARK: - LAYOUT
private extension HotelCell {
	private func addSubviewAndConfigure() {
		backgroundColor = .clear
		contentView.addSubview(backgroundViewCell)
		backgroundViewCell.addSubview(myImageView)
		backgroundViewCell.addSubview(stackView)
		backgroundViewCell.addSubview(spinnerView)
		spinnerView.addSubview(spinner)
	}
	
	func layout() {
		backgroundViewCell.translatesAutoresizingMaskIntoConstraints = false
		backgroundViewCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7).isActive = true
		backgroundViewCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7).isActive = true
		backgroundViewCell.topAnchor.constraint(equalTo: topAnchor).isActive = true
		backgroundViewCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7).isActive = true
		
		myImageView.translatesAutoresizingMaskIntoConstraints = false
		myImageView.leadingAnchor.constraint(equalTo: backgroundViewCell.leadingAnchor).isActive = true
		myImageView.topAnchor.constraint(equalTo: backgroundViewCell.topAnchor).isActive = true
		myImageView.bottomAnchor.constraint(equalTo: backgroundViewCell.bottomAnchor).isActive = true
		myImageView.widthAnchor.constraint(equalToConstant: bounds.width/2.5).isActive = true
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.leadingAnchor.constraint(equalTo: myImageView.trailingAnchor, constant: 10).isActive = true
		stackView.topAnchor.constraint(equalTo: backgroundViewCell.topAnchor, constant: 20).isActive = true
		stackView.bottomAnchor.constraint(equalTo: backgroundViewCell.bottomAnchor, constant: -20).isActive = true
		stackView.trailingAnchor.constraint(equalTo: backgroundViewCell.trailingAnchor, constant: -10).isActive = true
		
		spinnerView.translatesAutoresizingMaskIntoConstraints = false
		spinnerView.leadingAnchor.constraint(equalTo: myImageView.trailingAnchor).isActive = true
		spinnerView.topAnchor.constraint(equalTo: myImageView.topAnchor).isActive = true
		spinnerView.bottomAnchor.constraint(equalTo: myImageView.bottomAnchor).isActive = true
		spinnerView.trailingAnchor.constraint(equalTo: myImageView.trailingAnchor).isActive = true
		
		spinner.translatesAutoresizingMaskIntoConstraints = false
		spinner.centerXAnchor.constraint(equalTo: myImageView.centerXAnchor).isActive = true
		spinner.centerYAnchor.constraint(equalTo: myImageView.centerYAnchor).isActive = true
	}
}
