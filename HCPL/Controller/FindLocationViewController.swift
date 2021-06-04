//
//  FindLocationViewController.swift
//  HCPL
//
//  Created by Skywave-Mac on 11/02/21.
//  Copyright © 2021 Skywave-Mac. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import GoogleMaps
import GooglePlaces
import GooglePlacePicker

class FindLocationViewController: UIViewController,UISearchBarDelegate, MKLocalSearchCompleterDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResultsTable: UITableView!
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.becomeFirstResponder()
        
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
        
       searchCompleter.delegate = self
       searchBar?.delegate = self
       searchResultsTable?.delegate = self
       searchResultsTable?.dataSource = self
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
           
            
            NotificationCenter.default.post(name: Notification.Name("remove_View"), object: nil)

        }

       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           searchCompleter.queryFragment = searchText
       }

       func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
           
           searchResults = completer.results
           searchResultsTable.reloadData()
       }
       
       func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
           
       }
    
    @IBAction func back(_ sender: UIButton) {
        //self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
   
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ administrativeArea: String?, _ name:  String?, _ postalCode: String?, _ region:  CLRegion?, _ subAdministrativeArea: String?, _ subLocality:  String?, _ error: Error?) -> ()) {
         CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
             completion(placemarks?.first?.locality,
                        placemarks?.first?.country,
                        placemarks?.first?.administrativeArea,
                        placemarks?.first?.name,
                        placemarks?.first?.postalCode,
                        placemarks?.first?.region,
                        placemarks?.first?.subAdministrativeArea,
                        placemarks?.first?.subLocality,
                        error)
         }
     }
       
    
       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
             print("Error while updating location " + error.localizedDescription)
       }

}

extension FindLocationViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let searchResult = searchResults[indexPath.row]
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        return cell
    }
}

extension FindLocationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let result = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: result)
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let coordinate = response?.mapItems[0].placemark.coordinate else {
                return
            }
            
            guard let name = response?.mapItems[0].name else {
                return
            }
            
            guard let state = response?.mapItems[0].placemark.administrativeArea else {
                return
            }
            
            guard let country = response?.mapItems[0].placemark.country else {
                return
            }
            
        
  
            let lat = coordinate.latitude
            let lon = coordinate.longitude
            let locValue = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
            let geocoder = GMSGeocoder()
            geocoder.reverseGeocodeCoordinate(locValue) { response, error in
                if error != nil {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                    self.view.showToast(toastMessage: "Please turn on your device internet connection to continue.", duration: 0.3)
                } else {
                    if let places = response?.results() {
                        if let place = places.first {
                            print(place.lines)
                            print("GEOCODE: Formatted postalCode: \(place.postalCode ?? "")")
                            print("GEOCODE: Formatted locality: \(place.locality ?? "")")
                            print("GEOCODE: Formatted subLocality: \(place.subLocality ?? "")")
                            print("GEOCODE: Formatted administrativeArea: \(place.administrativeArea ?? "")")
                            print("GEOCODE: Formatted country: \(place.country ?? "")")
                            
    //
                           
                        } else {
                            print("GEOCODE: nil first in places")
                        }
                    } else {
                        print("GEOCODE: nil in places")
                    }
                }
            }
            
            let FullAddress = "\(name),\(state),\(country)"
            
            
            UserDefaults.standard.set(lat, forKey: AppConstant.CURRENTLAT)
            UserDefaults.standard.set(lon, forKey: AppConstant.CURRENTLONG)
            UserDefaults.standard.set(FullAddress, forKey: AppConstant.CURRENTADDRESS)
            
            
            print("name==>\(name)")
            print("lat==>\(lat)")
            print("lon==>\(lon)")
            
            print("state==>\(state)")
            print("country==>\(country)")
            
            
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
}

extension CLLocation {
//               placemarks?.first?.locality,
//               placemarks?.first?.country,
//               placemarks?.first?.administrativeArea,
//               placemarks?.first?.name,
//               placemarks?.first?.postalCode,
//               placemarks?.first?.region,
//               placemarks?.first?.subAdministrativeArea,
//               placemarks?.first?.subLocality,
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ administrativeArea: String?, _ name:  String?, _ postalCode: String?, _ region:  CLRegion?, _ subAdministrativeArea: String?, _ subLocality:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $0?.first?.administrativeArea, $0?.first?.name, $0?.first?.postalCode, $0?.first?.region, $0?.first?.subAdministrativeArea, $0?.first?.subLocality, $1) }
    }
}
//CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $1?.first?.country, $2?.first?.administrativeArea, $3?.first?.name, $4?.first?.postalCode, $5?.first?.region, $6?.first?.subAdministrativeArea, $7?.first?.subLocality) }
