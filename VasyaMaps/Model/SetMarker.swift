import Foundation
import GoogleMaps
import CoreData

protocol SetMarkerProtocol {
    
    func createAndSetMarker(entity: NSManagedObject, mapView: GMSMapView)
    func createAndSetMarker(_ coordinate: CLLocationCoordinate2D, _ title: String, _ mapView: GMSMapView, _ colorOfMarker: UIColor?)
}

extension SetMarkerProtocol {
    
    func createAndSetMarker(entity: NSManagedObject, mapView: GMSMapView) {
        let marker = GMSMarker()
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let managedContext = appDelegate.persistentContainer.viewContext
        
        let title = entity.value(forKey: "name") as? String
        let longtitude = entity.value(forKey: "longtitude") as? Double
        let latitude = entity.value(forKey: "latitude") as? Double
        let color = entity.value(forKey: "colorItem") as? String
        
        marker.title = title
        marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude!), longitude: CLLocationDegrees(longtitude!))
        marker.icon = GMSMarker.markerImage(with: UIColor.colorWith(name: color ?? ""))
        
        marker.map = mapView
    }
    
    func createAndSetMarker(_ coordinate: CLLocationCoordinate2D, _ title: String, _ mapView: GMSMapView, _ colorOfMarker: UIColor?){
        
        let marker = GMSMarker()
        marker.position = coordinate
        marker.title = title
        marker.map = mapView
        marker.icon = GMSMarker.markerImage(with: colorOfMarker ?? .systemGray)
        
    }
}
