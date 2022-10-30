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
	func loadFromJsonFromURL<T: Decodable>(_ url: URL, _ resultType: T.Type, _ completion: @escaping (_ result: T) throws -> Void)
}


//MARK: - NETWORK SERVICE
final class NetworkService: NetworkServiceProtocol {
	
	static var cache = NSCache<AnyObject, UIImage>()
	
	public func loadFromJsonFromURL<T: Decodable>(_ url: URL, _ resultType: T.Type, _ completion: @escaping (_ result: T) throws -> Void) {
		
		let task = URLSession.shared.dataTask(with: url) { data, _, error in
			if let error = error {
				print("Error: \(error.localizedDescription)")
			}
			guard let data = data else {
				print(ServerError.missingData); return
			}
			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				guard let result = try? decoder.decode(T.self, from: data) else {
					throw ServerError.decodingFail
				}
				DispatchQueue.main.async {
					try? completion(result)
				}
			}
			catch {
				print("Error: \(error.localizedDescription)")
				print(ServerError.decodingFail)
			}
		}
		task.resume()
	}
}


