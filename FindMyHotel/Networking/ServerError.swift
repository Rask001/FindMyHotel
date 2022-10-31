//
//  Error.swift
//  FindMyHotel
//
//  Created by Антон on 28.10.2022.
//

import Foundation
import UIKit
enum ServerError: Error {
	case error404
	case missingData
	case errorImageDownload
	case incorrectUrl
	case decodingFail
	case IncorrectData
	case systemError(Error)
}

extension ServerError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .missingData:
			return NSLocalizedString("Error: missing response data", comment: "")
		case .incorrectUrl:
			return NSLocalizedString("check the URL", comment: "")
		case .errorImageDownload:
			return NSLocalizedString("check imageDownloadAndCahed", comment: "")
		case .decodingFail:
			return NSLocalizedString("The problem with json decoding", comment: "")
		case .IncorrectData:
			return NSLocalizedString("The problem with Data extraction", comment: "")
		case .systemError(let error):
			return NSLocalizedString("\(error.localizedDescription)", comment: "")
		case .error404:
			return NSLocalizedString("The problem with Data extraction", comment: "")
		}
	}
}

