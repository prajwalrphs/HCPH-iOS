
import UIKit
import ArcGIS
import CoreLocation
import MapKit
import MBProgressHUD
import GoogleMaps
import GooglePlaces
import GooglePlacePicker

private struct AttributeKeys {
    static let placeAddress = "Texas"
    static let placeName = "Houston"
}

class MapViewController: UIViewController,CLLocationManagerDelegate,UISearchBarDelegate,AGSGeoViewTouchDelegate {
    
    @IBOutlet weak var mapview: AGSMapView!
    @IBOutlet weak var titletext: UILabel!
    @IBOutlet var SearchText: UISearchBar!
    @IBOutlet var imgsearch: UIImageView!
    @IBOutlet var imginfo: UIImageView!
    @IBOutlet var imggpslocation: UIButton!
    @IBOutlet var Searchbuttonview: UIView!
    
    var hud: MBProgressHUD = MBProgressHUD()
    
    var TitleHead:String!
    
    let CURRENTLAT = UserDefaults.standard.double(forKey: AppConstant.CURRENTLAT)
    let CURRENTLONG = UserDefaults.standard.double(forKey: AppConstant.CURRENTLONG)

    let locationManager = CLLocationManager()
    
    let locationOverlay = AGSGraphicsOverlay()
    var locatorTask = AGSLocatorTask(url: URL(string: "https://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer")!)
    
    //private let featureServiceURL = "https://sampleserver6.arcgisonline.com/arcgis/rest/services/PoolPermits/FeatureServer/0"
    
    let featureTable0 = AGSServiceFeatureTable(url: URL(string: "https://www.gis.hctx.net/arcgis/rest/services/HCPHES/Mobile_Mosquito_Disease_Last7days/MapServer/0")!)

    let featureTable7 = AGSServiceFeatureTable(url: URL(string: "https://www.gis.hctx.net/arcgis/rest/services/HCPHES/MVCD_ConfirmedMosquitoActivity_OpAreas_Public_MapService/MapServer/7")!)
    
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
    
    var sprayItems: Array<String>!
    var diseaseItems: Array<Array<String>>!
    var mapDetailItems: Array<NSMutableDictionary>!
    
    
    
    private var map:AGSMap?
    private var hcMap:AGSMap?
    private var mapImageLayer:AGSArcGISMapImageLayer!
    private var popover:UIPopoverPresentationController!
    
    //Locator task for searching zipcode
    private var geocodeParameters: AGSGeocodeParameters!
    //private let locatorURL = "https://www.gis.hctx.net/arcgis/rest/services/Locator/Harris_County_Address_Points/GeocodeServer"
    //private let locatorURL = "https://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer"
    
    private var mapFeatureLayer:AGSFeatureLayer!
    private var featureLayer0:AGSFeatureLayer?
    private var featureLayer1:AGSFeatureLayer?
    private var featureLayer2:AGSFeatureLayer?
    private var featureLayer3:AGSFeatureLayer?
    private var featureLayer4:AGSFeatureLayer?
    private var featureLayer5:AGSFeatureLayer?
    private var featureLayer6:AGSFeatureLayer?
    private var featureLayer7:AGSFeatureLayer?
    private var featureLayer8:AGSFeatureLayer?
    private var featureLayer9:AGSFeatureLayer?
    
    private var graphicsOverlay: AGSGraphicsOverlay!
    
    private var screenPoint:CGPoint!
    private var legendHidden = true
    
    private var disclaimerVisible = false
    private var reportPopupClicked = false
    private weak var activeSelectionQuery:AGSCancelable?
    
    
    let bottom = CGAffineTransform(translationX: 0, y: 0)
    let bottom2 = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height * 1.15)
    var top = CGAffineTransform(translationX: 0, y: -117 )
    var topTop = CGAffineTransform(translationX: 0, y: -200)
    
    private var animator: UIDynamicAnimator!
    
    private var snapSpotBottom: CGPoint!
    private var snapSpotHidden: CGPoint!
    private var popupLocation = "hidden" //hidden, top, middle
    
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
            
            SearchText.setTextField(color: AppConstant.ViewColor)
            
            Searchbuttonview.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
             toolBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
         }else{
             toolBar.tintColor = #colorLiteral(red: 0.4118635654, green: 0.7550011873, blue: 0.330655843, alpha: 1)
         }
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(doneClickLast))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClickLast))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        SearchText.inputAccessoryView = toolBar
        
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

        
        
        do {
            let result = try AGSArcGISRuntimeEnvironment.setLicenseKey("runtimelite,1000,rud2361000057,none,TRB3LNBHPDH4F5KHT180")
            print("License Result : \(result.licenseStatus)")
        }
        catch let error as NSError {
            print("error: \(error)")
        }
        

        self.graphicsOverlay = AGSGraphicsOverlay()
        self.mapview.graphicsOverlays.add(self.graphicsOverlay)
        

        //self.locatorTask = self.locatorTask
        
        self.geocodeParameters = AGSGeocodeParameters()
        self.geocodeParameters.resultAttributeNames.append(contentsOf: ["*"])
        self.geocodeParameters.minScore = 75
        
        
        let map3 = AGSMap(basemap: .topographic())
        
        //let hcBoundaryLayer = AGSFeatureLayer(featureTable: hcBoundaryMask)
        
        let featureTable0 = AGSServiceFeatureTable(url: URL(string: "https://www.gis.hctx.net/arcgis/rest/services/HCPHES/Mobile_Mosquito_Disease_Last7days/MapServer/0")!)

        let featureTable7 = AGSServiceFeatureTable(url: URL(string: "https://www.gis.hctx.net/arcgis/rest/services/HCPHES/MVCD_ConfirmedMosquitoActivity_OpAreas_Public_MapService/MapServer/7")!)
        
      
        self.featureLayer0 = AGSFeatureLayer(featureTable: featureTable0)
        self.featureLayer7 = AGSFeatureLayer(featureTable: featureTable7)

        map3.operationalLayers.add(featureLayer0!)
        map3.operationalLayers.add(featureLayer7!)

        self.mapview.map = map3
       
        self.mapview.locationDisplay.autoPanMode = AGSLocationDisplayAutoPanMode.off
        self.mapview.locationDisplay.start { (error:Error?) -> Void in
            if let error = error {
                //self.presentAlert(error: error)
                
                //update context sheet to Stop
                //self.sheet.selectedIndex = 0
            }
        }
        var locationManager = CLLocationManager()
        
        var myLocationPoint = AGSPoint(clLocationCoordinate2D: (locationManager.location?.coordinate)!)
        self.mapview.setViewpointCenter(myLocationPoint, scale: 6000, completion: nil)
        
        self.mapview.selectionProperties.color = .cyan
        //self.searchTextField.isHidden = true
        self.mapview.layerViewStateChangedHandler = { (layer:AGSLayer, state:AGSLayerViewState) in
            switch state.status {
            case AGSLayerViewStatus.active:
                if(layer.name == "Zip Codes")
                {
                    //self.searchTextField.isHidden = false
                }
                print("Active - ", layer.name)
            case AGSLayerViewStatus.notVisible:print("Not Visible - ", layer.name)
            case AGSLayerViewStatus.outOfScale:print("Out of Scale - ", layer.name)
            case AGSLayerViewStatus.loading:print("Loading - ", layer.name)
            case AGSLayerViewStatus.error:print("Error - ", layer.name)
            default:print("Unknown - ", layer.name)
            }
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let totalCharacters = (searchBar.text?.appending(text).count ?? 0) - range.length
        return totalCharacters <= 5
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
        if Reachability.isConnectedToNetwork(){
            
            if CLLocationManager.locationServicesEnabled() == true {
                if CLLocationManager.locationServicesEnabled() {
                    switch CLLocationManager.authorizationStatus() {
                    case .notDetermined:
                        self.locationManager.requestWhenInUseAuthorization()
                    case .restricted, .denied:
                            print("No access")
                            mapview.isHidden = true
                            let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disabled. do you want to enable it?", preferredStyle: UIAlertController.Style.alert)

                            let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                                //Redirect to Settings app
                                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                            })

                        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(cAlertAction) in
                            //Redirect to Settings app
                            let navigate:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                            navigate.selectdtab = 2
                            self.navigationController?.pushViewController(navigate, animated: true)
                        })
                        
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

    @objc func willEnterForeground() {
        print("will enter foreground")
        
        if Reachability.isConnectedToNetwork(){
            
            if CLLocationManager.locationServicesEnabled() == true {
                if CLLocationManager.locationServicesEnabled() {
                    switch CLLocationManager.authorizationStatus() {
                    case .notDetermined:
                        self.locationManager.requestWhenInUseAuthorization()
                    case .restricted, .denied:
                            print("No access")
                            mapview.isHidden = true
                            let alertController = UIAlertController(title: "Location Permission Required", message: "Location is disabled. do you want to enable it?", preferredStyle: UIAlertController.Style.alert)

                            let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                                //Redirect to Settings app
                                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                            })

                        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(cAlertAction) in
                            //Redirect to Settings app
                            let navigate:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                            navigate.selectdtab = 2
                            self.navigationController?.pushViewController(navigate, animated: true)
                        })
                        
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
            
        //let featureTable = AGSServiceFeatureTable(url: URL(string: featureServiceURL)!)
        //set the request mode
        featureTable0.featureRequestMode = AGSFeatureRequestMode.onInteractionCache
        let featureLayer = AGSFeatureLayer(featureTable: featureTable0)
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

            
            do {
                let result = try AGSArcGISRuntimeEnvironment.setLicenseKey("runtimelite,1000,rud2361000057,none,TRB3LNBHPDH4F5KHT180")
                print("License Result : \(result.licenseStatus)")
            }
            catch let error as NSError {
                print("error: \(error)")
            }
            

            self.graphicsOverlay = AGSGraphicsOverlay()
            self.mapview.graphicsOverlays.add(graphicsOverlay)
            

            //self.locatorTask = AGSLocatorTask(url: URL(string: self.locatorURL)!)
            
            self.geocodeParameters = AGSGeocodeParameters()
            self.geocodeParameters.resultAttributeNames.append(contentsOf: ["*"])
            self.geocodeParameters.minScore = 75
            
            
            let map3 = AGSMap(basemap: .topographic())
            
            //let hcBoundaryLayer = AGSFeatureLayer(featureTable: hcBoundaryMask)
            
           
            
          
            self.featureLayer0 = AGSFeatureLayer(featureTable: featureTable0)
            self.featureLayer7 = AGSFeatureLayer(featureTable: featureTable7)

            map3.operationalLayers.add(featureLayer0!)
            map3.operationalLayers.add(featureLayer7!)

            self.mapview.map = map3
           
            self.mapview.locationDisplay.autoPanMode = AGSLocationDisplayAutoPanMode.off
            self.mapview.locationDisplay.start { (error:Error?) -> Void in
                if error != nil {
                    //self.presentAlert(error: error)
                    
                    //update context sheet to Stop
                    //self.sheet.selectedIndex = 0
                }
            }
            let locationManager = CLLocationManager()
            
            let myLocationPoint = AGSPoint(clLocationCoordinate2D: (locationManager.location?.coordinate)!)
            self.mapview.setViewpointCenter(myLocationPoint, scale: 6000, completion: nil)
            
            self.mapview.selectionProperties.color = .cyan
            //self.searchTextField.isHidden = true
            self.mapview.layerViewStateChangedHandler = { (layer:AGSLayer, state:AGSLayerViewState) in
                switch state.status {
                case AGSLayerViewStatus.active:
                    if(layer.name == "Zip Codes")
                    {
                        //self.searchTextField.isHidden = false
                    }
                    print("Active - ", layer.name)
                case AGSLayerViewStatus.notVisible:print("Not Visible - ", layer.name)
                case AGSLayerViewStatus.outOfScale:print("Out of Scale - ", layer.name)
                case AGSLayerViewStatus.loading:print("Loading - ", layer.name)
                case AGSLayerViewStatus.error:print("Error - ", layer.name)
                default:print("Unknown - ", layer.name)
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
        
    func searchTextdemo(text: String!)
    {
        if(text.count == 0 || text.count == nil)
        {
            
        }
        else if(text.count < 5 && text.count > 0)
        {
           // self.presentAlert(message: NSLocalizedString("Invalid Zip Code", comment:"Invalid Zip Code"))
        }
        else
        {
            self.locatorTask.geocode(withSearchText: text, parameters: self.geocodeParameters, completion: { [weak self] (results: [AGSGeocodeResult]?, error: Error?) in
                guard let self = self else {
                    return
                }
                
                if let error = error {
                    //self.presentAlert(error: error)
                    self.view.showToast(toastMessage: "No results found", duration: 0.3)
                } else if let result = results?.first {
                    
                    //create a graphic for the first result and add to the graphics overlay
                    let graphic = graphicForPoint(result.displayLocation!, attributes: result.attributes as [String: AnyObject]?)
                    self.graphicsOverlay.graphics.removeAllObjects()
                    self.graphicsOverlay.graphics.add(graphic)
                    //zoom to the extent of the result
                    if let extent = result.extent {
                        self.mapview.setViewpointGeometry(extent, completion: nil)
                    }
                    //self.showPopup(mapPoint: result.displayLocation!)
                } else {
                    //provide feedback in case of failure
                   // self.presentAlert(message: NSLocalizedString("No results found", comment:"No results found"))
                    self.view.showToast(toastMessage: "No results found", duration: 0.3)
                }
            })
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.bezelView.color = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
        hud.customView?.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.6941176471, blue: 0.6196078431, alpha: 1)
        hud.show(animated: true)
        guard let searchText = searchBar.text else { return }
        self.ZIpCodeMain = searchText
        locationOverlay.graphics.removeAllObjects()
        
        //searchTextdemo(text: searchText)
        
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
            
            print(
                        """
                        Found \(result.label)
                        at \(result.displayLocation.debugDescription)
                        with score \(result.score)
                        """
                    )
            
            if result.label.contains("Texas") || result.label.contains("Alabama") || result.label.contains("Alaska") || result.label.contains("Arizona") || result.label.contains("Arkansas") || result.label.contains("California") || result.label.contains("Colorado") || result.label.contains("Connecticut") || result.label.contains("Delaware") || result.label.contains("District Of Columbia") || result.label.contains("Florida") || result.label.contains("Georgia") || result.label.contains("Hawaii") || result.label.contains("Idaho") || result.label.contains("Illinois") || result.label.contains("Indiana") || result.label.contains("Iowa") || result.label.contains("Kansas") || result.label.contains("Kentucky") || result.label.contains("Louisiana") || result.label.contains("Maine") || result.label.contains("Marshall Islands") || result.label.contains("Maryland") || result.label.contains("Massachusetts") || result.label.contains("Michigan") || result.label.contains("Minnesota") || result.label.contains("Mississippi") || result.label.contains("Missouri") || result.label.contains("Montana") || result.label.contains("Nebraska") || result.label.contains("Nevada") || result.label.contains("New Hampshire") || result.label.contains("New Jersey") || result.label.contains("New Mexico") || result.label.contains("New York") || result.label.contains("North Carolina") || result.label.contains("North Dakota") || result.label.contains("Ohio") || result.label.contains("Oklahoma") || result.label.contains("Oregon") || result.label.contains("Pennsylvania") || result.label.contains("Rhode Island") || result.label.contains("South Carolina") || result.label.contains("South Dakota") || result.label.contains("Tennessee") || result.label.contains("Utah") || result.label.contains("Vermont") || result.label.contains("Virginia") || result.label.contains("Washington") || result.label.contains("West Virginia") || result.label.contains("Wisconsin") || result.label.contains("Wyoming"){
                print("exists")
                
                if let extent = result.extent{
                    self.mapview.setViewpoint(AGSViewpoint(targetExtent: extent))
                }

                if let location  = result.displayLocation{

                    let graphic = graphicForPoint(location, attributes: result.attributes as [String: AnyObject]?)

    //                let graphic = AGSGraphic(geometry: location, symbol: AGSSimpleMarkerSymbol(style: .circle, color: .red, size: 12), attributes: nil)
                    DispatchQueue.main.async {
                        self.hud.hide(animated: true)
                    }
                    self.locationOverlay.graphics.add(graphic)

                    for demo in self.demos {
                        self.addButton(for: demo)
                    }

                }

                searchBar.resignFirstResponder()
                
            }else{
                DispatchQueue.main.async {
                    self.hud.hide(animated: true)
                }
                self.view.showToast(toastMessage: "No results found", duration: 0.3)
                
            }
        }
    }
    
    

}

private func graphicForPoint(_ point: AGSPoint, attributes: [String: AnyObject]?) -> AGSGraphic {
    let markerImage = UIImage(named: "mappin")!
    let symbol = AGSPictureMarkerSymbol(image: markerImage)
    
    let graphic = AGSGraphic(geometry: point, symbol: symbol, attributes: attributes)
    return graphic
}

extension AGSPoint {
    var latitude: Double {
        return (AGSGeometryEngine.projectGeometry(self, to: .wgs84()) as? AGSPoint)?.y ?? 0
    }

    var longitude: Double {
        return (AGSGeometryEngine.projectGeometry(self, to: .wgs84()) as? AGSPoint)?.x ?? 0
    }
}

extension UISearchBar {
    func getTextField() -> UITextField? { return value(forKey: "searchField") as? UITextField }
    func setTextField(color: UIColor) {
        guard let textField = getTextField() else { return }
        switch searchBarStyle {
        case .minimal:
            textField.layer.backgroundColor = color.cgColor
            textField.layer.cornerRadius = 6
        case .prominent, .default: textField.backgroundColor = color
        @unknown default: break
        }
    }
}
