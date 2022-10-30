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
	
	static func error(_ text: String) {
		let text = text
		let buttonTag = ["error": text]
		NotificationCenter.default.post(name: Notification.Name("errorSend"), object: nil, userInfo: buttonTag)
	}
}
