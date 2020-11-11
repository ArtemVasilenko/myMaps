import UIKit
import GoogleMaps
import CoreData

let googleApiKey = "AIzaSyDIEISIkb-Q_4s7rw72ttXX93Iv4HPZLFY"

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var location = [NSManagedObject]()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey(googleApiKey)
        return true
    }


    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
      
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
}

