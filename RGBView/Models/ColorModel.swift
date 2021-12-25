//
//  ColorModel.swift
//  RGBView
//
//  Created by ILYA BILARUS on 25.12.2021.
//

import UIKit

struct ColorModel {
    
    var red: Float
    var green: Float
    var blue: Float
    
    func getColor() -> UIColor {
        UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
    }
    
}
