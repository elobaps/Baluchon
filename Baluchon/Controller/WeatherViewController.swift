//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Elodie-Anne Parquer on 07/11/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak private var newYorkTempLabel: UILabel!
    @IBOutlet weak private var newYorkInfoLabel: UILabel!
    @IBOutlet weak private var newYorkImageView: UIImageView!
    @IBOutlet weak private var bordeauxTempLabel: UILabel!
    @IBOutlet weak private var bordeauxInfoLabel: UILabel!
    @IBOutlet weak private var bordeauxImageView: UIImageView!
    @IBOutlet weak private var compareButton: UIButton!
    @IBOutlet weak private var updateActivityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    private var list: WeatherData?
    private let weatherService = WeatherService()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherData()
    }
    
    // MARK: - Action
    
    @IBAction private func convertButtonTaped(_ sender: UIButton) {
        toggleActivityIndicator(shown: true)
        weatherData()
    }
    
    // MARK: - Methods
    
    /// method that manages the data of the network call
    private func weatherData() {
        weatherService.getWeather { result in
            switch result {
            case .success(let weatherData):
                DispatchQueue.main.sync {
                    self.toggleActivityIndicator(shown: false)
                    self.setUpUI(data: weatherData,
                                 tempLabels: [self.newYorkTempLabel, self.bordeauxTempLabel],
                                 infoLabels: [self.newYorkInfoLabel, self.bordeauxInfoLabel],
                                 images: [self.newYorkImageView, self.bordeauxImageView])
                }
            case .failure(let error):
                self.presentAlert(titre: "Error", message: "Service unavailable")
                print(error)
            }
        }
    }
    
    /// method that manages interface's update
    private func setUpUI(data: WeatherData, tempLabels: [UILabel], infoLabels: [UILabel], images: [UIImageView]) {
        for (index, label) in tempLabels.enumerated() {
            label.text = String(data.list[index].main.temp.rounded()) + "°"
        }
        for (index, label) in infoLabels.enumerated() {
            label.text = data.list[index].weather[0].weatherDescription
        }
        for (index, image) in images.enumerated() {
            image.image = UIImage(named: data.list[index].weather[0].icon ?? "09n")
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        updateActivityIndicator.isHidden = !shown
        compareButton.isHidden = shown
    }
}
