//
//  ContentView.swift
//  Baristeam Latte Art
//
//  Created by Jayson Adrian Sunaryo on 23/04/24.
//

import SwiftUI
import RealityKit
import ARKit
import AVFoundation
import CoreMotion

struct ContentView : View {
    var body: some View {
        VStack {
            SplashScreenView()
        }
    }

}

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
       
        let motion = CMMotionManager()
        var gyroTimer: Timer
    
        let circle = MeshResource.generatePlane(width: 0.08, depth: 0.08, cornerRadius: 100)
        let material = SimpleMaterial(color: .brown , isMetallic: false)
        let circleEntity = ModelEntity(mesh: circle, materials: [material])
        circleEntity.generateCollisionShapes(recursive: true)
        let anchor = AnchorEntity(.image(group: "AR_Assets", name: "CoffeeLogo"))
        
        anchor.addChild(circleEntity)
        arView.scene.anchors.append(anchor)
        
        motion.gyroUpdateInterval = 1 / 60.0
        motion.startGyroUpdates()
//           Configure a timer to fetch the accelerometer data.
        gyroTimer = Timer(fire: Date(), interval: (1 / 60.0),
                 repeats: true, block: { (timer) in
             // Get the gyro data.
             if let data = motion.gyroData {
                let x = data.rotationRate.x
                 if(x < 0) {
                     arView.handleGyro()
                 } else {
//                     isPour = false
                 }
             }
          })

          // Add the timer to the current run loop.
        RunLoop.current.add(gyroTimer, forMode: RunLoop.Mode.default)
//        arView.enableTapGesture()
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
    
}

extension ARView {
    
    func addMilk() -> ModelEntity {
        let milk = MeshResource.generatePlane(width: 0.01, depth: 0.01, cornerRadius: 100)
        let milkMaterial = SimpleMaterial(color: .white, isMetallic: false)
        let milkEntity = ModelEntity(mesh: milk, materials: [milkMaterial])
        milkEntity.position.y = 0.0005
        return milkEntity
    }
    
    func MakeCoffeEntity() -> ModelEntity {
        let circle = MeshResource.generatePlane(width: 0.08, depth: 0.08, cornerRadius: 100)
        let material = SimpleMaterial(color: .brown , isMetallic: false)
        let circleEntity = ModelEntity(mesh: circle, materials: [material])
        
        return circleEntity
    }
    
    func handleGyro() {
        
//        let milk = MeshResource.generateSphere(radius: 0.002)
        let milk = MeshResource.generatePlane(width: 0.005, depth: 0.005, cornerRadius: 100)
        let milkMaterial = SimpleMaterial(color: .white, isMetallic: false)
        let milkEntity = ModelEntity(mesh: milk, materials: [milkMaterial])
//        milkEntity.generateCollisionShapes(recursive: true)
        let clone = milkEntity.clone(recursive: true)
        
//        let anchorEntity = AnchorEntity(world: position)
//        let baseAnchor = AnchorEntity(.image(group: "AR_Assets", name: "CoffeeLogo"))
        
        
//        anchorEntity.addChild(milkEntity)
//        baseAnchor.addChild(anchorEntity)
        
//        self.scene.addAnchor(anchorEntity)
        
        let screenBounds = UIScreen.main.bounds
        let centerX = screenBounds.width / 2.0
        let centerY = screenBounds.height / 2.0
        let centerPoint = CGPoint(x: centerX, y: centerY)
        
        guard let rayResult = self.ray(through: centerPoint) else {return}
        
        let results = self.scene.raycast(origin: rayResult.origin, direction: rayResult.direction)
        
        if let firstResult = results.first {
            var position = firstResult.position
            let anchorEntity = AnchorEntity(world: position)
            //                        position.y += 0.3/2
            //            placeMilk(at: position)
            anchorEntity.addChild(clone)
            self.scene.addAnchor(anchorEntity)
        }
            
//        } else {
//            let results = self.raycast(from: centerPoint, allowing: .estimatedPlane, alignment: .any)
//            
//            if let firstResult = results.first {
//                let position = simd_make_float3(firstResult.worldTransform.columns.3)
//                placeMilk(at: position)
////                placeCube(at: position)
//            }
//        }
        
    }
    
    func enableTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        let tapLocation = recognizer.location(in:self)
        
        guard let rayResult = self.ray(through: tapLocation) else {return}
        
        let results = self.scene.raycast(origin: rayResult.origin, direction: rayResult.direction)

        if let firstResult = results.first {
            var position = firstResult.position
            
            placeMilk(at: position)
        } else {
            let results = self.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .any)
            
            if let firstResult = results.first {
                let position = simd_make_float3(firstResult.worldTransform.columns.3)
                
                placeMilk(at: position)
            } else {
            }
        }
    }
    
    func placeCube(at position: SIMD3<Float>) {
        let mesh = MeshResource.generateBox(size: 0.001)
        let material = SimpleMaterial(color: .white, isMetallic: false)
        let modelEntity = ModelEntity(mesh: mesh, materials: [material])
        modelEntity.generateCollisionShapes(recursive: true)
        
        let anchorEntity = AnchorEntity(world: position)
        anchorEntity.addChild(modelEntity)
        
        self.scene.addAnchor(anchorEntity)
    }
    
    func placeMilk(at position: SIMD3<Float>) {
        let milk = MeshResource.generateSphere(radius: 0.002)
        let milkMaterial = SimpleMaterial(color: .white, isMetallic: false)
        let milkEntity = ModelEntity(mesh: milk, materials: [milkMaterial])
        milkEntity.generateCollisionShapes(recursive: true)
        
        let anchorEntity = AnchorEntity(world: position)
//        let baseAnchor = AnchorEntity(.image(group: "AR_Assets", name: "CoffeeLogo"))
        
        
        anchorEntity.addChild(milkEntity)
//        baseAnchor.addChild(anchorEntity)
        
        self.scene.addAnchor(anchorEntity)
        
//        milkEntity.move(to: Transform(translation: .init(x:0, y:0, z:0)), relativeTo: nil, duration: 0.5, timingFunction: .easeInOut)
    }
}

#Preview {
    ContentView()
}
