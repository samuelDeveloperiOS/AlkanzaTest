//
//  String+toDouble.swift
//  AlkanzaTest
//
//  Created by Samuel Romero on 18/09/18.
//  Copyright © 2018 Samuel. All rights reserved.
//

import UIKit

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
