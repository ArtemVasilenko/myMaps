import Foundation
import GoogleMaps
import UIKit
import CoreData

protocol UpdateMarkerProtocol {
    func updateMarker(marker: GMSMarker) -> GMSMarker

}

protocol LocationProtocol: UIPickerViewDelegate, UIPickerViewDataSource, SetMarkerProtocol {
    func rememberLocation(_ coordinate: CLLocationCoordinate2D, _ colorPickerView: UIPickerView, _ mapView: GMSMapView, _ vc: UIViewController)
    
}

extension LocationProtocol {
    func rememberLocation(_ coordinate: CLLocationCoordinate2D, _ colorPickerView: UIPickerView, _ mapView: GMSMapView, _ vc: UIViewController) {
        
        let alert = UIAlertController(title: SaveLocationAlert.shared.title, message: SaveLocationAlert.shared.alertMessage, preferredStyle: .alert)
            
        alert.addTextField { (textField) in }
        
        colorPickerView.delegate = self
        colorPickerView.dataSource = self
        colorPickerView.frame = CGRect(x: 30, y: 70, width: alert.view.frame.width / 2, height: 140)
        alert.view.addSubview(colorPickerView)
        
        let okAction = UIAlertAction(title: SaveLocationAlert.shared.okAction, style: .default) { (action) in
            
            guard alert.textFields![0].text != "" else { return }
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let entity = NSEntityDescription.entity(forEntityName: CoreDataValues.entityLocation.rawValue, in: managedContext) ?? NSEntityDescription()
            
            let location = NSManagedObject(entity: entity, insertInto: managedContext)
            
            location.setValue(alert.textFields![0].text, forKey: CoreDataValues.attributeName.rawValue)
            location.setValue(Float(coordinate.longitude), forKey: CoreDataValues.attributeLongtitude.rawValue)
            location.setValue(Float(coordinate.latitude), forKey: CoreDataValues.attributeLatitude.rawValue)
            location.setValue(Color.shared.color?.descriptionImage, forKey: CoreDataValues.attributeColor.rawValue)
            
            do {
                try managedContext.save()
                AppDelegate.location.append(location)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
              }
            
            self.createAndSetMarker(entity: location, mapView: mapView)
            
            print(AppDelegate.location)
        }
        
        let cancelAction = UIAlertAction(title: SaveLocationAlert.shared.cancelAction, style: .cancel, handler: nil)

        alert.addAction(cancelAction)
        alert.addAction(okAction)
        vc.present(alert, animated: true, completion: nil)
        
        }
}
