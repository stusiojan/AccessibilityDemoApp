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
    @Binding var screenSpaceDistance: CGFloat
    let trackedEntityName: String
    var onObjectClose: (String) -> Void
    var onObjectLeave: (String) -> Void
    var onTrackedEntityUpdate: (CGFloat) -> Void
    
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
        
        
        arView.scene.addAnchor(moonAnchor)
        arView.scene.addAnchor(venusAnchor)
        arView.scene.addAnchor(marsAnchor)
    }
    
    private func setupDistanceChecking(for arView: ARView) {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            guard let camera = arView.session.currentFrame?.camera else { return }
            
            let screenCenter = CGPoint(x: arView.bounds.midX, y: arView.bounds.midY)
            var minScreenDistance: CGFloat = .infinity
            var minRealDistance: Float = .infinity
            
            var detectedThisFrame = Set<String>()
            
            for anchor in arView.scene.anchors {
                for entity in anchor.children {
                    guard let modelEntity = entity as? ModelEntity else { continue }
                    
                    let entityPosition = entity.position(relativeTo: nil)
                    guard let screenPos = arView.project(entityPosition) else { continue }
                    
                    let screenDistance = distance(screenCenter, screenPos)
                    
                    if modelEntity.name == trackedEntityName {
                        DispatchQueue.main.async {
                            onTrackedEntityUpdate(screenDistance)
                        }
                    }
                    
                    let cameraPosition = SIMD3<Float>(camera.transform.columns.3.x,
                                                      camera.transform.columns.3.y,
                                                      camera.transform.columns.3.z)
                    let realDistance = length(entityPosition - cameraPosition)
                    
                    if screenDistance < minScreenDistance {
                        minScreenDistance = screenDistance
                        minRealDistance = realDistance
                    }
                    
                    let screenThreshold: CGFloat = 50 // pixels
                    if screenDistance < screenThreshold {
                        detectedThisFrame.insert(modelEntity.name)
                        onObjectClose(modelEntity.name)
                    }
                }
            }
            
            DispatchQueue.main.async {
                nearestDistance = minRealDistance
                screenSpaceDistance = minScreenDistance
                
                for entityName in ["moon", "venus", "mars"] {
                    if !detectedThisFrame.contains(entityName) {
                        onObjectLeave(entityName)
                    }
                }
            }
        }
    }
    
    /// Helper function to calculate distance between two CGPoints
    private func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        let xDist = a.x - b.x
        let yDist = a.y - b.y
        return sqrt(xDist * xDist + yDist * yDist)
    }
    
    // TODO: delete
    /// Helper function to determine direction
    private func getDirection(from center: CGPoint, to point: CGPoint) -> String {
        let dx = point.x - center.x
        let dy = point.y - center.y
        
        let angle = atan2(dy, dx)
        let degrees = angle * 180 / .pi
        
        switch degrees {
        case -22.5...22.5:
            return "right"
        case 22.5...67.5:
            return "bottom-right"
        case 67.5...112.5:
            return "bottom"
        case 112.5...157.5:
            return "bottom-left"
        case 157.5...180, -180...(-157.5):
            return "left"
        case -157.5...(-112.5):
            return "top-left"
        case -112.5...(-67.5):
            return "top"
        case -67.5...(-22.5):
            return "top-right"
        default:
            return "center"
        }
    }
}
