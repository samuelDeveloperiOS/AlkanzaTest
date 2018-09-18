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

class GoogleMapsViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate{

    var placesClient: GMSPlacesClient!
    let locationManager = CLLocationManager()
    
    var markersArray = Array<GMSMarker>()
    
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
        let camera = GMSCameraPosition.camera(withLatitude: locValue.latitude, longitude: locValue.longitude, zoom: 13.0)
        mapView.moveCamera(GMSCameraUpdate.setCamera(camera))
        getDoctorPlaces(location: camera.target)
    }
    
    func getDoctorPlaces(location:CLLocationCoordinate2D) {

        GetDoctorPlacesService.getDoctorPlaces(location: location) { (error: Error?, response:GooglePlacesResponse?) in
            
            if error == nil {
                
                self.markersArray = Array<GMSMarker>()
                
                DispatchQueue.main.async { [unowned self] in
                    
                    for place in (response?.results)!{
                        
                        let marker = GMSMarker()
                        marker.position = CLLocationCoordinate2D(latitude: place.geometry.location.latitude, longitude: place.geometry.location.longitude)
                        marker.title = place.name
                        marker.snippet = place.address
                        marker.map = self.mapView
                        self.markersArray.append(marker)
                    }
                }
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
