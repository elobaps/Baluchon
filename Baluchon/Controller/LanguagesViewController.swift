//
//  LanguagesViewController.swift
//  Baluchon
//
//  Created by Elodie-Anne Parquer on 21/11/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import UIKit

final class LanguagesViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak private var languagesPickerView: UIPickerView!
    
    // MARK: - Properties
    
    var languages = [Language]()
    var language = String()
}

// MARK: - PickerView

/// extension that manage PickerViewController and allows the user to choose for the target language
extension LanguagesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
      }
      
      func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
          return languages.count
      }
      
      func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          return languages[row].language
      }
      
      func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
          language = languages[row].language
          //print(language)
      }
}
