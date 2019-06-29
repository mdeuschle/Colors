//
//  Color.swift
//  Colors
//
//  Created by Matt Deuschle on 6/29/19.
//  Copyright © 2019 Matt Deuschle. All rights reserved.
//

import UIKit

struct Color: Decodable {
    let title: String?
    let rank: Int?
    let rgb: RGB?
}

struct RGB: Decodable {
    let red: CGFloat?
    let green: CGFloat?
    let blue: CGFloat?
    
    var color: UIColor {
        guard let red = red,
        let green = green,
            let blue = blue else { return .white }
        return UIColor(red: red/255,
                       green: green/255,
                       blue: blue/255,
                       alpha: 1.0)
    }
}

