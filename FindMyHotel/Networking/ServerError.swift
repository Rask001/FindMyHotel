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
	case theConnectionIsEstablished
	case errorImageDownload
	case incorrectUrl
	case decodingFail
	case incorrectData
	case internetConnectionIsFaild
	case systemError(Error)
}

extension ServerError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .incorrectUrl:
			return NSLocalizedString("check the URL", comment: "")
		case .errorImageDownload:
			return NSLocalizedString("check imageDownloadAndCahed", comment: "")
		case .decodingFail:
			return NSLocalizedString("The problem with json decoding", comment: "")
		case .incorrectData:
			return NSLocalizedString("The problem with Data extraction", comment: "")
		case .systemError(let error):
			return NSLocalizedString("\(error.localizedDescription)", comment: "")
		case .error404:
			return NSLocalizedString("The problem with Data extraction", comment: "")
	  case .internetConnectionIsFaild :
		  return NSLocalizedString("No internet connection", comment: "")
		case .theConnectionIsEstablished:
			return NSLocalizedString("The connection is established", comment: "")
	  }
	}
}

