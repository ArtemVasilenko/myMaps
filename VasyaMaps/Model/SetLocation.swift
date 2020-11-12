import Foundation
import CoreData
import GoogleMaps

protocol PlacementOnLocation: SetMarkerProtocol {
    func placementOnLocation (entity: [NSManagedObject], mapView: GMSMapView)
}

extension PlacementOnLocation {

    func placementOnLocation (entity: [NSManagedObject], mapView: GMSMapView) {
        
        for value in entity {
            createAndSetMarker(entity: value, mapView: mapView)
        }
        
    }


}
