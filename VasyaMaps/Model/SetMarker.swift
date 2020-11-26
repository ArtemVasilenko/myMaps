import Foundation
import GoogleMaps
import CoreData

protocol SetMarkerProtocol {
    func createAndSetMarker(entity: NSManagedObject, mapView: GMSMapView)

}

extension SetMarkerProtocol {
    
    func createAndSetMarker(entity: NSManagedObject, mapView: GMSMapView) {
        let marker = GMSMarker()
        
        let title = entity.value(forKey: CoreDataValues.attributeName.rawValue) as? String
        let longtitude = entity.value(forKey: CoreDataValues.attributeLongtitude.rawValue) as? Double
        let latitude = entity.value(forKey: CoreDataValues.attributeLatitude.rawValue) as? Double
        let color = entity.value(forKey: CoreDataValues.attributeColor.rawValue) as? String
        
        marker.title = title
        marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude!), longitude: CLLocationDegrees(longtitude!))
        marker.icon = GMSMarker.markerImage(with: UIColor.colorWith(name: color ?? ""))
        
        marker.map = mapView
    }
    
}
