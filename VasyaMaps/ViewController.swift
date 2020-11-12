import UIKit
import GoogleMaps
import GooglePlaces
import CoreData

class ViewController: UIViewController, PlacementOnLocation {
    
    
    @IBOutlet weak var mapView: GMSMapView!
    var pickerView = UIPickerView()
    var locations = [NSManagedObject]()

    var locationMager: CLLocationManager?
    
    override func viewDidLoad() {
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 48.465339, longitude: 35.076775, zoom: 15.0)
        
        self.mapView.camera = camera
        
        self.locationMager?.delegate = self
        self.locationMager?.requestWhenInUseAuthorization()
        //        self.locationMager?.desiredAccuracy = kCLLocationAccuracyBest
        
        self.mapView.delegate = self
        
        self.mapView.isMyLocationEnabled = true
        self.mapView.settings.myLocationButton = true
        self.mapView.settings.compassButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataValues.shared.entityLocation)
        
        do {
            AppDelegate.location = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
        
        placementOnLocation(entity: AppDelegate.location, mapView: self.mapView)
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

extension ViewController: GMSMapViewDelegate, LocationProtocol {
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        rememberLocation(coordinate, self.pickerView, self.mapView, self)
    }
    
}

extension ViewController {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 7
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return PinColor.Red.rawValue
        case 1:
            return PinColor.Violet.rawValue
        case 2:
            return PinColor.Blue.rawValue
        case 3:
            return PinColor.Black.rawValue
        case 4:
            return PinColor.Yellow.rawValue
        case 5:
            return PinColor.Green.rawValue
        default:
            return PinColor.Gray.rawValue
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            Color.shared.color = .Red
        case 1:
            Color.shared.color = .Violet
        case 2:
            Color.shared.color = .Blue
        case 3:
            Color.shared.color = .Black
        case 4:
            Color.shared.color = .Yellow
        case 5:
            Color.shared.color = .Green
        case 6:
            Color.shared.color = .Gray
        default:
            break
        }
    }
}
