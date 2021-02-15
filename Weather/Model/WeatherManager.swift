//
//  WeatherManager.swift
//  Weather
//
//  Created by Bennett Zhu on 2/12/21.
//  Copyright © 2021 BennettZhu. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let apiCall = "https://api.openweathermap.org/data/2.5/weather?appid=d3c9b98001daf0512c43ee90b4941b08&units=imperial"
    let apiKey = "d3c9b98001daf0512c43ee90b4941b08"
    
    var delegate: WeatherManagerDelegate?
    
    func getWeather(cityName: String) {
        
        //create urlString
        let urlString = "\(apiCall)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //create URL
        if let url = URL(string: urlString) {
            //create session
            let session = URLSession(configuration: .default)
            
            //give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if (error != nil) {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }

            //start task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
             
            return weather
        }
        catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }    
}
