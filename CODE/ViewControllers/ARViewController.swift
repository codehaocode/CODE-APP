//
//  ARViewController.swift
//  CODE
//
//  Created by Yuhao Zhong on 27.11.19.
//  Copyright © 2019 CODE. All rights reserved.
//

import UIKit
import SceneKit
import ARKit



class ARViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        
//        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        sceneView.autoenablesDefaultLighting = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = [.vertical]
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    func createWall(planeAnchor: ARPlaneAnchor) -> SCNNode {
        
        let node = SCNNode()
        
        let geometry = SCNPlane(width:CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        node.geometry = geometry
        
        node.eulerAngles.x = -Float.pi / 2
        node.opacity = 0.2
        
        return node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        if !hoopAdded {
        let wall = createWall(planeAnchor: planeAnchor)
        node.addChildNode(wall)
        wall.runAction(waitRemoveAction)
        }
    }
    
    var waitRemoveAction: SCNAction {
        return .sequence([.wait(duration: 2.0), .fadeOut(duration: 2.0), .removeFromParentNode()])
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor,
            let planeNode = node.childNodes.first,
            let plane = planeNode.geometry as? SCNPlane
            else { return }
        
        planeNode.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
        plane.width = CGFloat(planeAnchor.extent.x)
        plane.height = CGFloat(planeAnchor.extent.z)
    }
    
    func addHoop(result: ARHitTestResult) {
        // Retrieve the scene file and locate the Hoop node
        let hoopScene = SCNScene(named: "art.scnassets/hoop.scn")
        
        guard let hoopNode = hoopScene?.rootNode.childNode(withName: "Hoop", recursively: false) else {
            return
        }
        
        // Place the node in the correct position
        
        let planePosition = result.worldTransform.columns.3
        hoopNode.position = SCNVector3(planePosition.x, planePosition.y, planePosition.z
        )
        
        
        hoopNode.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(node: hoopNode, options: [SCNPhysicsShape.Option.type : SCNPhysicsShape.ShapeType.concavePolyhedron]))
        
        // Add the node to the scene
        sceneView.scene.rootNode.addChildNode(hoopNode)
        
    }
    
    func createBasketball() {
        guard let currentFrame = sceneView.session.currentFrame else { return }
        
        let ball = SCNNode(geometry: SCNSphere(radius: 0.2))
        ball.geometry?.firstMaterial?.diffuse.contents = UIColor.orange
        
        let cameraTransform = SCNMatrix4(currentFrame.camera.transform)
        ball.transform = cameraTransform
        
        let physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(node:ball, options: [SCNPhysicsShape.Option.collisionMargin: 0.01]))
        ball.physicsBody = physicsBody
        
        let power = Float(10.0)
        let force = SCNVector3(-cameraTransform.m31*power, -cameraTransform.m32*power, -cameraTransform.m33*power)
        
        ball.physicsBody?.applyForce(force, asImpulse: true)
        
        sceneView.scene.rootNode.addChildNode(ball)
        
    }
    
    var hoopAdded = false
    
    @IBAction func screenTapped(_ sender: UITapGestureRecognizer) {
        
        if !hoopAdded {
            let touchLocation = sender.location(in: sceneView)
            let hitTestResult = sceneView.hitTest(touchLocation, types: [.existingPlane])
            
            if let result = hitTestResult.first{
                print("Ray intersected a discovered plane")
                addHoop(result: result)
                hoopAdded = true
            }
        } else {
            createBasketball()
        }
        
    }
    

     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
 
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
