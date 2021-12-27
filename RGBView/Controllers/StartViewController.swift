//
//  StartViewController.swift
//  RGBView
//
//  Created by ILYA BILARUS on 25.12.2021.
//

import UIKit

class StartViewController: UIViewController {
    
    var backColor  = CIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)

    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor(ciColor: backColor)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        let settingsVC = navigationVC.topViewController as! SettingsViewController
        settingsVC.backColor = backColor
        settingsVC.delegate = self
    }
}
    

    extension StartViewController: SettingsViewControllerDelegate {
        func updateColorModel(_ color: CIColor) {
            backColor = color
            view.backgroundColor = UIColor(ciColor: backColor)
        }
    }
    
    
    
protocol SettingsViewControllerDelegate {
    
        func updateColorModel(_ color: CIColor)
    }
