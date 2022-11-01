//
//  AllertService.swift
//  FindMyHotel
//
//  Created by Антон on 30.10.2022.
//

import Foundation
import UIKit

final class AllertService {
	func allert(title: String, text: String) -> UIAlertController {
		let allert = UIAlertController(title: title, message: text, preferredStyle: .alert)
		let action = UIAlertAction(title: "ok", style: .default)
		allert.addAction(action)
		return allert
	}
	
	static func systemError(_ error: Error) {
		DispatchQueue.main.async {
			AllertService.error("\(ServerError.systemError(error).localizedDescription)")
		}
	}
	
	static func errorImageDownload() {
		DispatchQueue.main.async {
			error("\(ServerError.errorImageDownload.localizedDescription)")
		}
	}
	
	static func theConnectionIsEstablished() {
		DispatchQueue.main.async {
			error("\(ServerError.theConnectionIsEstablished.localizedDescription)")
		}
	}
	
	static func incorrectData() {
		DispatchQueue.main.async {
			error("\(ServerError.incorrectData.localizedDescription)")
		}
	}
	
	static func decodingFail() {
		DispatchQueue.main.async {
			error("\(ServerError.decodingFail.localizedDescription)")
		}
	}
	
	static func incorrectUrl() {
		DispatchQueue.main.async {
			error("\(ServerError.incorrectUrl.localizedDescription)")
		}
	}
	static func internetConnectionIsFaild() {
		DispatchQueue.main.async {
			error("\(ServerError.internetConnectionIsFaild.localizedDescription)")
		}
	}
	
	static func error(_ text: String) {
		let text = text
		let buttonTag = ["error": text]
		NotificationCenter.default.post(name: Notification.Name("errorSend"), object: nil, userInfo: buttonTag)
	}
}
