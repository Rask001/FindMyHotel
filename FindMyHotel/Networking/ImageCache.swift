//
//  ImageCache.swift
//  FindMyHotel
//
//  Created by Антон on 30.10.2022.
//

import Foundation
import UIKit

struct ImageCache {
	static let shared = NSCache<NSString, UIImage>()
}
