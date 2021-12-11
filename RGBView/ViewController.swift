//
//  ViewController.swift
//  RGBView
//
//  Created by ILYA BILARUS on 10.12.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        
    }

    @IBAction func sliderAction() {
        
        let redValue = round(100 * redSlider.value) / 100
        let greenValue = round(100 * greenSlider.value) / 100
        let blueValue = round(100 * blueSlider.value) / 100
        
        colorView.backgroundColor = UIColor(red: CGFloat(redValue), green: CGFloat(greenValue), blue: CGFloat(blueValue), alpha: 1)
        
        redValueLabel.text = String(redValue)
        greenValueLabel.text = String(greenValue)
        blueValueLabel.text = String(blueValue)
        
    }
    
}

