//
//  GameScene.swift
//  PachinkoGame
//
//  Created by Logesh Palani on 27/08/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var balls = ["ballBlue", "ballCyan", "ballGreen", "ballGrey", "ballPurple", "ballRed", "ballYellow"]
    var scoreLabel: SKLabelNode!
    
    var score = 0 {
        didSet{
            scoreLabel.text = "Score \(score)"
        }
    }
    var ballsLimit = 5
    var ballsUsageCount = 0
    var editLabel: SKLabelNode!
    
    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
            
        }
    }
    var restartLabel: SKLabelNode!
    var gameOverLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.horizontalAlignmentMode = .left
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld .contactDelegate = self
        
        addBouncer(at: CGPoint(x: 0, y: 0))
        addBouncer(at: CGPoint(x: 256, y: 0))
        addBouncer(at: CGPoint(x: 512, y: 0))
        addBouncer(at: CGPoint(x: 768, y: 0))
        addBouncer(at: CGPoint(x: 1024, y: 0))
        
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        let objects = nodes(at: location)
        
        if restartLabel != nil && objects.contains(restartLabel) {
            restartLabel.isHidden = !restartLabel.isHidden
            gameOverLabel.isHidden = !gameOverLabel.isHidden
            ballsUsageCount = 0
            score = 0
            return
        }
        
        if objects.contains(editLabel) {
            editingMode.toggle()
        }
        else{
            if editingMode {
                let size = CGSize(width: Int.random(in: 18..<128), height: 64)
                let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                box.zRotation = CGFloat.random(in: 0...3)
                box.position = location
                
                box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                box.physicsBody?.isDynamic = false
                box.name = "obstacle"
                addChild(box)
            
            } else if ballsUsageCount < ballsLimit{
                let ball = SKSpriteNode(imageNamed: balls.randomElement() ?? "ballRed")
                ball.position = location
                ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
                ball.physicsBody?.restitution = 0.4
                ball.name = "ball"
                ball.physicsBody?.contactTestBitMask = ball.physicsBody!.collisionBitMask
                addChild(ball)
                ballsUsageCount += 1
            } else {
                gameOverLabel = SKLabelNode(fontNamed: "Chalkduster")
                gameOverLabel.text = "Game Over"
                gameOverLabel.position = CGPoint(x: 512, y: 420)
                addChild(gameOverLabel)
                restartLabel = SKLabelNode(fontNamed: "Chalkduster")
                restartLabel.text = "Restart"
                restartLabel.position = CGPoint(x: 512, y: 360)
                addChild(restartLabel)
            }
        }
    }
    func addBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode

        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"

        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        slotBase.position = position
        slotGlow.position = position
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        
        slotGlow.run(spinForever)
    }
    func collectionBetween(ball: SKNode, object: SKNode){
        if object.name == "good" {
            score += 10
            destroy(ball: ball)
        } else if object.name == "bad"{
            score -= 20
            destroy(ball: ball)
        }else if object.name == "obstacle"{
            destroy(ball: object)
            score += 1
        }
        
    }
    func destroy(ball: SKNode) {
        
        if let particle = SKEmitterNode(fileNamed: "FireParticles"){
            particle.position = ball.position
            addChild(particle)
        }
        
        ball.removeFromParent()
    }
    func didBegin(_ contact: SKPhysicsContact) {
        guard let NodeA = contact.bodyA.node else { return }
        guard let NodeB = contact.bodyB.node else { return }
        
        if NodeA.name == "ball" {
            collectionBetween(ball: NodeA, object: NodeB)
        }else if NodeB.name == "ball"{
            collectionBetween(ball: NodeB, object: NodeA)
        }
    }
}

