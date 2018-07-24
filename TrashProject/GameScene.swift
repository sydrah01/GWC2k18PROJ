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
        var i = 0
        for trashImageName in trashImageNames {
            addPiece(imageName:trashImageName, nodeName: "trash", startingPosition: CGPoint(x:75 * i, y: 10))
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
        addChild(node)
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
