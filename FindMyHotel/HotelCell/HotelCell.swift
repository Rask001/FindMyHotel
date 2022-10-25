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
	static var navigationItemTitle: String { NSLocalizedString("new task", comment: "") }
	static var textFiledPlaceholder: String { NSLocalizedString("...write something here", comment: "")  }
	static var leftButtonImage: UIImage { UIImage(named: "xmrk")! }
	static var rightButtonImage: UIImage { UIImage(named: "chckmrk")! }
	static var alertLabelImage: UIImage { UIImage(systemName: "alarm")! }
	static var repeatLabelImage: UIImage { UIImage(systemName: "repeat")! }
	static var infoLabelFont: UIFont { UIFont(name: "Futura", size: 17)!}
	static var infoLabelFont20: UIFont { UIFont(name: "Futura", size: 20)!}
	static var navigationTitleFont: UIFont { UIFont(name: "Futura", size: 20)!}
	static var backgroundColorView: UIColor { .systemBackground }
	static var barColorView: UIColor { UIColor(named: "barNewTask") ?? .systemBackground }
}

//MARK: - VIEW
final class HotelCell: UITableViewCell {
	
	//MARK: - PROPERTY
	static let identifire = "HotelCell"
	private let backgroundViewCell = UIView()
	internal var myImageView = UIImageView(image: UIImage(named: "room"))
	private let hotelName = UILabel()
	private let hotelAdress = UILabel()
	private let stars = UILabel()
	private let distance = UILabel()
	private let suitsAvalibaleCount = UILabel()
	private var stackView = UIStackView()
	
	var viewModel: HotelCellVMProtocol! {
		didSet {
			hotelName.text = viewModel.hotelName
			distance.text = viewModel.distance
			suitsAvalibaleCount.text = viewModel.suitsAvalibaleCount
			stars.text = viewModel.stars
			viewModel.fetchImage { [weak self] imageData in
				guard let self else { return }
				let id = self.viewModel.hotel.id
				self.viewModel.networkService.loadCacheImage(item: id, imageUrl: imageData) { image in
					self.myImageView.image = image
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
	
	private func setupHotelName() {
		self.hotelName.text = "Grand Palace"
		self.hotelName.font = Constants.hotelNameFont
	}
	
	private func setupHotelAdress() {
		self.hotelAdress.text = "5th Avenue, Garden St."
	}
	private func setupStarsLabel() {
		self.stars.text = "★ ★ ★ ★ ☆"
		self.stars.textColor = .systemYellow
	}
	private func setupDistance() {
		self.distance.text = "📍 99.9 from center"
		self.distance.textColor = .systemGray
		self.distance.font = Constants.distanceNameFont
	}
	private func setupSuitsAvalibaleCount() {
		self.suitsAvalibaleCount.text = "Suits avalibale is: 4"
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
		self.stackView.leadingAnchor.constraint(equalTo: self.myImageView.trailingAnchor, constant: 20).isActive = true
		self.stackView.topAnchor.constraint(equalTo: self.backgroundViewCell.topAnchor, constant: 20).isActive = true
		self.stackView.bottomAnchor.constraint(equalTo: self.backgroundViewCell.bottomAnchor, constant: -20).isActive = true
		self.stackView.trailingAnchor.constraint(equalTo: self.backgroundViewCell.trailingAnchor, constant: -20).isActive = true
	}

}

//MARK: - EXTENSION
extension HotelCell {
	
}
