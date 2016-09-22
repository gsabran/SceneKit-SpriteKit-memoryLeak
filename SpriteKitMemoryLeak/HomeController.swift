//
//  HomeController.swift
//  SpriteKitMemoryLeak
//
//  Created by Guillaume Sabran on 9/22/16.
//  Copyright © 2016 Guillaume Sabran. All rights reserved.
//

import UIKit
import SpriteKit

// see http://stackoverflow.com/questions/24127587/how-do-i-declare-an-array-of-weak-references-in-swift
class Weak<T: AnyObject> {
	weak var value : T?
	init (value: T) {
		self.value = value
	}
}

class HomeController: UIViewController {
	@IBAction func button(_ sender: AnyObject) {
		// on button pressed, present a SCNScene
		let vc = self.storyboard?.instantiateViewController(withIdentifier: "SceneView") as! ViewController

		vc.delegate = self
		self.present(vc, animated: true)
	}

	// keep weak references to SKScenes to be able to count how many are alive
	var scenes = [Weak<SKScene>]()

	func countScenesAlive() -> Int {
		return scenes.filter { return $0.value != nil }.count
	}
}

extension HomeController: ViewControllerDelegate {
	func register(scene: SKScene) {
		self.scenes.append(Weak<SKScene>(value: scene))
		print("scenes alive count: \(countScenesAlive())")
	}
}
