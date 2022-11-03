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
	
	func testFetchHotelForDetailView() {
		var called = false
		mockDetailViewModel.fetchHotelForDetailView {
			called = true
		}
		DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
			XCTAssertEqual(called, true)
		}
	}
	
	func testSet() {
		let espect = expectation(description: "Download should succeed")
		networkService.fetchDataFromURL(.getHotelUrl(withID: hotel.id)) { [weak self] (result : Result<Hotel,Error>) in
			
			guard let self = self else { return }
			switch result {
			case .success(let model):
				XCTAssertEqual(model.lon, self.lon)
				XCTAssertEqual(model.lat, self.lat)
				print("model: \(model.lat ?? 0.0), self: \(self.lat ?? 0.0)")
				XCTAssertEqual(model.image, self.image)
				
			case .failure(let error):
				print(error)
			}
			espect.fulfill()
		}
		waitForExpectations(timeout: 10) { error in
			XCTAssertNil(error, "Test timed out. \(error?.localizedDescription ?? "error")")
		}
	}
}
