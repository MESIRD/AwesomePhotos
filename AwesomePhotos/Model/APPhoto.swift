//
//  APPhoto.swift
//  AwesomePhotos
//
//  Created by mesird on 16/05/2017.
//  Copyright © 2017 mesird. All rights reserved.
//

import UIKit

class APPhoto: NSObject {
    
    var id: String?
    var created_at: Date?
    var updated_at: Date?
    var width: Int?
    var height: Int?
    var color: String?
    var likes: Int?
    var liked_by_user: Bool?
    var user: APUser?
    var urls: APUrl?
    var categories: Array<APCategory>?
    var links: APLink?
}
