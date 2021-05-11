
import UIKit
import ArcGIS
import CoreLocation
import MapKit
import MBProgressHUD
import GoogleMaps
import GooglePlaces
import GooglePlacePicker

class MapViewController: UIViewController,CLLocationManagerDelegate,UISearchBarDelegate,AGSGeoViewTouchDelegate {
    
    @IBOutlet weak var mapview: AGSMapView!
    @IBOutlet weak var titletext: UILabel!
    @IBOutlet var SearchText: UISearchBar!
    @IBOutlet var imgsearch: UIImageView!
    @IBOutlet var imginfo: UIImageView!
    @IBOutlet var imggpslocation: UIButton!
    
    var hud: MBProgressHUD = MBProgressHUD()
    
    var TitleHead:String!
    
    let CURRENTLAT = UserDefaults.standard.double(forKey: AppConstant.CURRENTLAT)
    let CURRENTLONG = UserDefaults.standard.double(forKey: AppConstant.CURRENTLONG)

    let locationManager = CLLocationManager()
    
    let locationOverlay = AGSGraphicsOverlay()
    let locatorTask = AGSLocatorTask(url: URL(string: "https://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer")!)
    
    private let featureServiceURL = "https://sampleserver6.arcgisonline.com/arcgis/rest/services/PoolPermits/FeatureServer/0"
    
    var ZIpCodeMain = String()
    
    var demos: [(UIViewController & Demoable).Type] = [
        ResizingDemo.self,
    ].sorted(by: { $0.name < $1.name })
    
    var alertController = UIAlertController()

    weak var locationDisplay: AGSLocationDisplay? {
         didSet {
            locationDisplay?.start { [weak self] (error: Error?) in
                 if let error = error {
                     // show the error if one occurred
                 }
             }
         }
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SearchText.setImage(UIImage(), for: .search, state: .normal)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        let image = UIImage(named: "gps")?.withRenderingMode(.alwaysTemplate)
        imggpslocation.setImage(image, for: .normal)
        imggpslocation.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
        
        imgsearch.image = imgsearch.image?.withRenderingMode(.alwaysTemplate)
        imgsearch.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
        
        imginfo.image = imginfo.image?.withRenderingMode(.alwaysTemplate)
        imginfo.tintColor = #colorLiteral(red: 0.3991981149, green: 0.7591522932, blue: 0.3037840128, alpha: 1)
        
        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
        //SearchText.inputView = self.LastdatePicker

        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.backgroundColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
       
         if onoff == "on"{
             toolBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
         }else{
             toolBar.tintColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
         }
        toolBar.sizeToFit()

//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClickLast))
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClickLast))
//        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
//        toolBar.isUserInteractionEnabled = true
//        SearchText.inputAccessoryView = toolBar
        
        alertController = UIAlertController(title: "Notice:", message: "Please note that the disease may not be found in the complete area of your zip code.", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: {
            self.alertController.view.superview?.isUserInteractionEnabled = true
            self.alertController.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        })

        let when = DispatchTime.now() + 15
        DispatchQueue.main.asyncAfter(deadline: when){
          // your code with delay
            self.alertController.dismiss(animated: true, completion: nil)
            
        }
        

        
        if onoff == "on"{
            UIApplication.shared.windows.forEach { window in
                 window.overrideUserInterfaceStyle = .dark
             }
        }else if onoff == "off"{
            UIApplication.shared.windows.forEach { window in
                 window.overrideUserInterfaceStyle = .light
             }
        }else{
            UIApplication.shared.windows.forEach { window in
                 window.overrideUserInterfaceStyle = .light
             }
        }
        
        mapview.locationDisplay.start {

            [weak self] (error:Error?) -> Void in

            if let error = error {

           } else {

           }

        }
    
        
        self.titletext.text = TitleHead
        
        setupMapLoad()
        mapview.graphicsOverlays.add(locationOverlay)

        mapview.touchDelegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
    }

    override func viewDidAppear(_ animated: Bool) {
        print("view did appear")
    }

    // MARK: - Notification oberserver methods

    @objc func didBecomeActive() {
        print("did become active")
    }

    @objc func willEnterForeground() {
        print("will enter foreground")
        
        if Reachability.isConnectedToNetwork(){
            
            if CLLocationManager.locationServicesEnabled() == true {
                if CLLocationManager.locationServicesEnabled() {
                    switch CLLocationManager.authorizationStatus() {
                        case .notDetermined, .restricted, .denied:
                            print("No access")
                            mapview.isHidden = true
                            let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disabled. do you want to enable it?", preferredStyle: UIAlertController.Style.alert)

                            let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                                //Redirect to Settings app
                                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                            })

                            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                            alertController.addAction(cancelAction)

                            alertController.addAction(okAction)

                            self.present(alertController, animated: true, completion: nil)
                        case .authorizedAlways, .authorizedWhenInUse:
                            print("Access")
                            mapview.isHidden = false
                            
                        @unknown default:
                        break
                    }
                    } else {
                        print("Location services are not enabled")
                }
               
            }else {
                
                let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disabled. do you want to enable it?", preferredStyle: UIAlertController.Style.alert)

                let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                    //Redirect to Settings app
                    UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                })

                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                alertController.addAction(cancelAction)

                alertController.addAction(okAction)

                self.present(alertController, animated: true, completion: nil)
                
                
             }
        }else{
            print("Internet Connection not Available!")
            self.view.showToast(toastMessage: "Please turn on your device internet connection to continue.", duration: 0.3)
        }
        
    }
    
    @objc func doneClickLast() {
        
        if CLLocationManager.locationServicesEnabled() == true {
            if CLLocationManager.locationServicesEnabled() {
                switch CLLocationManager.authorizationStatus() {
                    case .notDetermined, .restricted, .denied:
                        print("No access")
                        let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disabled. do you want to enable it?", preferredStyle: UIAlertController.Style.alert)

                        let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                            //Redirect to Settings app
                            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                        })

                        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                        alertController.addAction(cancelAction)

                        alertController.addAction(okAction)

                        self.present(alertController, animated: true, completion: nil)
                    case .authorizedAlways, .authorizedWhenInUse:
                        print("Access")
                        if SearchText.text?.isEmpty == true{
                            DispatchQueue.main.async {
                                self.SearchText.resignFirstResponder()
                            }
                            self.view.showToast(toastMessage: "Enter zip code", duration: 0.3)
                        }else{
                            DispatchQueue.main.async {
                                self.SearchText.resignFirstResponder()
                            }
                            self.searchBarSearchButtonClicked(SearchText)
                        }
                    @unknown default:
                    break
                }
                } else {
                    print("Location services are not enabled")
            }

        }else{
            let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disabled. do you want to enable it?", preferredStyle: UIAlertController.Style.alert)

            let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                //Redirect to Settings app
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            })

            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            alertController.addAction(cancelAction)

            alertController.addAction(okAction)

            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
   @objc func cancelClickLast() {
    SearchText.resignFirstResponder()
    }
    
    @objc func alertControllerBackgroundTapped()
    {
        self.dismiss(animated: true, completion: nil)

    }
      
    
    private func setupMapLoad() {

         let map = AGSMap(
            basemapStyle: .arcGISTopographic
         )
            
        let featureTable = AGSServiceFeatureTable(url: URL(string: featureServiceURL)!)
        //set the request mode
        featureTable.featureRequestMode = AGSFeatureRequestMode.onInteractionCache
        let featureLayer = AGSFeatureLayer(featureTable: featureTable)
        //add the feature layer to the map
        map.operationalLayers.add(featureLayer)
        
    
        locationDisplay?.start { [weak self] (error: Error?) in
            if let error = error {
                // show the error if one occurred
            }else{
                
            }
        }

        mapview.map = map

        mapview.setViewpoint(
             AGSViewpoint(
                 latitude: CURRENTLAT,
                 longitude: CURRENTLONG,
                 scale: 72_000
             )
         )
        
        let locationmain = AGSPoint(clLocationCoordinate2D: CLLocationCoordinate2D(latitude: CURRENTLAT, longitude: CURRENTLONG))
         
        let graphic = AGSGraphic(geometry: locationmain, symbol: AGSSimpleMarkerSymbol(style: .circle, color: .blue, size: 12), attributes: nil)
         self.locationOverlay.graphics.add(graphic)
        
     }
    
    private func setupMap() {
        


         let map = AGSMap(
             basemapStyle: .arcGISTopographic
         )

        mapview.map = map

        mapview.setViewpoint(
             AGSViewpoint(
                 latitude: CURRENTLAT,
                 longitude: CURRENTLONG,
                 scale: 72_000
             )
         )
        
       let locationmain = AGSPoint(clLocationCoordinate2D: CLLocationCoordinate2D(latitude: CURRENTLAT, longitude: CURRENTLONG))
        
        let graphic = AGSGraphic(geometry: locationmain, symbol: AGSSimpleMarkerSymbol(style: .circle, color: .red, size: 12), attributes: nil)
        self.locationOverlay.graphics.add(graphic)

     }
    
    @IBAction func Searchaction(_ sender: UIButton) {
        
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            
            if CLLocationManager.locationServicesEnabled() == true {
                
                if CLLocationManager.locationServicesEnabled() {
                    switch CLLocationManager.authorizationStatus() {
                        case .notDetermined, .restricted, .denied:
                            print("No access")
                            let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disabled. do you want to enable it?", preferredStyle: UIAlertController.Style.alert)

                            let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                                //Redirect to Settings app
                                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                            })

                            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                            alertController.addAction(cancelAction)

                            alertController.addAction(okAction)

                            self.present(alertController, animated: true, completion: nil)
                        case .authorizedAlways, .authorizedWhenInUse:
                            if SearchText.text?.isEmpty == true{
                                DispatchQueue.main.async {
                                    self.SearchText.resignFirstResponder()
                                }
                                self.view.showToast(toastMessage: "Enter zip code", duration: 0.3)
                            }else{
                                DispatchQueue.main.async {
                                    self.SearchText.resignFirstResponder()
                                }
                                self.searchBarSearchButtonClicked(SearchText)
                            }
                        @unknown default:
                        break
                    }
                    } else {
                        print("Location services are not enabled")
                }

                
            }else {
                
                let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disabled. do you want to enable it?", preferredStyle: UIAlertController.Style.alert)

                let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                    //Redirect to Settings app
                    UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                })

                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                alertController.addAction(cancelAction)

                alertController.addAction(okAction)

                self.present(alertController, animated: true, completion: nil)
                
                
             }
            
        }else{
            print("Internet Connection not Available!")
            self.view.showToast(toastMessage: "Please turn on your device internet connection to continue.", duration: 0.3)
        }
    }
    
    @IBAction func iaction(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Notice:", message: "Please note that the disease may not be found in the complete area of your zip code.", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func GPSopen(_ sender: UIButton) {
        
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            
            if CLLocationManager.locationServicesEnabled() == true {
                
                if CLLocationManager.locationServicesEnabled() {
                    switch CLLocationManager.authorizationStatus() {
                        case .notDetermined, .restricted, .denied:
                            print("No access")
                            let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disabled. do you want to enable it?", preferredStyle: UIAlertController.Style.alert)

                            let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                                //Redirect to Settings app
                                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                            })

                            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                            alertController.addAction(cancelAction)

                            alertController.addAction(okAction)

                            self.present(alertController, animated: true, completion: nil)
                        case .authorizedAlways, .authorizedWhenInUse:
                            print("Access")
                            setupMap()
                        @unknown default:
                        break
                    }
                    } else {
                        print("Location services are not enabled")
                }
                
                
            }else {
                
                let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disabled. do you want to enable it?", preferredStyle: UIAlertController.Style.alert)

                let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                    //Redirect to Settings app
                    UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                })

                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                alertController.addAction(cancelAction)

                alertController.addAction(okAction)

                self.present(alertController, animated: true, completion: nil)
                
                
             }
            
        }else{
            print("Internet Connection not Available!")
            self.view.showToast(toastMessage: "Please turn on your device internet connection to continue.", duration: 0.3)
        }
        
    }
    
    func addButton(for demo: (UIViewController & Demoable).Type) {
        
        //self.viewDidLoadcall = "ViewDidLoad"
        //self.viewDidLoadcall = "SearchLoad"
        
//        let defaults = UserDefaults.standard
//        defaults.removeObject(forKey: AppConstant.ZIPCODE)
        UserDefaults.standard.set(ZIpCodeMain, forKey: AppConstant.ZIPCODE)
        UserDefaults.standard.set(TitleHead, forKey: AppConstant.TITLE)
        demo.openDemo(from: self, in: nil,Name: "",title: "")
        
//        if viewDidLoadcall == "ViewDidLoad"{
//            print("ViewDidLoad")
//            let defaults = UserDefaults.standard
//            defaults.removeObject(forKey: AppConstant.ZIPCODE)
//            UserDefaults.standard.set(ZIpCodeMain, forKey: AppConstant.ZIPCODE)
//            UserDefaults.standard.set(TitleHead, forKey: AppConstant.TITLE)
//            demo.openDemo(from: self, in: nil,Name: "",title: "")
//        }else{
//
//        }
      


    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations updates = \(locValue.latitude) \(locValue.longitude)")
        UserDefaults.standard.set(locValue.latitude, forKey: AppConstant.CURRENTLAT)
        UserDefaults.standard.set(locValue.longitude, forKey: AppConstant.CURRENTLONG)
        
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(locValue) { response, error in
            if error != nil {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            } else {
                if let places = response?.results() {
                    if let place = places.first {
                        print(place.lines)
                        print("GEOCODE: Formatted postalCode: \(place.postalCode ?? "")")
                       
                        self.ZIpCodeMain = place.postalCode ?? ""
                        
                    
                    } else {
                        print("GEOCODE: nil first in places")
                    }
                } else {
                    print("GEOCODE: nil in places")
                }
            }
        }
        
    }
    

        

    func geoView(_ geoView: AGSGeoView, didTapAtScreenPoint screenPoint: CGPoint, mapPoint: AGSPoint) {
        
        locationOverlay.graphics.removeAllObjects()

        let mapCenter = mapview.visibleArea?.extent.center
        
        
        

//        self.mapview.callout.title = "Location"
//        self.mapview.callout.detail = String(format: "x: %.2f, y: %.2f", mapPoint.x, mapPoint.y)
//        self.mapview.callout.isAccessoryButtonHidden = true
//        self.mapview.callout.show(at: mapPoint, screenOffset: CGPoint.zero, rotateOffsetWithMap: false, animated: true)
//
//        let x = String(format: "x: %.2f", mapPoint.x)
//        let y = String(format: "y: %.2f", mapPoint.y)
//
//        print("X==>\(x)")
//        print("Y==>\(y)")
        if let latLon = AGSGeometryEngine.projectGeometry(mapCenter!, to: .wgs84()) as? AGSPoint
        {
            let lat = latLon.y
            let lon = latLon.x

            print("latLon.y==>\(lat)")
            print("latLon.x==>\(lon)")

            let map = AGSMap(
                basemapStyle: .arcGISTopographic
            )

           mapview.map = map

           mapview.setViewpoint(
                AGSViewpoint(
                    latitude: lat,
                    longitude: lon,
                    scale: 42_000
                )
            )

            let GetLatlon = CLLocationCoordinate2D(latitude: lat, longitude: lon)

            print("GetLatlon==>\(GetLatlon.latitude)")
            print("GetLatlon==>\(GetLatlon.longitude)")

          let locationmain = AGSPoint(clLocationCoordinate2D: CLLocationCoordinate2D(latitude: lat, longitude: lon))

            let graphic = AGSGraphic(geometry: locationmain, symbol: AGSSimpleMarkerSymbol(style: .circle, color: .purple, size: 12), attributes: nil)
           self.locationOverlay.graphics.add(graphic)


            let geocoder = GMSGeocoder()
            geocoder.reverseGeocodeCoordinate(GetLatlon) { response, error in
                if error != nil {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                } else {

                    if let places = response?.results() {
                        if let place = places.first {
                            print(place.lines)
                            print("GEOCODE: Did Select Formatted postalCode: \(place.postalCode ?? "")")

                            self.ZIpCodeMain = place.postalCode ?? ""

                            for demo in self.demos {
                                self.addButton(for: demo)
                            }

                        } else {
                            print("GEOCODE: nil first in places")
                        }
                    } else {
                        print("GEOCODE: nil in places")
                    }
                }
            }



        }
        
//        mapview.identifyLayers(atScreenPoint: screenPoint, tolerance: 20, returnPopupsOnly: false) { [weak self]  (results, error) in
//
//            guard let self = self else { return }
//
//
//            print("screenPoint.x: \(screenPoint.x)")
//            print("screenPoint.y: \(screenPoint.y)")
//
//            print("mapPoint.x: \(mapPoint.x)")
//            print("mapPoint.y: \(mapPoint.y)")
//
//            if let error = error{
//                print("Error identifyLayers: \(error.localizedDescription)")
//                return
//            }
//
//            if let result = results?.first,
//               let feature = result.geoElements.first as? AGSFeature{
//
//                self.mapview.callout.title = feature.attributes["Name"] as? String
//                self.mapview.callout.detail = feature.attributes["Text_for_Short_Desc_field"] as? String
//                self.mapview.callout.show(for: feature, tapLocation: mapPoint, animated: true)
//            }else{
//                self.mapview.callout.dismiss()
//            }
//
//        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.bezelView.color = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
        hud.customView?.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
        hud.show(animated: true)
        guard let searchText = searchBar.text else { return }
        self.ZIpCodeMain = searchText
        locationOverlay.graphics.removeAllObjects()
        
        locatorTask.geocode(withSearchText: searchText) { [weak self] (results, error) in
            
    
            guard let self = self else { return }
            
            if let error = error{
                print("Error geocoding: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.hud.hide(animated: true)
                }
                return
            }
            
            guard let result = results?.first else { return }
            
            if let extent = result.extent{
                self.mapview.setViewpoint(AGSViewpoint(targetExtent: extent))
            }
            
            if let location  = result.displayLocation{
                let graphic = AGSGraphic(geometry: location, symbol: AGSSimpleMarkerSymbol(style: .circle, color: .red, size: 12), attributes: nil)
                DispatchQueue.main.async {
                    self.hud.hide(animated: true)
                }
                self.locationOverlay.graphics.add(graphic)
                
                for demo in self.demos {
                    self.addButton(for: demo)
                }
                
            }
            
            searchBar.resignFirstResponder()
        }
    }

}

extension AGSPoint {
    var latitude: Double {
        return (AGSGeometryEngine.projectGeometry(self, to: .wgs84()) as? AGSPoint)?.y ?? 0
    }

    var longitude: Double {
        return (AGSGeometryEngine.projectGeometry(self, to: .wgs84()) as? AGSPoint)?.x ?? 0
    }
}
