//
//  Functions.swift
//  CumulusWeather
//
//  Created by Joseph Szafarowicz on 1/20/23.
//

import Foundation

func setConditionImage(condition: String) -> String {
    var setCondition: String = ""
    if condition.contains("clear") {
        setCondition = "clear"
    } else if condition.contains("wind") || condition.contains("breeze") {
        setCondition = "windy"
    } else if condition.contains("foggy") {
        setCondition = "foggy"
    } else if condition.contains("haze") {
        setCondition = "haze"
    } else if condition.contains("heavy rain") {
        setCondition = "heavy.rain"
    } else if condition.contains("heavy snow") {
        setCondition = "heavy.snow"
    } else if condition.contains("partly") {
        setCondition = "partly.cloudy"
    } else if condition.contains("smoky") {
        setCondition = "smoky"
    } else if condition.contains("dust") || condition.contains("sand") {
        setCondition = "dust"
    } else if condition.contains("drizzle") || condition.contains("rain") {
        setCondition = "drizzle"
    }  else if condition.contains("snow") {
        setCondition = "snow"
    }  else if condition.contains("sleet") {
        setCondition = "sleet"
    } else if condition.contains("storm") {
        setCondition = "thunderstorm"
    } else if condition.contains("cloud") {
        setCondition = "cloudy"
    } else {
        setCondition = "partly.cloudy"
    }
    
    return "\(setCondition).pdf"
}
