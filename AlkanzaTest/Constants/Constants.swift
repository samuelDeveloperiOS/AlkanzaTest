//
//  Constants.swift
//  AlkanzaTest
//
//  Created by Samuel on 17/9/18.
//  Copyright © 2018 Samuel. All rights reserved.
//

import UIKit

class Constants: NSObject {

    static let GOOGLE_PLACES_SERVER = "https://maps.googleapis.com/maps/api/place"
    
    static let GOOGLE_MAPS_KEY = "AIzaSyCN4KIBhl-3CKwNih-DPkh6BanVVYqxBpA"
    static let GOOGLE_PLACES_KEY = "AIzaSyBGOVvrHspeVjtaQsj0N6jqYdrwVsHsBQE"
    
    static let URL_GOOGLE_PLACES_SEARCH = GOOGLE_PLACES_SERVER+"/nearbysearch/json?location=%f,%f&radius=%d&type=doctor&key=%@";
    
}
