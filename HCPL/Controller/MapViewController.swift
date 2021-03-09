
import UIKit
import ArcGIS
import CoreLocation
import MapKit

class MapViewController: UIViewController,CLLocationManagerDelegate,UISearchBarDelegate,AGSGeoViewTouchDelegate {
    
    @IBOutlet weak var mapview: AGSMapView!
    @IBOutlet weak var titletext: UILabel!
    
    var TitleHead:String!
    
    let CURRENTLAT = UserDefaults.standard.double(forKey: AppConstant.CURRENTLAT)
    let CURRENTLONG = UserDefaults.standard.double(forKey: AppConstant.CURRENTLONG)

    let locationManager = CLLocationManager()
    
    let locationOverlay = AGSGraphicsOverlay()
    let locatorTask = AGSLocatorTask(url: URL(string: "https://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer")!)
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
    
    @IBAction func Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func GPSopen(_ sender: UIButton) {
        setupMap()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations updates = \(locValue.latitude) \(locValue.longitude)")
        UserDefaults.standard.set(locValue.latitude, forKey: AppConstant.CURRENTLAT)
        UserDefaults.standard.set(locValue.longitude, forKey: AppConstant.CURRENTLONG)
        
    }
    
    func geoView(_ geoView: AGSGeoView, didTapAtScreenPoint screenPoint: CGPoint, mapPoint: AGSPoint) {
        mapview.identifyLayers(atScreenPoint: screenPoint, tolerance: 20, returnPopupsOnly: false) { [weak self]  (results, error) in
            
            guard let self = self else { return }
            
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
        guard let searchText = searchBar.text else { return }
        
        locationOverlay.graphics.removeAllObjects()
        
        locatorTask.geocode(withSearchText: searchText) { [weak self] (results, error) in
            
            guard let self = self else { return }
            
            if let error = error{
                print("Error geocoding: \(error.localizedDescription)")
                return
            }
            
            guard let result = results?.first else { return }
            
            if let extent = result.extent{
                self.mapview.setViewpoint(AGSViewpoint(targetExtent: extent))
            }
            
            if let location  = result.displayLocation{
                let graphic = AGSGraphic(geometry: location, symbol: AGSSimpleMarkerSymbol(style: .circle, color: .red, size: 12), attributes: nil)
                self.locationOverlay.graphics.add(graphic)
            }
            
            searchBar.resignFirstResponder()
        }
    }
    
}
