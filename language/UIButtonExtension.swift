//
//  UIButton.swift
//  language
//
//  Created by Arif Khan on 11/12/16.
//  Copyright © 2016 Snnab. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func setPreferences() {
        self.layer.cornerRadius = 3
        //self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderColor = UIColor(red: 0/255, green: 181/255, blue: 229/255, alpha: 1.0).cgColor
       
        
        self.layer.borderWidth = 0.5
        
        self.backgroundColor = UIColor(red: 0.0/255.0, green: 204.0/255.0, blue: 255.0/255.0, alpha: 0.5)
        self.backgroundColor = UIColor(red: 0.25098040700000002, green: 0.0, blue: 0.50196081400000003, alpha: 1.0)
        
        //the background color light blue
        self.titleLabel?.textColor = UIColor.white //make the text white
        self.setTitleColor(UIColor.white, for: UIControlState.normal)
        //self.alpha = 0.5 //make the header transparent
        
        self.titleLabel?.font = UIFont(name: "Cochin", size: 25)!
        
    }
}
