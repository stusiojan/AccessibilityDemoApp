//
//  ARView.swift
//  AccessibilityDemoApp
//
//  Created by Jan Stusio on 27/01/2025.
//

import SwiftUI
import ARKit
import RealityKit
import Combine
 
struct CustomARView: UIViewRepresentable {
    @Binding var nearestDistance: Float
    var onObjectClose: (String) -> Void
     
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
         
        // Setup AR session
        let config = ARWorldTrackingConfiguration()
        arView.session.run(config)
         
        addCelestialBodies(to: arView)
        setupDistanceChecking(for: arView)
         
        return arView
    }
     
    func updateUIView(_ uiView: ARView, context: Context) {}
     
    private func addCelestialBodies(to arView: ARView) {
        // Create and position Moon
        let moonAnchor = AnchorEntity(world: [2, 0, -3])
        let moonMesh = MeshResource.generateSphere(radius: 0.2)
        let moonMaterial = SimpleMaterial(color: .gray, roughness: 0.3, isMetallic: false)
        let moonEntity = ModelEntity(mesh: moonMesh, materials: [moonMaterial])
        moonEntity.name = "moon"
        moonAnchor.addChild(moonEntity)
         
        // Create and position Venus
        let venusAnchor = AnchorEntity(world: [-1, 0, -2])
        let venusMesh = MeshResource.generateSphere(radius: 0.15)
        let venusMaterial = SimpleMaterial(color: .orange, roughness: 0.3, isMetallic: false)
        let venusEntity = ModelEntity(mesh: venusMesh, materials: [venusMaterial])
        venusEntity.name = "venus"
        venusAnchor.addChild(venusEntity)
         
        // Create and position Mars
        let marsAnchor = AnchorEntity(world: [0, 1, -4])
        let marsMesh = MeshResource.generateSphere(radius: 0.18)
        let marsMaterial = SimpleMaterial(color: .red, roughness: 0.3, isMetallic: false)
        let marsEntity = ModelEntity(mesh: marsMesh, materials: [marsMaterial])
        marsEntity.name = "mars"
        marsAnchor.addChild(marsEntity)
         
        // Add all anchors to the scene
        arView.scene.addAnchor(moonAnchor)
        arView.scene.addAnchor(venusAnchor)
        arView.scene.addAnchor(marsAnchor)
    }
     
    private func setupDistanceChecking(for arView: ARView) {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            guard let camera = arView.session.currentFrame?.camera else { return }
            
            let cameraTransform = camera.transform
            let cameraPosition = SIMD3<Float>(cameraTransform.columns.3.x,
                                            cameraTransform.columns.3.y,
                                            cameraTransform.columns.3.z)
            
            let cameraForward = normalize(SIMD3<Float>(-cameraTransform.columns.2.x,
                                                      -cameraTransform.columns.2.y,
                                                      -cameraTransform.columns.2.z))
            
            var minDistance: Float = .infinity
            
            for anchor in arView.scene.anchors {
                for entity in anchor.children {
                    guard let modelEntity = entity as? ModelEntity else { continue }
                     
                    let objectPosition = entity.position(relativeTo: nil)
                    let vectorToObject = objectPosition - cameraPosition
                    let distanceToObject = length(vectorToObject)

                    let normalizedVectorToObject = normalize(vectorToObject)
                    let dotProduct: Float = dot(normalizedVectorToObject, cameraForward)
                    let angleThreshold: Float = cos(0.1) // Approximately 5.7 degrees
                     
                    if dotProduct > angleThreshold && distanceToObject < minDistance {
                        minDistance = distanceToObject
                        
                        if distanceToObject < 1.5 { // 1.5 meters threshold
                            onObjectClose(modelEntity.name)
                            print("checked")
                        }
                    }
                }
            }
            nearestDistance = minDistance
        }
    }
}
