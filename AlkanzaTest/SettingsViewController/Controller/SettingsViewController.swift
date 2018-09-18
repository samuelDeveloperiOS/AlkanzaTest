//
//  SettingsViewController.swift
//  AlkanzaTest
//
//  Created by Samuel Romero on 18/09/18.
//  Copyright © 2018 Samuel. All rights reserved.
//

import UIKit
import CoreLocation

protocol SettingsDelegate:AnyObject{
    
    func settingsSaved(location: CLLocationCoordinate2D, radio: Double) -> Void;
}

class SettingsViewController: UIViewController {

    var location = CLLocationCoordinate2D()
    var radio:Double = 0.0
    weak var delegate:SettingsDelegate?
    
    @IBOutlet weak var latTextField: UITextField!
    @IBOutlet weak var lngTextField: UITextField!
    @IBOutlet weak var radioTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if radio != 0.0 {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveChanges(_ sender: UIButton) {
        
        
        if delegate != nil && ((latTextField.text != "" && lngTextField.text != "") || radioTextField.text != "") {
            
            var lat = latTextField.text?.toDouble()
            var lng = lngTextField.text?.toDouble()
            var rad = radioTextField.text?.toDouble()
            
            if lat == nil {
                lat = 0
            }
            
            if lng == nil {
                lng = 0
            }
            
            if rad == nil {
                rad = 0
            }
            
            delegate?.settingsSaved(location: CLLocationCoordinate2DMake(lat!,lng!), radio: rad!)
        }
        
        self.dismiss(animated: true, completion: nil)
    }

}
