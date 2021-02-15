//
//  AppDelegate.swift
//  Weather
//
//  Created by Bennett Zhu on 2/12/21.
//  Copyright © 2021 BennettZhu. All rights reserved.
//


import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {

    //Link IBOutlets
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self
        
        //allow editing and validation of text field
        searchTextField.delegate = self
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
    //allow processing of return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    //allow user to end editing if text field has populated
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (textField.text != "") {
            return true
        } else {
            textField.placeholder = "Enter a City"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //
        
        if let city = searchTextField.text {
            weatherManager.getWeather(cityName: city)
        }
        
        
        searchTextField.text = ""
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async{
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            
        }
        
         
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

