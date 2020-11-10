import UIKit
import GoogleMaps
import GooglePlaces

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    var locationMager: CLLocationManager?
    
    override func viewDidLoad() {
            
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 48.465339, longitude: 35.076775, zoom: 15.0)

        self.mapView.camera = camera
        
        self.locationMager?.delegate = self
        self.locationMager?.requestWhenInUseAuthorization()
//        self.locationMager?.desiredAccuracy = kCLLocationAccuracyBest

        self.mapView.isMyLocationEnabled = true
        self.mapView.settings.myLocationButton = true
                    
    }
    
}


extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        guard status == .authorizedWhenInUse else {
            return
        }
        
        self.locationMager?.requestLocation()
        self.mapView.isMyLocationEnabled = true
        self.mapView.settings.myLocationButton = true
//        self.mapView.settings.zoomGestures = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else {
            return
        }
        
        self.mapView.camera = GMSCameraPosition(latitude: location.coordinate.latitude, longitude: 15, zoom: 0, bearing: 0, viewingAngle: 0)
        
        print("Location = \(location)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
