import Foundation
import GoogleMaps
import CoreData

protocol SetMarkerProtocol {
    func createAndSetMarker(entity: NSManagedObject, mapView: GMSMapView)
}

extension SetMarkerProtocol {
    
    func createAndSetMarker(entity: NSManagedObject, mapView: GMSMapView) {
        let marker = GMSMarker()
        
        let title = entity.value(forKey: CoreDataValues.shared.attributeName) as? String
        let longtitude = entity.value(forKey: CoreDataValues.shared.attributeLongtitude) as? Double
        let latitude = entity.value(forKey: CoreDataValues.shared.attributeLatitude) as? Double
        let color = entity.value(forKey: CoreDataValues.shared.attributeColor) as? String
        
        marker.title = title
        marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude!), longitude: CLLocationDegrees(longtitude!))
        marker.icon = GMSMarker.markerImage(with: UIColor.colorWith(name: color ?? ""))
        
        marker.map = mapView
    }
    
}
