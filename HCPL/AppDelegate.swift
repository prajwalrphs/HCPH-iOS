
import UIKit
import CoreData
import AMTabView
import CoreLocation
import ArcGIS
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,CLLocationManagerDelegate {


    var window: UIWindow?
    let locationManager = CLLocationManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
//        print("applicationonoff==>\(onoff ?? "")")
//
//        if onoff == nil{
//            print("isEmpty")
//        }else{
//            print("isEmpty Not")
//        }
        
        if let favorites = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF) {
            print("Favorites exists")

            if favorites.isEmpty {
                print("Favorites is empty")
            } else {
                print("Favorites is not empty, it has \(favorites.count) items")
            }
        } else {
            print("Favorites is nil")
            if UITraitCollection.current.userInterfaceStyle == .dark {
                print("Dark mode")
                UserDefaults.standard.set("on", forKey: AppConstant.ISONISOFF)
            }
            else {
                print("Light mode")
                UserDefaults.standard.set("off", forKey: AppConstant.ISONISOFF)
            }
        }
        

        GMSPlacesClient.provideAPIKey(AppConstant.googleApiKey)
        GMSServices.provideAPIKey(AppConstant.googleApiKey)
        
        AGSArcGISRuntimeEnvironment.apiKey = "AAPK7369e57cb9ef4b58967beda270b251cdzdmK1GUiCL4htVQXyVP0MbYgA0I8rXzleRIMGMrZLbeJzHFtXDm8jBjO1HvvA5R4"
      //AGSArcGISRuntimeEnvironment.setLicenseKey("runtimelite,1000,rud2361000057,none,TRB3LNBHPDH4F5KHT180")

        do{
            let result =  try AGSArcGISRuntimeEnvironment.setLicenseKey("runtimelite,1000,rud2361000057,none,TRB3LNBHPDH4F5KHT180")
            print("License Result : \(result.licenseStatus)")
        }catch{
            print("License Not Set")
        }
        

       
       
        
        
        //AGSArcGISRuntimeEnvironment.setLicense("runtimelite,1000,rud2361000057,none,TRB3LNBHPDH4F5KHT180");
        self.locationManager.requestAlwaysAuthorization()

        IQKeyboardManager.shared.enable = true
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
//        AMTabView.settings.ballColor = #colorLiteral(red: 0.4235294118, green: 0.7490196078, blue: 0.3529411765, alpha: 1)
//        AMTabView.settings.tabColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 0.5)
//        AMTabView.settings.selectedTabTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        AMTabView.settings.unSelectedTabTintColor = #colorLiteral(red: 0.4235294118, green: 0.7490196078, blue: 0.3529411765, alpha: 1)
//
//        // Chnage the animation duration
//        AMTabView.settings.animationDuration = 1
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "HCPL")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

