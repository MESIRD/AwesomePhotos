//
//  APFeedsCollectionViewCell.swift
//  AwesomePhotos
//
//  Created by mesird on 17/05/2017.
//  Copyright © 2017 mesird. All rights reserved.
//

import UIKit

class APFeedsCollectionViewCell: UICollectionViewCell {
    
    var photoView: UIImageView?
    var shadowView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let length = ScreenWidth - 100
        
        shadowView = UIImageView(frame: CGRect(x: 50, y: (ScreenHeight + length) / 2 - 25, width: length, height: 50))
        shadowView!.image = UIImage(named: "photo_shadow")
        self.addSubview(shadowView!)
        
        photoView = UIImageView(frame: CGRect(x: 50, y: (ScreenHeight - length) / 2, width: length, height: length))
        photoView!.layer.cornerRadius = 5
        photoView!.layer.masksToBounds = true
        self.addSubview(photoView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
