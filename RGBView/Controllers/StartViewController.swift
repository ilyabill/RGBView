//
//  StartViewController.swift
//  RGBView
//
//  Created by ILYA BILARUS on 25.12.2021.
//

import UIKit

class StartViewController: UIViewController {
    
    var colorModel  = ColorModel(red: 0.7, green: 0.2, blue: 0.5)

    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = colorModel.getColor()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        let settingsVC = navigationVC.topViewController as! SettingsViewController
        settingsVC.colorModel = colorModel
        settingsVC.delegate = self
    }
}
    

    extension StartViewController: SettingsViewControllerDelegate {
        func updateColorModel(_ color: ColorModel) {
            colorModel = color
            view.backgroundColor = colorModel.getColor()
        }
    }
    
    
    
protocol SettingsViewControllerDelegate {
    
        func updateColorModel(_ color: ColorModel)
    }
