//
//  WeatherManager.swift
//  Clima
//
//  Created by Богдан Ткачук on 09.12.2019.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didupdateWeather(weather: WeatherModule)
    func loudDidFailed(_ error: Error)
}


struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=049bf3230ea1fabaa2e024bef5ff6d5c&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather (latitude lat: CLLocationDegrees, longitude lon: CLLocationDegrees){
        let urlString = "\(weatherUrl)&lat=\(lat)&lon=\(lon)"
        performWeather(with: urlString)
    }
    
    func fetchWeather (cityName: String){
        let urlString = "\(weatherUrl)&q=\(cityName)"
        performWeather(with: urlString)
    }
    func performWeather(with urlString: String){
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, responce, error) in
                if  error != nil{
                    self.delegate?.loudDidFailed(error!)
                    return
                }
                if let safeDate = data {
                    if let weather = self.parseJson(safeDate){
                        self.delegate?.didupdateWeather(weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJson(_ weatherDate: Data) -> WeatherModule? {
        let decoder = JSONDecoder()
        do{
            let decoderData = try decoder.decode(WeatherData.self, from: weatherDate)
            let id = decoderData.weather[0].id
            let name = decoderData.name
            let temp = decoderData.main.temp
            
            let weather = WeatherModule(conditionId: id, cityName: name, temparature: temp)
            
            return weather
        }catch{
            self.delegate?.loudDidFailed(error)
            return nil
        }
    }
}
