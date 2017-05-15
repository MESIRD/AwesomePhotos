//
//  APFeed.swift
//  AwesomePhotos
//
//  Created by mesird on 16/05/2017.
//  Copyright © 2017 mesird. All rights reserved.
//

import UIKit

class APFeed: NSObject {

    var id: Int?
    var title: String?
    var desc: String?
    var published_at: Date?
    var updated_at: Date?
    var curated: Bool?
    var featured: Bool?
    var total_photos: Int?
    var is_private: Bool?
    var share_key: String?
    var cover_photo: APPhoto?
    var user: APUser?
    var links: APLink?
}
