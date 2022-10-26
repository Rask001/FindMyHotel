//
//  SceneDelegate.swift
//  FindMyHotel
//
//  Created by Антон on 25.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: windowScene)
		let navigationController = UINavigationController(rootViewController: ModuleBuilder.createMainView())
		window.rootViewController = navigationController
		window.makeKeyAndVisible()
		self.window = window
	}
}

