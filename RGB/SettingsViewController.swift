//
//  ViewController.swift
//  RGB
//
//  Created by SubZero on 31.03.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func saveColor(_ color: UIColor)
}

class SettingsViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
 
    
    
    // MARK: Public Properties
    var delegate: SettingsViewControllerDelegate!
    var currentViewColor: UIColor!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        redSlider.minimumValue = 0.0
//        greenSlider.minimumValue = 0.0
//        blueSlider.minimumValue = 0.0
//
//        redSlider.maximumValue = 1
//        greenSlider.maximumValue = 1
//        blueSlider.maximumValue = 1
//
//        redSlider.value = 0.3
//        greenSlider.value = 0.5
//        blueSlider.value = 0.7
        
//        redTextField.placeholder = String(redSlider.value)
//        greenTextField.placeholder = String(greenSlider.value)
//        blueTextField.placeholder = String(blueSlider.value)
        
        
//        redLabel.text = String(redSlider.value)
//        greenLabel.text = String(greenSlider.value)
//        blueLabel.text = String(blueSlider.value)

        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        blueSlider.tintColor = .blue
        
        mainView.layer.cornerRadius = 15
        setColor()
        
        

        setValue(for: redTextField, greenTextField, blueTextField)
        setValue(for: redLabel, greenLabel, blueLabel)
        setValue(for: redSlider, greenSlider, blueSlider)
        addDoneButtonTo(redTextField, greenTextField, blueTextField)
        
    }

    @IBAction func rgbSlider(_ sender: UISlider) {
        switch sender.tag {
        case 0:
            setValue(for: redLabel)
            setValue(for: redTextField)
        case 1:
            setValue(for: greenLabel)
            setValue(for: greenTextField)
        case 2:
            setValue(for: blueLabel)
            setValue(for: blueTextField)
        default:
            break
        }
        setColor()
    }
    
    @IBAction func DonePressed() {
        delegate.saveColor(mainView.backgroundColor ?? .white)
        dismiss(animated: true)
        
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let firstVC = segue.destination as! FirstViewController
//        currentViewColor = firstVC.view.backgroundColor
//        redSlider.value = Float(currentViewColor.ciColor.red)
//        greenSlider.value = Float(currentViewColor.ciColor.green)
//        blueSlider.value = Float(currentViewColor.ciColor.blue)
//    }
    
    
    
    private func setColor() {
        mainView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
    }
    
    private func setValue(for labels: UILabel ... ) {
        labels.forEach { lable in
            switch lable.tag {
            case 0: redLabel.text = string(from: redSlider)
            case 1: greenLabel.text = string(from: greenSlider)
            case 2: blueLabel.text = string(from: blueSlider)
                
            default:
                break
            }
        }
    }
    
    private func setValue(for textFields: UITextField ...) {
        textFields.forEach { textField in
            switch textField.tag {
            case 0: redTextField.text = string(from: redSlider)
            case 1: greenTextField.text = string(from: greenSlider)
            case 2: blueTextField.text = string(from: blueSlider)
            default : break
            }
        }
    }
    
    private func setValue(for sliders : UISlider ...) {
        let ciColor = CIColor(color: currentViewColor)
        
        sliders.forEach { slider in
            switch slider.tag {
            case 0: redSlider.value = Float(ciColor.red)
            case 1: greenSlider.value = Float(ciColor.green)
            case 2: blueSlider.value = Float(ciColor.blue)
            default: break
            }
        }
    }
    

    
    
    // RGB
    private func string(from: UISlider) -> String {
        return String(format: "%.2f", from.value)
    }
    
    private func addDoneButtonTo(_ textFields: UITextField ...) {
        textFields.forEach { textField in
            let keyBoardToolBar = UIToolbar()
            textField.inputAccessoryView = keyBoardToolBar
            keyBoardToolBar.sizeToFit()
            
            let doneButton = UIBarButtonItem(title: "Done",
                                             style: .done,
                                             target: self,
                                             action: #selector(didTapDone))
            
            let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                target: nil,
                                                action: nil)
            keyBoardToolBar.items = [flexBarButton, doneButton]
        }
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}

// MARK: UITextFieldDelegate

extension SettingsViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if let currentValue = Float(text) {
            
            switch textField.tag {
            case 0:
                redSlider.setValue(currentValue, animated: true)
                setValue(for: redLabel)
            case 1:
                greenSlider.setValue(currentValue, animated: true)
                setValue(for: greenLabel)
            case 2:
                blueSlider.setValue(currentValue, animated: true)
                setValue(for: blueLabel)
            default: break
            }
            
            setColor()
            return
        } else {
            showAlert(title: "Wrong format", message: "Please enter correct type")
        }
    }
    
}
