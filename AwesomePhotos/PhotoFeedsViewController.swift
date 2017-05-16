//
//  PhotoFeedsViewController.swift
//  AwesomePhotos
//
//  Created by mesird on 12/05/2017.
//  Copyright © 2017 mesird. All rights reserved.
//

import UIKit
import Alamofire

import MJExtension

class PhotoFeedsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    
    var backBlurPhotoView: UIImageView?
    var backMaskView: UIView?
    var photographerLabel: UILabel?
    var photoCollectionView: UICollectionView?
    var editButton: UIButton?
    var downloadButton: UIButton?
    var shareButton: UIButton?
    
    var feeds: Array<APFeed>?
    
    let kReuseIdFeedsCell = "FeedsCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.initData()
        self.initUI()
        self.refreshData()
    }
    
    func initData() {
        feeds = []
    }
    
    func initUI() {
        backBlurPhotoView = UIImageView(frame: UIScreen.main.bounds)
        self.view.addSubview(backBlurPhotoView!)
        
        backMaskView = UIView(frame: UIScreen.main.bounds)
        backMaskView!.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        self.view.addSubview(backMaskView!)
        
        photographerLabel = UILabel(frame: CGRect(x: 15, y: 15 + 22, width: ScreenWidth - 30, height: 20))
        photographerLabel!.textColor = UIColor.white
        self.view.addSubview(photographerLabel!)
        
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.itemSize = CGSize(width: ScreenWidth, height: ScreenHeight)
        
        photoCollectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: collectionLayout)
        photoCollectionView!.delegate = self
        photoCollectionView!.dataSource = self
        photoCollectionView!.register(APFeedsCollectionViewCell.self, forCellWithReuseIdentifier: kReuseIdFeedsCell)
        self.view.addSubview(photoCollectionView!)
        
        downloadButton = UIButton(frame: CGRect(x: (ScreenWidth - 40) / 2, y: ScreenHeight - 50 - 40, width: 40, height: 40))
        downloadButton!.setImage(UIImage.init(named: "download_button"), for: .normal)
        downloadButton!.addTarget(self, action: #selector(self.downloadPhoto), for: .touchUpInside)
        self.view.addSubview(downloadButton!)
        
        editButton = UIButton(frame: CGRect(x: downloadButton!.frame.minX - 50 - 40, y: ScreenHeight - 50 - 40, width: 40, height: 40))
        editButton!.setImage(UIImage.init(named: "edit_button"), for: .normal)
        editButton!.addTarget(self, action: #selector(self.editPhoto), for: .touchUpInside)
        self.view.addSubview(editButton!)
        
        shareButton = UIButton(frame: CGRect(x: downloadButton!.frame.maxX + 50, y: ScreenHeight - 50 - 40, width: 40, height: 40))
        shareButton!.setImage(UIImage.init(named: "share_button"), for: .normal)
        shareButton!.addTarget(self, action: #selector(self.sharePhoto), for: .touchUpInside)
        self.view.addSubview(shareButton!)
    }
    
    func refreshData() {
        let parameters: Parameters = ["client_id": "fb960eecf28eaa7e534b592cd49238327e5d976a7b5218c021605dcb4475b759"]
        Alamofire.request("https://api.unsplash.com/photos/", method: .get, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                let feeds: Array<APFeed> = APFeed.mj_objectArray(withKeyValuesArray: response.result.value!) as! Array<APFeed>
                self.feeds = feeds
                self.photoCollectionView?.reloadData()
            } else {
                print("Refresh data failed.")
            }
        }
    }
    
    func loadMoreData() {
        
    }
    
    // edit the displaying photo
    func editPhoto() {
        
    }
    
    // download the displaying photo
    func downloadPhoto() {
        
    }
    
    // share the displaying photo
    func sharePhoto() {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: APFeedsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: kReuseIdFeedsCell, for: indexPath) as! APFeedsCollectionViewCell
        
        cell.photoView!.image = UIImage(named: "demo")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feeds!.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let index: Int = Int(offset.x / ScreenWidth)
        let feed = feeds![index]
        DispatchQueue.global().async {
            try!
            let imageData: NSData = NSData(contentsOf: NSURL(string: (feed.cover_photo?.urls?.regular)!)! as URL)
            let image = UIImage.init(data: imageData as Data)
        }
        backBlurPhotoView!.image =
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
