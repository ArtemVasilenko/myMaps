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
        
        print(AppDelegate.location)
    }
    
    func changeAttribute(entity: NSManagedObject, name: String) {
        
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let managedContext = appDelegate.persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataValues.entityLocation.rawValue)
                
                do {
                    let objects = try managedContext.fetch(fetchRequest)
                    for object in objects {
                        if object == entity {
                            object.setValue(name, forKey: CoreDataValues.attributeName.rawValue)
                        }
                    }
                    
                    try managedContext.save()

                } catch let error as NSError {
                    print("Could not delete object. \(error), \(error.userInfo)")
                }
    }
    
    func deleteMarker(entity: NSManagedObject, marker: GMSMarker) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataValues.entityLocation.rawValue)
        
        do {
            let objects = try managedContext.fetch(fetchRequest)
            for object in objects {
                if object == entity {
                    managedContext.delete(object)
                }
            }
            
            try managedContext.save()
            marker.map = nil

        } catch let error as NSError {
            print("Could not delete object. \(error), \(error.userInfo)")
        }
    }
}
