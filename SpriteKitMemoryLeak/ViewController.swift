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


// create a SCNScene with a cube
// create a SKScene, and use it as diffuse content for the cube
class ViewController: UIViewController {

	@IBOutlet weak var scnView: SCNView!

	@IBAction func buttonPressed(_ sender: AnyObject) {
		// on button pressed, create a new SKScene
		// and use it as the material for the cube instead of the previous one
		self.dismiss(animated: true, completion: nil)
	}

	weak var delegate: ViewControllerDelegate?

	override func viewDidLoad() {
		super.viewDidLoad()

		let scnScene = SCNScene()
		scnView.scene = scnScene

		// setup SceneKit scene
		let cameraNode = SCNNode()
		cameraNode.camera = SCNCamera()
		cameraNode.position = SCNVector3(x: 0, y: 0, z: 25)
		scnScene.rootNode.addChildNode(cameraNode)

		let cubeNode = SCNNode()
		cubeNode.geometry = SCNBox(width: 5, height: 5, length: 5, chamferRadius: 0)
		scnScene.rootNode.addChildNode(cubeNode)

		// setup SKScene scene
		let skScene = SKScene()
		skScene.backgroundColor = UIColor.black
		skScene.size = CGSize(width: 100, height: 100)

		let skNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 90, height: 90))
		skNode.fillColor = UIColor.green
		skNode.position = CGPoint(x: 5, y: 5)

		skScene.addChild(skNode)

		let material = cubeNode.geometry!.firstMaterial!
		material.diffuse.contents = skScene
		delegate?.register(scene: skScene)
	}
}

protocol ViewControllerDelegate: class {
	func register(scene: SKScene)
}
