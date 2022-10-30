//
//  NetworkServices.swift
//  FindMyHotel
//
//  Created by Антон on 25.10.2022.
//

import Foundation
import UIKit
//MARK: - PROTOCOL
protocol NetworkServiceProtocol {
	func loadFromJsonFromURL<T: Decodable>(_ url: URL, _ resultType: T.Type, _ completion: @escaping (_ result: T) -> Void)
}

//MARK: - NETWORK SERVICE
final class NetworkService: NetworkServiceProtocol {
	
	static var cache = NSCache<AnyObject, UIImage>()
	
	public func loadFromJsonFromURL<T: Decodable>(_ url: URL, _ resultType: T.Type, _ completion: @escaping (_ result: T) -> Void) {
		let task = URLSession.shared.dataTask(with: url) { data, _, error in
			if let error = error {
				AllertService.error("\(ServerError.systemError(error))")
			}
			guard let data = data else {
				AllertService.error("\(ServerError.missingData)"); return
			}
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			guard let result = try? decoder.decode(T.self, from: data) else {
				AllertService.error("\(ServerError.decodingFail)"); return
			}
			DispatchQueue.main.async {
				completion(result)
			}
		}
		task.resume()
	}
}


