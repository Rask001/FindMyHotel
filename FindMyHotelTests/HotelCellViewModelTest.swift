//
//  HotelCellViewModelTest.swift
//  FindMyHotelTests
//
//  Created by Антон on 02.11.2022.
//

import XCTest
@testable import FindMyHotel

final class HotelCellViewModelTest: XCTestCase {
	
	var mockHotelCellViewModel: HotelCellViewModel!
	var hotel: Hotel!
	var transform: [Int]!

	override func setUpWithError() throws {
		hotel = Hotel(id: 13100,
									name: "Cosmos",
									address: "Moscow",
									stars: 1.0,
									distance: 99.99,
									suitesAvailability: "0, 44, 55")
		mockHotelCellViewModel = HotelCellViewModel(hotel: hotel)
		transform = hotel.suitesAvailability.components(separatedBy: ":").compactMap(Int.init)
	}

	override func tearDownWithError() throws {
			mockHotelCellViewModel = nil
			hotel = nil
		  transform = nil
    }
	
	func testHotelCellViewModel() {
		XCTAssertEqual(hotel.name, mockHotelCellViewModel.hotelName)
		XCTAssertEqual(hotel.address, mockHotelCellViewModel.hotelAdress)
		XCTAssertEqual(Helper.starsToString(stars: hotel.stars), mockHotelCellViewModel.stars)
		XCTAssertEqual("📍\(hotel.distance)km from center", mockHotelCellViewModel.distance)
		XCTAssertEqual(hotel.suitesArray.count, transform.count)
		
	}


}
