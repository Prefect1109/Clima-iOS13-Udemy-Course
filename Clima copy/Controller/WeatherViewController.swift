//
//  ViewController.swift
//  Clima
//
//  Created by Bohdan
//

import UIKit
import CoreLocation


class WeatherViewController: UIViewController{
    
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchField: UITextField!
    
    var weatherManager = WeatherManager()
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchField.delegate = self
    }
    @IBAction func locationButton(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate{
    
    @IBAction func searchButton(_ sender: UIButton) {
        searchField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchField.text != "" {
            return true
        }else{
            searchField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let cityText = searchField.text {
            print(weatherManager.fetchWeather(cityName: cityText))
        }
        searchField.text = ""
    }
    
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate{
    func didupdateWeather(weather: WeatherModule) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temparatureString
            self.conditionImageView.image = UIImage(systemName: weather.nameOfWeatherCondition)
            self.cityLabel.text = weather.cityName
        }
    }
    func loudDidFailed(_ error: Error){
        print("Error")
    }
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

