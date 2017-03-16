//
//  UIView+squareToCircle.swift
//  Task app
//
//  Created by Joseph Liu on 16.03.17.
//  Copyright © 2017 Joseph Liu. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /**
    This method turns a square UIView into a circle by rounding its corners.
    */
    
    func squareToCircle() -> UIView {
        
        let view1 = self
        view1.layer.cornerRadius = view1.frame.size.height/2
        return view1
        
    }
    
}
