//
//  UIView + Extension.swift
//  WeatherApp
//
//  Created by poskreepta on 26.05.23.
//

import UIKit

extension UIView {
    func addSubview(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}
