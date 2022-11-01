//
//  Animations.swift
//  FindMyHotel
//
//  Created by Антон on 27.10.2022.
//

import Foundation
import UIKit

protocol AnimationsProtocol {
	func animateHeaderView(headerView: UIView, topConstraint: NSLayoutConstraint, view: UIViewController)
}

final class Animations: AnimationsProtocol {
	private var headerIsClosed = true
	
	func animateHeaderView(headerView: UIView, topConstraint: NSLayoutConstraint, view: UIViewController) {
		headerIsClosed.toggle()
		UIView.animate(withDuration: 0.3) { [weak self] in
			guard let self = self else { return }
			headerView.alpha = self.headerIsClosed ? 0.0 : 1.0
		}
		
		let height = headerView.frame.height
		UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0) { [weak self] in
			guard let self = self else { return }
			topConstraint.constant = self.headerIsClosed ? -height : 0
			view.view.layoutIfNeeded()
		}
	}
}
