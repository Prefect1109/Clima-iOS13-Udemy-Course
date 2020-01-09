//
//  WeatherModel.swift
//  Clima
//
//  Created by Богдан Ткачук on 14.12.2019.
//

import Foundation

struct WeatherModule {
    let conditionId: Int
    let cityName:  String
    let temparature:  Double
    
    var temparatureString: String{
        return String(format: "%.1f", temparature)
    }
    var nameOfWeatherCondition: String{
        
        let nameOfWeatherCondition: String
        switch conditionId {
        case 200...232:
            nameOfWeatherCondition = "cloud.bolt.rain"
        case 300...321:
            nameOfWeatherCondition = "cloud.drizzle"
        case 500...531:
            nameOfWeatherCondition = "cloud.rain"
        case 600...622:
            nameOfWeatherCondition = "cloud.snow"
        case 701:
            nameOfWeatherCondition = "sun.haze"
        case 711:
            nameOfWeatherCondition = "smoke"
        case 721:
            nameOfWeatherCondition = "sun.haze"
        case 731:
            nameOfWeatherCondition = "sun.dust.fill"
        case 741:
            nameOfWeatherCondition = "cloud.fog"
        case 751:
            nameOfWeatherCondition = "sun.dust.fill"
        case 761:
            nameOfWeatherCondition = "sun.dust"
        case 762:
            nameOfWeatherCondition = "bandage"
        case 771:
            nameOfWeatherCondition = "wind"
        case 781:
            nameOfWeatherCondition = "tornado"
        case 800:
            nameOfWeatherCondition = "sun.max"
        case 801...804:
            nameOfWeatherCondition = "cloud"
        default:
            nameOfWeatherCondition = "zzz"
        }
        return nameOfWeatherCondition
    }
}

