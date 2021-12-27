//
//  ViewController.swift
//  RGBView
//
//  Created by ILYA BILARUS on 10.12.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    var backColor: CIColor!
    var red: CGFloat!
    var green: CGFloat!
    var blue: CGFloat!
    
    var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
          
        red = backColor.red
        green = backColor.green
        blue = backColor.blue
        
        updateUI()
        
        addKeyboardNotifications()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    
    
    @IBAction func sliderAction() {
        
        red = CGFloat(round(100 * redSlider.value) / 100)
        green = CGFloat(round(100 * greenSlider.value) / 100)
        blue = CGFloat(round(100 * blueSlider.value) / 100)
        backColor = CIColor(red: red, green: green, blue: blue, alpha: 1)
        
        updateUI()
        
    }
    
    @IBAction func saveColorPressed(_ sender: UIBarButtonItem) {
        delegate.updateColorModel(backColor)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func backPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    private func updateUI() {
        let red = Float(backColor.red)
        let green = Float(backColor.green)
        let blue = Float(backColor.blue)
        
        redSlider.value = red
        greenSlider.value = green
        blueSlider.value = blue
        
        redTextField.text = String(red).replacingOccurrences(of: ".", with: ",")
        greenTextField.text = String(green).replacingOccurrences(of: ".", with: ",")
        blueTextField.text = String(blue).replacingOccurrences(of: ".", with: ",")
        
        colorView.backgroundColor = UIColor(ciColor: backColor)
    }
    
    
}

extension SettingsViewController: UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let value = textField.text?.replacingOccurrences(of: ",", with: ".") else { return }
        
        guard let newValue = Float(value) else {
            textField.text = "0"
            showAllert(title: "неверное значение", message: "пожалуйста введите число от 0 до 1")
            return
        }
        
        guard newValue >= 0 && newValue <= 1 else {
            textField.text = "0"
            showAllert(title: "неверное значение", message: "пожалуйста введите число от 0 до 1")
            return
        }
        
        switch textField.tag {
        case 0:
            red = CGFloat(newValue)
        case 1:
            green = CGFloat(newValue)
        case 2:
            blue = CGFloat(newValue)
        default:
            break
        }
        backColor = CIColor(red: red, green: green, blue: blue, alpha: 1)
        

        
        
        updateUI()
        
    }
}


//MARK: - UIAllertNotifications
extension SettingsViewController {
    
    private func showAllert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}

//MARK: - KeyboardNotifications
extension SettingsViewController {
    
    func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillHide() {
        bottomConstraint.constant = 40
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            bottomConstraint.constant = keyboardSize.height
        }
    }
}

