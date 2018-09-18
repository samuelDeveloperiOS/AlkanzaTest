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

    static func getDoctorPlaces(location:CLLocationCoordinate2D, completion:@escaping (_ error: Error?, _ response: GooglePlacesResponse?) -> Void) {
        
        let urlString = String.init(format: Constants.URL_GOOGLE_PLACES_SEARCH, location.latitude, location.longitude, Constants.GOOGLE_PLACES_KEY) 
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (responseData, _, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = responseData,
                let response = try? JSONDecoder().decode(GooglePlacesResponse.self, from: data)
                
            else {
                    
                    completion(nil, GooglePlacesResponse(results:[]))
                    return
            }
            completion(nil, response)
            
        }
        task.resume()
    }
}
