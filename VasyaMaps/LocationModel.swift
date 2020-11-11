import Foundation
import GoogleMaps
import UIKit
import CoreData

protocol LocationProtocol: UIPickerViewDelegate, UIPickerViewDataSource {
    func rememberLocation(_ coordinate: CLLocationCoordinate2D, _ colorPickerView: UIPickerView, _ arrOfLocations: [NSManagedObject], _ mapView: GMSMapView, _ vc: UIViewController)
}

extension LocationProtocol {
    func rememberLocation(_ coordinate: CLLocationCoordinate2D, _ colorPickerView: UIPickerView, _ arrOfLocations: [NSManageObject], _ mapView: GMSMapView, _ vc: UIViewController) {
        
        var savedLocation = arrOfLocations
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffectView.frame = vc.view.bounds
        
        let alert = UIAlertController(title: SaveLocationAlert.shared.title, message: SaveLocationAlert.shared.alertMessage, preferredStyle: .alert)
            
        alert.addTextField { (textField) in
            textField.placeholder = SaveLocationAlert.shared.enterName
        }
        
        colorPickerView.delegate = self
        colorPickerView.dataSource = self
        colorPickerView.frame = CGRect(x: 40, y: 70, width: alert.view.frame.width / 2, height: 140)
        alert.view.addSubview(colorPickerView)
        
        let cancelAction = UIAlertAction(title: SaveLocationAlert.shared.cancelAction, style: .cancel, handler: nil)

        
        alert.addAction(cancelAction)
        vc.present(alert, animated: true, completion: nil)
        blurVisualEffectView.removeFromSuperview()

        }
    
    
}
