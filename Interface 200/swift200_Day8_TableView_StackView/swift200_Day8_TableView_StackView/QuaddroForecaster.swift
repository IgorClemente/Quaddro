//
//  QuaddroForecaster.swift
//  Swift200_Day8_TableStack
//
//  Created by Nilo on 28/09/17.
//  Copyright © 2017 Nilo. All rights reserved.
//

import Foundation

func forecast(forCity city:String) -> (temp:Int, icon:String)? {
    
    print("Cidade: =>",city)
    let apikey  = "3c11dc2f82d273949cf81fd6889fa559"
    let base    = "https://api.openweathermap.org/data/2.5"
    let address = "\(base)/weather?q=\(city)&appid=\(apikey)&units=metric"
    
    guard let url  = URL(string: address),
        let data = try? Data(contentsOf: url),
        let json = try? JSONSerialization.jsonObject(with: data,
                                                     options: JSONSerialization.ReadingOptions()),
        let info      = json as? [String:Any],
        let weather   = info["main"] as? [String:Any],
        let temp      = weather["temp"] as? Int,
        let icons     = info["weather"] as? [[String:Any]],
        let iconCode  = icons.first?["main"] as? String else {
            print("Falhou Busca")
            return nil
    }
    
    let icon:String
    switch iconCode.lowercased() {
    case "thunderstorm": icon = "⛈"
    case "drizzle", "rain": icon = "🌧"
    case "snow": icon = "🌨"
    case "clouds", "atmosphere", "mist": icon = "☁️"
    case "clear": icon = "☀️"
    default: icon = "🌞"
    }
    print("\(temp)\(icon)")
    return (temp, icon)
}

