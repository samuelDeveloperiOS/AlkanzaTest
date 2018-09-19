//
//  GetDoctorPlacesService.swift
//  AlkanzaTest
//
//  Created by Samuel on 17/9/18.
//  Copyright © 2018 Samuel. All rights reserved.
//

import UIKit
import CoreLocation

class GetDoctorPlacesService: NSObject {

    static func getDoctorPlaces(location:CLLocationCoordinate2D, radio:Int, completion:@escaping (_ error: Error?, _ response: GooglePlacesResponse?) -> Void) {
        
        let urlString = String.init(format: Constants.URL_GOOGLE_PLACES_SEARCH, location.latitude, location.longitude, radio, Constants.GOOGLE_PLACES_KEY)
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (responseData, _, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil, GooglePlacesResponse(results:[]))
                return
            }
            
            do{
                //here dataResponse received from a network request
                let response = try JSONDecoder().decode(GooglePlacesResponse.self, from: responseData!)
                completion(nil, response)
    
            } catch let parsingError {
                print("Error", parsingError)
                completion(parsingError, nil)
            }
            
        }
        task.resume()
    }
}
