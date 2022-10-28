//
//  Animations.swift
//  FindMyHotel
//
//  Created by Антон on 27.10.2022.
//

import Foundation
import UIKit
private var headerIsClosed = true
final class Animations {
	
	func animateHeaderView(headerView: UIView, topConstraint: NSLayoutConstraint, view: UIViewController) {
		headerIsClosed.toggle()
		UIView.animate(withDuration: 0.3) {
			headerView.alpha = headerIsClosed ? 0.0 : 1.0
		}
		
		let height = headerView.frame.height
		UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0) {
			topConstraint.constant = headerIsClosed ? -height : 0
			view.view.layoutIfNeeded()
		}
	}
}
