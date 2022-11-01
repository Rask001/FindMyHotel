//
//  DetailViewModelTest.swift
//  FindMyHotelTests
//
//  Created by Антон on 01.11.2022.
//

import XCTest
@testable import FindMyHotel

final class DetailViewModelTest: XCTestCase {
	
	var mockDetailViewModel: DetailViewModel!
	var hotel: Hotel!
	var networkService: NetworkServiceProtocol!
	var lat: Double?
	var lon: Double?
	var image: String?
	
	override func setUpWithError() throws {
		hotel = Hotel(id: 13100,
									name: "Cosmos",
									address: "Moscow",
									stars: 1.0,
									distance: 99.99,
									suitesAvailability: "0, 44, 55")
		mockDetailViewModel = DetailViewModel(hotel: hotel)
		networkService = NetworkService()
		lat = 40.76062100000000
		lon = -73.98636399999999
		image = ""
	}
	
	override func tearDownWithError() throws {
		hotel = nil
		mockDetailViewModel = nil
		lat = nil
		lon = nil
		image = nil
	}
	
	func testDetailViewModel() {
		XCTAssertEqual(hotel.id, mockDetailViewModel.hotelId)
		XCTAssertEqual(hotel.name, mockDetailViewModel.hotelName)
		XCTAssertEqual(hotel.address, mockDetailViewModel.hotelAdress)
		XCTAssertEqual(Helper.starsToString(stars: hotel.stars), mockDetailViewModel.stars)
		XCTAssertEqual("📍\(hotel.distance)km from center", mockDetailViewModel.distance)
		XCTAssertEqual(hotel.suitesArray.count, mockDetailViewModel.numberOfRows())
	}

}
