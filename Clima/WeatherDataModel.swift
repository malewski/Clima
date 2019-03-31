//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Angela Yu on 24/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

final class WeatherDataModel: Decodable {

    //Declare your model variables here
    var temperature : Double = 0
    var cityName : String = ""
    var weatherIcon : String = ""
    var condition : Int = 0
    
    enum CodingKeys: String, CodingKey {
        case main = "main"
        case cityName = "name"
        case condition = "cod"
        
        enum MainKeys: String, CodingKey {
            case temperature = "temp"
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cityName = try container.decode(String.self, forKey: .cityName)
        condition = try container.decode(Int.self, forKey: .condition)
        let mainContainer = try container.nestedContainer(keyedBy: CodingKeys.MainKeys.self, forKey: .main)
        temperature = try mainContainer.decode(Double.self, forKey: .temperature)
        weatherIcon = updateWeatherIcon(condition: condition)
    }
    //This method turns a condition code into the name of the weather condition image
    
    func updateWeatherIcon(condition: Int) -> String {
        
    switch (condition) {
    
        case 0...300 :
            return "tstorm1"
        
        case 301...500 :
            return "light_rain"
        
        case 501...600 :
            return "shower3"
        
        case 601...700 :
            return "snow4"
        
        case 701...771 :
            return "fog"
        
        case 772...799 :
            return "tstorm3"
        
        case 800 :
            return "sunny"
        
        case 801...804 :
            return "cloudy2"
        
        case 900...903, 905...1000  :
            return "tstorm3"
        
        case 903 :
            return "snow5"
        
        case 904 :
            return "sunny"
        
        default :
            return "dunno"
        }

    }
}
