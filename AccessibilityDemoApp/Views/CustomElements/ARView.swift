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
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
         
        // Setup AR session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        config.isAutoFocusEnabled = true
        
        arView.session.run(config)
        
        addCelestialBodies(to: arView)
        setupDistanceChecking(for: arView)
         
        return arView
    }
     
    func updateUIView(_ uiView: ARView, context: Context) {}
     
    private func addCelestialBodies(to arView: ARView) {
        // Moon
        let moonAnchor = AnchorEntity(world: [2, 0, -3])
        let moonMesh = MeshResource.generateSphere(radius: 0.2)
        var moonMaterial = SimpleMaterial()
        moonMaterial.color = PhysicallyBasedMaterial.BaseColor(tint: .gray)
        moonMaterial.roughness = .float(0.5)
        moonMaterial.metallic = .float(0.0)
        let moonEntity = ModelEntity(mesh: moonMesh, materials: [moonMaterial])
        moonEntity.name = "moon"
        
        // Add physics body for better interaction
        moonEntity.collision = CollisionComponent(shapes: [.generateSphere(radius: 0.2)])
        moonEntity.generateCollisionShapes(recursive: true)
        moonAnchor.addChild(moonEntity)
        
        // Venus
        let venusAnchor = AnchorEntity(world: [-1, 0, -2])
        let venusMesh = MeshResource.generateSphere(radius: 0.15)
        var venusMaterial = SimpleMaterial()
        venusMaterial.color = PhysicallyBasedMaterial.BaseColor(tint: .yellow)
        venusMaterial.roughness = .float(0.5)
        venusMaterial.metallic = .float(0.0)
        let venusEntity = ModelEntity(mesh: venusMesh, materials: [venusMaterial])
        venusEntity.name = "venus"
        venusEntity.collision = CollisionComponent(shapes: [.generateSphere(radius: 0.15)])
        venusEntity.generateCollisionShapes(recursive: true)
        venusAnchor.addChild(venusEntity)
        
        // Mars
        let marsAnchor = AnchorEntity(world: [0, 1, -4])
        let marsMesh = MeshResource.generateSphere(radius: 0.18)
        var marsMaterial = SimpleMaterial()
        marsMaterial.color = PhysicallyBasedMaterial.BaseColor(tint: .red)
        marsMaterial.roughness = .float(0.5)
        marsMaterial.metallic = .float(0.0)
        let marsEntity = ModelEntity(mesh: marsMesh, materials: [marsMaterial])
        marsEntity.name = "mars"
        marsEntity.collision = CollisionComponent(shapes: [.generateSphere(radius: 0.18)])
        marsEntity.generateCollisionShapes(recursive: true)
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
                        }
                    }
                }
            }
            nearestDistance = minDistance
        }
    }
}
