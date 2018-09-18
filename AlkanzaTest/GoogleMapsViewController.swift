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

class GoogleMapsViewController: UIViewController, GMSMapViewDelegate{

    var placesClient: GMSPlacesClient!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        placesClient = GMSPlacesClient.shared()
        mapView.delegate = self
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapView.camera = camera
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        getDoctorPlaces(location: marker.position)
    }
    
    func getDoctorPlaces(location:CLLocationCoordinate2D) {

        GetDoctorPlacesService.getDoctorPlaces(location: location) { (error: Error?, response:GooglePlacesResponse?) in
            
            if error != nil {
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
