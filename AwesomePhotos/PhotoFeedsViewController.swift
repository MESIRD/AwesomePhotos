//
//  PhotoFeedsViewController.swift
//  AwesomePhotos
//
//  Created by mesird on 12/05/2017.
//  Copyright © 2017 mesird. All rights reserved.
//

import UIKit

class PhotoFeedsViewController: UIViewController {
    
    var backBlurPhotoView: UIImageView?
    var backMaskView: UIView?
    var photoCollectionView: UICollectionView?
    var editButton: UIButton?
    var downloadButton: UIButton?
    var shareButton: UIButton?
    var photographerLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
