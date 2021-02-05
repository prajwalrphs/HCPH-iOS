//
//  SearchEstablishmentsViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 03/02/21.
//  Copyright © 2021 Skywave-Mac. All rights reserved.
//

import UIKit
import ArcGIS
import CoreLocation

class SearchEstablishmentsViewController: UIViewController,CLLocationManagerDelegate,UISearchBarDelegate,AGSGeoViewTouchDelegate {
    
    @IBOutlet weak var mapview: AGSMapView!
    @IBOutlet weak var titletext: UILabel!
    
    var TitleHead:String!
    
    let locationOverlay = AGSGraphicsOverlay()
    let locatorTask = AGSLocatorTask(url: URL(string: "https://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer")!)
    
    let locationManager = CLLocationManager()
    
    fileprivate func MakeMap() -> AGSMap {
        let map =  AGSMap(basemapType: .navigationVector, latitude: 22.825187, longitude: 70.849081, levelOfDetail: 15)
        
        let featureTable = AGSServiceFeatureTable(url: URL(string: "https://services.arcgis.com/OfH668nDRN7tbjh0/arcgis/rest/services/Palm_Springs_Shortlist/FeatureServer/0")!)
        
        let featureLayer = AGSFeatureLayer(featureTable: featureTable)
        map.operationalLayers.add(featureLayer)
        
        return map
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //mapview.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        mapview.locationDisplay.start {

            [weak self] (error:Error?) -> Void in

            if let error = error {

               // show error
                print("show error")

           } else {

              // get the map location
            
            print("get the map location")

            //let currentLocation : AGSPoint = mapView.mapLocation;

           }

        }
        
        self.titletext.text = TitleHead
        
        mapview.map = MakeMap()
        
//        mapview.graphicsOverlays.add(locationOverlay)
//
//        mapview.touchDelegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }
    
    @IBAction func Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations updates = \(locValue.latitude) \(locValue.longitude)")
        
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
