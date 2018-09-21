//
//  CalculateMinimumBL.swift
//  AlkanzaTest
//
//  Created by Samuel on 20/9/18.
//  Copyright © 2018 Samuel. All rights reserved.
//

import UIKit

class CalculateMinimumBL: NSObject {

    static func calculate(distanceArray:[Int], completion:(_ position:Int, _ minimum: Double) -> Void) {
        
        var minimum:Double = Double.infinity
        var position:Int = 0
        
        var counter:Int = 0
        
        for i in distanceArray{
            
            var minimumAux:Double = 0
            
            for j in distanceArray{
                minimumAux += Double(abs(i-j))
            }
            
            if minimumAux<minimum{
                minimum = minimumAux
                position = counter
            }
            
            counter+=1
        }
        
        completion(position, minimum)
        
    }
}
