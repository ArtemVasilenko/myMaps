import Foundation
import SwiftEntryKit
import CoreData
import GoogleMaps

protocol CustomALertProtocol {
    func showCustomAlert(markerTitle: String, country: String, city: String, address: String, location: NSManagedObject, marker: GMSMarker)
    
    func setLocationValuesInCustomAlert(tapMarker: GMSMarker) -> NSManagedObject
}


extension CustomALertProtocol {
    
    func showCustomAlert(markerTitle: String, country: String, city: String, address: String, location: NSManagedObject, marker: GMSMarker) {
        
        SwiftEntryKit.display(entry: AlertPopUpView(with: CustomAlert.shared.setupMessage(title: markerTitle, description: "\(country), \(city), \(address)"), location: location, marker: marker), using: CustomAlert.shared.setupAttributes())
        
    }
    
    func setLocationValuesInCustomAlert(tapMarker: GMSMarker) -> NSManagedObject {
        var location = NSManagedObject()
        let coreLocations = AppDelegate.location
        
        for markerLocation in coreLocations {
            let name = markerLocation.value(forKey: CoreDataValues.attributeName.rawValue) ?? ""
            let longtitude = markerLocation.value(forKey: CoreDataValues.attributeLongtitude.rawValue) ?? ""
            let latitude = markerLocation.value(forKey: CoreDataValues.attributeLatitude.rawValue) ?? ""
            
            if tapMarker.title == name as? String && tapMarker.position.longitude == longtitude as! CLLocationDegrees && tapMarker.position.latitude == latitude as! CLLocationDegrees {
                location = markerLocation
                print(location)
                print("sudoy!")
            }
            
        }
        
        return location
    }

}
