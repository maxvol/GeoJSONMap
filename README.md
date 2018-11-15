# GeoJSONMap
Build maps from GeoJSON with MapKit or SpriteKit.
SpriteKit maps can be displayed as planes in ARKit.

Basic usage:

```swift
import GeoJSONMap

final class ViewController: UIViewController {
    let map = GJMap<ViewController>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.map.delegate = self
        self.map.add(featureCollection: /* ... */)
        
        let mapRect = self.map.boundingMapRect
        let cgSize = mapRect.size.cgSize
        let scene = SKScene(size: cgSize)
        for node in self.map.nodes {
            scene.addChild(node)
        }
        
        /* use `scene` */
    }
}

public struct Properties: Codable {
    let prop0: String
    let prop1: Int?
}

extension ViewController: GJMapDelegate {
    typealias P = Properties

    func map(_ map: GJMap<ViewController>, nodeFor feature: GJFeature<Properties>) -> SKNode? {
        let mapRect = self.map.boundingMapRect
        let cgSize = mapRect.size.cgSize
        switch feature.geometry {
        case .point(let coordinate):
            let point = MKMapPoint(coordinate)
            guard let cgPoint = try? point.cgPoint(from: mapRect, to: cgSize) else { return nil }
            let node = SKShapeNode(circleOfRadius: /* ... */)
            node.position = cgPoint
            /* ... */
            return node
        case .lineString(let coordinates):
            do {
                var points = try coordinates.map { try MKMapPoint($0).cgPoint(from: mapRect, to: cgSize) }
                let node = SKShapeNode(splinePoints: &points, count: points.count)
                /* ... */
                return node
            } catch {
                print(error)
                return nil
            }
        }
    }
}
```
Carthage setup.

```
github "maxvol/GeoJSONMap" ~> 0.0.1
```

