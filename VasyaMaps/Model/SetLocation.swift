import Foundation
import CoreData
import GoogleMaps

protocol PlacementOnLocation: SetMarkerProtocol {
    func placementOnLocation (entity: [NSManagedObject], mapView: GMSMapView)
    func updateMarkers(mapView: GMSMapView)
    func changeAttribute(entity: NSManagedObject, name: String)
    func deleteMarker(entity: NSManagedObject, marker: GMSMarker)
}

extension PlacementOnLocation {

    func placementOnLocation (entity: [NSManagedObject], mapView: GMSMapView) {
        for value in entity {
            createAndSetMarker(entity: value, mapView: mapView)
        }
    }
    func updateMarkers(mapView: GMSMapView) {
        print("Markers is update!")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataValues.entityLocation.rawValue)
        
        do {
            AppDelegate.location = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        placementOnLocation(entity: AppDelegate.location, mapView: mapView)
    }
    
    func changeAttribute(entity: NSManagedObject, name: String) {
        for i in AppDelegate.location {
            
            if i == entity {
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let managedContext = appDelegate.persistentContainer.viewContext
                                
                i.setValue(name, forKey: CoreDataValues.attributeName.rawValue)
                
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                  }
            
            }
        }
    }
    
    func deleteMarker(entity: NSManagedObject, marker: GMSMarker) {
        
        for i in AppDelegate.location {
            
            if i == entity {
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let managedContext = appDelegate.persistentContainer.viewContext
                
                managedContext.delete(i)
                
                marker.map = nil
            
            }
        }
        
    }

    
}
