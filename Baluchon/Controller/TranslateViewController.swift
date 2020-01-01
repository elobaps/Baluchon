//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by Elodie-Anne Parquer on 14/11/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import UIKit

final class TranslateViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak private var sourceTextView: UITextView!
    @IBOutlet weak private var targetTextView: UITextView!
    @IBOutlet weak private var translateButton: UIButton!
    @IBOutlet weak private var updateActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak private var selectLanguagesButton: UIButton!
    
    // MARK: - Properties
    
    private let translateService = TranslateService()
    private var languages = [Language]()
    var language = "en"
    
    // MARK: - View Life Cycle
    
    /// method that manages the data of the network call
    override func viewDidLoad() {
        super.viewDidLoad()
        translateService.getLanguages { result in
            switch result {
            case .success(let languages):
                DispatchQueue.main.sync {
                    self.toggleActivityIndicator(shown: false)
                    self.languages = languages.data.languages
                }
            case .failure(let error):
                self.presentAlert(titre: "Error", message: "Service unavailable")
                print(error)
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func translateButtonTapped(_ sender: UIButton) {
        if sourceTextView.text.isEmpty {
            presentAlert(titre: "Error", message: "Please enter one word at least")
        } else {
            toggleActivityIndicator(shown: true)
            updateTranslation()
        }
    }
    
    @IBAction private func selectLanguagesButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "segueToLanguagesController", sender: nil)
    }
    
    /// method that retrieves data from the languageviewController
    @IBAction func didUnwindFromLanguagesViewController(_ sender: UIStoryboardSegue) {
        guard let languagesViewController = sender.source as? LanguagesViewController else { return }
        language = languagesViewController.language
        selectLanguagesButton.setTitle(language, for: .normal)
    }
    
    // MARK: - Methods
    
    /// method that manages the data of the network call
    private func updateTranslation() {
        translateService.getTranslation(text: sourceTextView.text ?? "Enter a text", target: language) { result in
              switch result {
              case .success(let translateQuote):
                  DispatchQueue.main.sync {
                      self.toggleActivityIndicator(shown: false)
                      self.targetTextView.text = translateQuote.data.translations[0].translatedText
                  }
              case .failure(let error):
                  self.presentAlert(titre: "Error", message: "Service unavailable")
                  print(error)
              }
          }
      }
    
    private func toggleActivityIndicator(shown: Bool) {
           updateActivityIndicator.isHidden = !shown
           translateButton.isHidden = shown
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let languagesViewController = segue.destination as? LanguagesViewController
        languagesViewController?.languages = languages
    }
}
    // MARK: - Keyboard

extension TranslateViewController: UITextFieldDelegate, UITextViewDelegate {
    @IBAction private func dismissKeyBoard(_ sender: UITapGestureRecognizer) {
        sourceTextView.resignFirstResponder()
        targetTextView.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        sourceTextView.text = ""
        targetTextView.text = ""
    }
}
