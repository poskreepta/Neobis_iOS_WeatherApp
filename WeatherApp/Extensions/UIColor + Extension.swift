//
//  UIColor+Extension.swift
//  Neobis_iOS_UIScreens
//
//  Created by G G on 06.04.2023.
//

import UIKit

extension UIColor {
    convenience init(hexString: String) {
        var colorString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        colorString = colorString.replacingOccurrences(of: "#", with: "").uppercased()
        let alpha: CGFloat = 1.0
        let red: CGFloat = colorComponentFrom(colorString: colorString, start: 0, length: 2)
        let green: CGFloat = colorComponentFrom(colorString: colorString, start: 2, length: 2)
        let blue: CGFloat = colorComponentFrom(colorString: colorString, start: 4, length: 2)
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

func colorComponentFrom(colorString: String, start: Int, length: Int) -> CGFloat {
    
    let startIndex = colorString.index(colorString.startIndex, offsetBy: start)
    let endIndex = colorString.index(startIndex, offsetBy: length)
    let subString = colorString[startIndex..<endIndex]
    let fullHexString = length == 2 ? subString : "\(subString)\(subString)"
    var hexComponent: UInt64 = 0
    guard Scanner(string: String(fullHexString)).scanHexInt64(&hexComponent) else {
        return 0
    }
    let hexFloat: CGFloat = CGFloat(hexComponent)
    let floatValue: CGFloat = CGFloat(hexFloat / 255.0)
    return floatValue
}
