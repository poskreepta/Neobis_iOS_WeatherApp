//
//  UILabel + Extensions.swift
//  WeatherApp
//
//  Created by poskreepta on 23.05.23.
//

import UIKit

extension UILabel {
    func configureWeatherParameterName(with: String) -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Fonts.montserratBold, size: 14)
        label.textAlignment = .center
        label.text = text
        return label
    }
    
    func configureWeatherParameterValue(with: String) -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: Fonts.montserratRegular, size: 14)
        label.textAlignment = .center
        label.text = text
        return label
    }
    
    
}
