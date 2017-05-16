//
//  PrefixHeader.swift
//  AwesomePhotos
//
//  Created by mesird on 14/05/2017.
//  Copyright © 2017 mesird. All rights reserved.
//

import UIKit

let ScreenWidth  = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height

func color(_ r: Int8, g: Int8, b: Int8, a: Float) -> UIColor {
    return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(a))
}
