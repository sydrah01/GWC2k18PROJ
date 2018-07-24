//
//  GameScene.swift
//  TrashProject
//
//  Created by Sydrah Al-saegh on 7/23/18.
//  Copyright © 2018 Sydrah Al-saegh. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    
    private var caughtTrash : SKNode?
    
    private let trashImageNames = [
        "diapers",
        "straw"
    ]
    
    override func sceneDidLoad() {
        // Slow down gravity
        physicsWorld.gravity = CGVector(dx: 0, dy: -1.5)
        addBucket(bucketName: "trashBucket", startingPosition: CGPoint(x: -300, y: -600), size: CGPoint(x: 200, y: 300))
        addBucket(bucketName: "recyclingBucket", startingPosition: CGPoint(x: -100, y: -600), size: CGPoint(x: 200, y: 300))
        addBucket(bucketName: "compostBucket", startingPosition: CGPoint(x: 100, y: -600), size: CGPoint(x: 200, y: 300))

        var i = 0
        for trashImageName in trashImageNames {
            addPiece(imageName:trashImageName, nodeName: "trash", startingPosition: CGPoint(x:75 * i, y: 600))
            i += 1
        }
    }
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//titleLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
   }
    
    func addPiece(imageName: String, nodeName: String, startingPosition: CGPoint) {
        let node = SKSpriteNode(imageNamed: imageName)
        node.name = nodeName
        node.position = startingPosition
        node.physicsBody = SKPhysicsBody(texture: node.texture!,
                                         size: node.texture!.size())
        addChild(node)
    }
    
    func addBucket(bucketName: String, startingPosition: CGPoint, size: CGPoint) {
        var splinePoints = [CGPoint(x: 0, y: size.y),
                            CGPoint(x: 0.20 * size.x, y: 0),
                            CGPoint(x: 0.80 * size.x, y: 0),
                            CGPoint(x: size.x, y: size.y)]
        let bucket = SKShapeNode(splinePoints: &splinePoints,
                                 count: splinePoints.count)
        bucket.position = startingPosition
        bucket.lineWidth = 5
        bucket.strokeColor = .white
        bucket.physicsBody = SKPhysicsBody(edgeChainFrom: bucket.path!)
        bucket.physicsBody?.restitution = 0.25
        bucket.physicsBody?.isDynamic = false
        addChild(bucket)
    }
    
    func touchBegin(atPoint pos : CGPoint) {
        caughtTrash = atPoint(pos)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let haveCaughtTrash = caughtTrash {
            haveCaughtTrash.position = pos
        }
    }
    
    func touchEnd(atPoint pos : CGPoint) {
        // TODO: Drop into recycle/trash/compost
        caughtTrash = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchBegin(atPoint:touch.location(in: self))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchMoved(toPoint:touch.location(in: self))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchEnd(atPoint:touch.location(in: self))
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchEnd(atPoint:touch.location(in: self))
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
