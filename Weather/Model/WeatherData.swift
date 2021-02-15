//
//  WeatherData.swift
//  Weather
//
//  Created by Bennett Zhu on 2/12/21.
//  Copyright © 2021 BennettZhu. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}

