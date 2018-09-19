//
//  GoogleMapsViewController.swift
//  AlkanzaTest
//
//  Created by Samuel on 17/9/18.
//  Copyright © 2018 Samuel. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class GoogleMapsViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate, SettingsDelegate{

    var placesClient: GMSPlacesClient!
    let locationManager = CLLocationManager()
    
    var markersArray = Array<GMSMarker>()
    
    var radio:Int = 5000
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        placesClient = GMSPlacesClient.shared()
        mapView.delegate = self
        
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.startUpdatingLocation()
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapView.camera = camera
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let camera = GMSCameraPosition.camera(withLatitude: locValue.latitude, longitude: locValue.longitude, zoom: 12.0)
        mapView.moveCamera(GMSCameraUpdate.setCamera(camera))
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        let coordinate = mapView.projection.coordinate(for: mapView.center)
        getDoctorPlaces(location: coordinate, radio: self.radio)
    }
    
    func getDoctorPlaces(location: CLLocationCoordinate2D, radio: Int) {

        GetDoctorPlacesService.getDoctorPlaces(location: location, radio: radio) { (error: Error?, response:GooglePlacesResponse?) in
            
            if error == nil {
                
                self.markersArray = Array<GMSMarker>()
                
                DispatchQueue.main.async { [unowned self] in
                    
                    self.mapView.clear();
                    
                    for place in (response?.results)!{
                        
                        let marker = GMSMarker()
                        marker.position = CLLocationCoordinate2D(latitude: place.geometry.location.latitude, longitude: place.geometry.location.longitude)
                        marker.title = place.name
                        marker.snippet = place.address
                        marker.map = self.mapView
                        self.markersArray.append(marker)
                    }
                    
                    self.mapView.reloadInputViews()
                }
                
            }
        }
    }
    
    func settingsSaved(location: CLLocationCoordinate2D, radio: Int) -> Void{
        
        if radio != 0 {
            self.radio = radio
        }
        
        if location.latitude != 0 && location.longitude != 0 {
            let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 12.0)
            mapView.moveCamera(GMSCameraUpdate.setCamera(camera))
        }
    }
    
    @IBAction func userSettings(_ sender: UIButton) {
        
        let coordinate = mapView.projection.coordinate(for: mapView.center)
        
        let settingsViewController = SettingsViewController(nibName: "SettingsViewController", bundle: Bundle.main)
        settingsViewController.modalPresentationStyle = .overFullScreen
        settingsViewController.modalTransitionStyle = .crossDissolve
        settingsViewController.location = coordinate
        settingsViewController.radio = self.radio
        settingsViewController.delegate = self
        self.present(settingsViewController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
