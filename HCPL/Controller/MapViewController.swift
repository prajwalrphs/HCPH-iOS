
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
    
    var hud: MBProgressHUD = MBProgressHUD()
    
    var TitleHead:String!
    
    let CURRENTLAT = UserDefaults.standard.double(forKey: AppConstant.CURRENTLAT)
    let CURRENTLONG = UserDefaults.standard.double(forKey: AppConstant.CURRENTLONG)

    let locationManager = CLLocationManager()
    
    let locationOverlay = AGSGraphicsOverlay()
    let locatorTask = AGSLocatorTask(url: URL(string: "https://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer")!)
    
    var ZIpCodeMain = String()
    var viewDidLoadcall = String()
    
    var demos: [(UIViewController & Demoable).Type] = [
        ResizingDemo.self,
    ].sorted(by: { $0.name < $1.name })
    
    var alertController = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            
            for demo in self.demos {
                self.viewDidLoadcall = "ViewDidLoad"
                self.addButton(for: demo)
            }
        }
        
        let onoff = UserDefaults.standard.string(forKey: AppConstant.ISONISOFF)
        print("onoff==>\(onoff ?? "")")
        
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
    
    @objc func alertControllerBackgroundTapped()
    {
        self.dismiss(animated: true, completion: nil)
        for demo in self.demos {
            self.viewDidLoadcall = "ViewDidLoad"
            self.addButton(for: demo)
        }
    }
    
    private func setupMapLoad() {

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
        if SearchText.text?.isEmpty == true{
            self.view.showToast(toastMessage: "Enter zip code", duration: 0.3)
        }else{
            self.searchBarSearchButtonClicked(SearchText)
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
        
        setupMap()
    }
    
    func addButton(for demo: (UIViewController & Demoable).Type) {
        
        //self.viewDidLoadcall = "ViewDidLoad"
        //self.viewDidLoadcall = "SearchLoad"
        
        if viewDidLoadcall == "ViewDidLoad"{
            print("ViewDidLoad")
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: AppConstant.ZIPCODE)
            UserDefaults.standard.set(ZIpCodeMain, forKey: AppConstant.ZIPCODE)
            UserDefaults.standard.set(TitleHead, forKey: AppConstant.TITLE)
            demo.openDemo(from: self, in: nil,Name: "",title: "")
        }else{
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: AppConstant.ZIPCODE)
            UserDefaults.standard.set(SearchText.text, forKey: AppConstant.ZIPCODE)
            UserDefaults.standard.set(TitleHead, forKey: AppConstant.TITLE)
            demo.openDemo(from: self, in: nil,Name: "",title: "")
        }
      


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
        
        mapview.identifyLayers(atScreenPoint: screenPoint, tolerance: 20, returnPopupsOnly: false) { [weak self]  (results, error) in
      
            guard let self = self else { return }
            
      
            print("screenPoint.x: \(screenPoint.x)")
            print("screenPoint.y: \(screenPoint.y)")
            
            print("mapPoint.x: \(mapPoint.x)")
            print("mapPoint.y: \(mapPoint.y)")
           
            if let error = error{
                print("Error identifyLayers: \(error.localizedDescription)")
                return
            }
            
            if let result = results?.first,
               let feature = result.geoElements.first as? AGSFeature{
                
                self.mapview.callout.title = feature.attributes["Name"] as? String
                self.mapview.callout.detail = feature.attributes["Text_for_Short_Desc_field"] as? String
                self.mapview.callout.show(for: feature, tapLocation: mapPoint, animated: true)
            }else{
                self.mapview.callout.dismiss()
            }
      
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.bezelView.color = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
        hud.customView?.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
        hud.show(animated: true)
        guard let searchText = searchBar.text else { return }
        
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
                    self.viewDidLoadcall = "SearchLoad"
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
