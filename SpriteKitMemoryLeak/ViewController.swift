//
//  ViewController.swift
//  SpriteKitMemoryLeak
//
//  Created by Guillaume Sabran on 9/21/16.
//  Copyright © 2016 Guillaume Sabran. All rights reserved.
//

import UIKit
import SpriteKit
import SceneKit

// see http://stackoverflow.com/questions/24127587/how-do-i-declare-an-array-of-weak-references-in-swift
class Weak<T: AnyObject> {
	weak var value : T?
	init (value: T) {
		self.value = value
	}
}

class ViewController: UIViewController {

	@IBOutlet weak var scnView: SCNView!

	@IBAction func buttonPressed(_ sender: AnyObject) {
		// on button pressed, create a new SKScene
		// and use it as the material for the cube instead of the previous one
		createScene()
	}

	var scenes = [Weak<SKScene>]()
	var cubeNode: SCNNode!

	override func viewDidLoad() {
		super.viewDidLoad()

		let scnScene = SCNScene()
		scnView.scene = scnScene

		// setup SceneKit scene
		let cameraNode = SCNNode()
		cameraNode.camera = SCNCamera()
		cameraNode.position = SCNVector3(x: 0, y: 0, z: 25)
		scnScene.rootNode.addChildNode(cameraNode)

		cubeNode = SCNNode()
		cubeNode.geometry = SCNBox(width: 5, height: 5, length: 5, chamferRadius: 0)
		scnScene.rootNode.addChildNode(cubeNode)
	}

	func createScene() {
		let skScene = SKScene()
		skScene.backgroundColor = UIColor.black
		skScene.size = CGSize(width: 100, height: 100)

		let skNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 90, height: 90))
		skNode.fillColor = UIColor.green
		skNode.position = CGPoint(x: 5, y: 5)

		skScene.addChild(skNode)

		let material = cubeNode.geometry!.firstMaterial!
		material.diffuse.contents = skScene

		scenes.append(Weak<SKScene>(value: skScene))
		print("sk scenes alive: \(countScenesAlive())")
	}

	func countScenesAlive() -> Int {
		return scenes.filter { return $0.value != nil }.count
	}
}
