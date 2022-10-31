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
		AllertService.error("\(ServerError.systemError(error).localizedDescription)")
	}
	
	static func errorImageDownload() {
		error("\(ServerError.errorImageDownload.localizedDescription)")
	}
	
	static func missingData() {
		error("\(ServerError.missingData.localizedDescription)")
	}
	
	static func incorrectData() {
		error("\(ServerError.IncorrectData.localizedDescription)")
	}
	
	static func decodingFail() {
		error("\(ServerError.decodingFail.localizedDescription)")
	}
	
	static func incorrectUrl() {
		error("\(ServerError.incorrectUrl.localizedDescription)")
	}
	
	static func error(_ text: String) {
		let text = text
		let buttonTag = ["error": text]
		NotificationCenter.default.post(name: Notification.Name("errorSend"), object: nil, userInfo: buttonTag)
	}
}
