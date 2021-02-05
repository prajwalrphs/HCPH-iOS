//
//  MapViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 26/11/20.
//  Copyright © 2020 Skywave-Mac. All rights reserved.
//

import UIKit
import ArcGIS
import CoreLocation

class MapViewController: UIViewController,CLLocationManagerDelegate,UISearchBarDelegate,AGSGeoViewTouchDelegate {
    
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
    
    private func setupMap() {
         let map = AGSMap(
             basemapStyle: .arcGISTopographic
         )
        mapview.map = map
        mapview.setViewpoint(
             AGSViewpoint(
                 latitude: 22.825187,
                 longitude: 70.849081,
                 scale: 72_000
             )
         )
     }

     private func addGraphics() {

         let graphicsOverlay = AGSGraphicsOverlay()
        mapview.graphicsOverlays.add(graphicsOverlay)
        
        let point = AGSPoint(x: -118.80657463861, y: 34.0005930608889, spatialReference: .wgs84())
        let pointSymbol = AGSSimpleMarkerSymbol(style: .circle, color: .orange, size: 10.0)

        pointSymbol.outline = AGSSimpleLineSymbol(style: .solid, color: .blue, width: 2.0)
        
        let pointGraphic = AGSGraphic(geometry: point, symbol: pointSymbol)

        graphicsOverlay.graphics.add(pointGraphic)
        
        let polyline = AGSPolyline(
                    points: [
                        AGSPoint(x: -118.821527826096, y: 34.0139576938577, spatialReference: .wgs84()),
                        AGSPoint(x: -118.814893761649, y: 34.0080602407843, spatialReference: .wgs84()),
                        AGSPoint(x: -118.808878330345, y: 34.0016642996246, spatialReference: .wgs84())
                    ]
                )

        let polylineSymbol = AGSSimpleLineSymbol(style: .solid, color: .blue, width: 3.0)
        
        let polylineGraphic = AGSGraphic(geometry: polyline, symbol: polylineSymbol)

        graphicsOverlay.graphics.add(polylineGraphic)
        
        let polygon = AGSPolygon(
            points: [
                AGSPoint(x: -118.818984489994, y: 34.0137559967283, spatialReference: .wgs84()),
                AGSPoint(x: -118.806796597377, y: 34.0215816298725, spatialReference: .wgs84()),
                AGSPoint(x: -118.791432890735, y: 34.0163883241613, spatialReference: .wgs84()),
                AGSPoint(x: -118.79596686535, y: 34.008564864635, spatialReference: .wgs84()),
                AGSPoint(x: -118.808558110679, y: 34.0035027131376, spatialReference: .wgs84())
            ]
        )

        let polygonSymbol = AGSSimpleFillSymbol(style: .solid, color: .orange, outline: AGSSimpleLineSymbol(style: .solid, color: .blue, width: 2.0))
        
        let polygonGraphic = AGSGraphic(geometry: polygon, symbol: polygonSymbol)

          graphicsOverlay.graphics.add(polygonGraphic)

     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        setupMap()

        addGraphics()
        
        mapview.map = MakeMap()
        
        mapview.graphicsOverlays.add(locationOverlay)

        mapview.touchDelegate = self
        
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
