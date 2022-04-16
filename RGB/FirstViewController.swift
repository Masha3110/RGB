//
//  FirstViewController.swift
//  RGB
//
//  Created by SubZero on 16.04.2022.
//

import UIKit

class FirstViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsVC = segue.destination as! SettingsViewController 
        settingsVC.delegate = self
        settingsVC.currentViewColor = view.backgroundColor
    }

}


// MARK: ColorDelegate

extension FirstViewController: SettingsViewControllerDelegate {
    func saveColor(_ color: UIColor) {
        view.backgroundColor = color
        
    }
}
