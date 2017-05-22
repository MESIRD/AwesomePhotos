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

let UnsplashClientId = "fb960eecf28eaa7e534b592cd49238327e5d976a7b5218c021605dcb4475b759"
let WXAppId = "wx2470774754d4a31d"

func color(_ r: Int8, g: Int8, b: Int8, a: Float) -> UIColor {
    return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(a))
}
