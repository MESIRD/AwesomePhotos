//
//  APUser.swift
//  AwesomePhotos
//
//  Created by mesird on 16/05/2017.
//  Copyright © 2017 mesird. All rights reserved.
//

import UIKit

class APUser: NSObject {

    var id: String?
    var updated_at: Date?
    var username: String?
    var name: String?
    var first_name: String?
    var last_name: String?
    var portfolio_url: String?
    var bio: String?
    var location: String?
    var total_likes: Int?
    var total_photos: Int?
    var total_collections: Int?
    var profile_image: APImage?
    var links: APLink?
}
