//
//  ContentView.swift
//  Baristeam Latte Art
//
//  Created by Jayson Adrian Sunaryo on 23/04/24.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)

        // Create a cube model
//        let entity = try? Entity.load(named: "Scene.usdz")
//        entity?.scale = .init(repeating: 0.02)
        let circle = MeshResource.generatePlane(width: 0.08, depth: 0.08, cornerRadius: 100)
        let material = SimpleMaterial(color: .brown , isMetallic: false)
        let circleEntity = ModelEntity(mesh: circle, materials: [material])
        
        // Create horizontal plane anchor for the content
        let anchor = AnchorEntity(.image(group: "AR_Assets", name: "CoffeeLogo"))
        anchor.addChild(circleEntity)

        // Add the horizontal plane anchor to the scene
        arView.scene.anchors.append(anchor)
        
//        // Set up touch gesture recognizer for drawing
//        let panGesture = UIPanGestureRecognizer(target: coordinator, action: #selector(coordinator.handlePan(_:)))
//        arView.addGestureRecognizer(panGesture)
//        
//        arView.addGestureRecognizer(panGesture)

        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#Preview {
    ContentView()
}
