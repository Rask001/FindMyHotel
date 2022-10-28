//
//  Error.swift
//  FindMyHotel
//
//  Created by Антон on 28.10.2022.
//

import Foundation

enum Errors: Error {
	case incorrectData
	case errorImageDownload
	case incorrectUrl
}

extension Errors: LocalizedError {
	var errorDescription: String? {
		switch self {
			
		case .incorrectData:
			return NSLocalizedString("check the input Data", comment: "")
		case .incorrectUrl:
			return NSLocalizedString("check the URL", comment: "")
		case .errorImageDownload:
			return NSLocalizedString("check imageDownloadAndCahed", comment: "")
		}
	}
}

