//
//  ImageCropper.swift
//  FindMyHotel
//
//  Created by Антон on 26.10.2022.
//

import UIKit

extension UIImage {
		func crop( rect: CGRect) -> UIImage {
				var rect = rect
				rect.origin.x += self.scale
				rect.origin.y += self.scale
				rect.size.width *= self.size.width
				rect.size.height *= self.size.height

			let imageRef = self.cgImage!.cropping(to: rect)!
				let image = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
				return image
		}
}
