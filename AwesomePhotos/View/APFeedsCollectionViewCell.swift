//
//  APFeedsCollectionViewCell.swift
//  AwesomePhotos
//
//  Created by mesird on 17/05/2017.
//  Copyright © 2017 mesird. All rights reserved.
//

import UIKit
import SDWebImage

class APFeedsCollectionViewCell: UICollectionViewCell {
    
    var photoView: UIImageView?
    var shadowView: UIImageView?
    var indicatorView: UIActivityIndicatorView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let margin: CGFloat = 30
        let length = ScreenWidth - (margin * 2)
        
        shadowView = UIImageView(frame: CGRect(x: margin, y: (ScreenHeight + length) / 2 - 25, width: length, height: 50))
        shadowView!.image = UIImage(named: "photo_shadow")
        contentView.addSubview(shadowView!)
        
        indicatorView = UIActivityIndicatorView(frame: CGRect(x: (ScreenWidth - 50) / 2, y: (ScreenHeight - 50) / 2, width: 50, height: 50))
        indicatorView!.activityIndicatorViewStyle = .white
        indicatorView!.hidesWhenStopped = false
        indicatorView!.startAnimating()
        contentView.addSubview(indicatorView!)
        
        photoView = UIImageView(frame: CGRect(x: margin, y: (ScreenHeight - length) / 2, width: length, height: length))
        photoView!.layer.cornerRadius = 5
        photoView!.layer.masksToBounds = true
        photoView!.contentMode = .scaleAspectFill
        contentView.addSubview(photoView!)
    }
    
    func setPhoto(with url:URL) {
        photoView!.sd_setImage(with: url)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
