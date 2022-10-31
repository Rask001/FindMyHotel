//
//  ImageCache.swift
//  FindMyHotel
//
//  Created by Антон on 30.10.2022.
//

import Foundation
import UIKit

final class ImageCache {
	static let shared = NSCache<NSString, UIImage>()
}
