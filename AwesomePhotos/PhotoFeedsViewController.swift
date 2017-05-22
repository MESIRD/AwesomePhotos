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
import SDWebImage
import SABlurImageView
import MBProgressHUD


class PhotoFeedsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    
    var backBlurPhotoViews: Array<SABlurImageView> = []
    var currentBackPhotoIndex: Int = 0
    
    var backMaskView: UIView?
    var photographerLabel: UILabel?
    var photoCollectionView: UICollectionView?
    var editButton: UIButton?
    var downloadButton: UIButton?
    var shareButton: UIButton?
    
    var feedPhotos: Array<APPhoto> = []
    var currentPhotoIndex: Int = 0
    
    var indicatorView: UIActivityIndicatorView?
    
    let kReuseIdFeedsCell = "FeedsCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.initData()
        self.initUI()
        self.refreshData()
    }
    
    func initData() {
        
    }
    
    func initUI() {
        let backBlurPhotoViewA = SABlurImageView(frame: UIScreen.main.bounds)
        backBlurPhotoViewA.contentMode = .scaleAspectFill
        view.addSubview(backBlurPhotoViewA)
        backBlurPhotoViews.append(backBlurPhotoViewA)
        
        let backBlurPhotoViewB = SABlurImageView(frame: UIScreen.main.bounds)
        backBlurPhotoViewB.contentMode = .scaleAspectFill
        backBlurPhotoViewB.alpha = 0
        view.addSubview(backBlurPhotoViewB)
        backBlurPhotoViews.append(backBlurPhotoViewB)
        
        backMaskView = UIView(frame: UIScreen.main.bounds)
        backMaskView!.backgroundColor = UIColor.init(white: 0, alpha: 0.3)
        view.addSubview(backMaskView!)
        
        photographerLabel = UILabel(frame: CGRect(x: 15, y: 15, width: ScreenWidth - 30, height: 20))
        photographerLabel!.textAlignment = .right
        view.addSubview(photographerLabel!)
        
        indicatorView = UIActivityIndicatorView(frame: CGRect(x: (ScreenWidth - 50) / 2, y: (ScreenHeight - 50) / 2, width: 50, height: 50))
        indicatorView!.activityIndicatorViewStyle = .white
        indicatorView!.startAnimating()
        view.addSubview(indicatorView!)
        
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.itemSize = CGSize(width: ScreenWidth, height: ScreenHeight)
        collectionLayout.minimumLineSpacing = 0
        
        photoCollectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: collectionLayout)
        photoCollectionView!.delegate = self
        photoCollectionView!.dataSource = self
        photoCollectionView!.register(APFeedsCollectionViewCell.self, forCellWithReuseIdentifier: kReuseIdFeedsCell)
        photoCollectionView!.isPagingEnabled = true
        photoCollectionView!.backgroundColor = UIColor.clear
        view.addSubview(photoCollectionView!)
        
        downloadButton = UIButton(frame: CGRect(x: (ScreenWidth - 40) / 2, y: ScreenHeight - 50 - 40, width: 40, height: 40))
        downloadButton!.setImage(UIImage.init(named: "download_button"), for: .normal)
        downloadButton!.addTarget(self, action: #selector(self.downloadPhoto), for: .touchUpInside)
        view.addSubview(downloadButton!)
        
        editButton = UIButton(frame: CGRect(x: downloadButton!.frame.minX - 50 - 40, y: ScreenHeight - 50 - 40, width: 40, height: 40))
        editButton!.setImage(UIImage.init(named: "edit_button"), for: .normal)
        editButton!.isEnabled = false
        editButton!.addTarget(self, action: #selector(self.editPhoto), for: .touchUpInside)
        view.addSubview(editButton!)
        
        shareButton = UIButton(frame: CGRect(x: downloadButton!.frame.maxX + 50, y: ScreenHeight - 50 - 40, width: 40, height: 40))
        shareButton!.setImage(UIImage.init(named: "share_button"), for: .normal)
        shareButton!.addTarget(self, action: #selector(self.sharePhoto), for: .touchUpInside)
        view.addSubview(shareButton!)
    }
    
    func refreshData() {
        indicatorView!.startAnimating()
        let parameters: Parameters = ["client_id": UnsplashClientId]
        Alamofire.request("https://api.unsplash.com/photos/", method: .get, parameters: parameters).responseJSON { (response) in
            self.indicatorView!.stopAnimating()
            if response.result.isSuccess {
                let photos: Array<APPhoto> = APPhoto.mj_objectArray(withKeyValuesArray: response.result.value!) as! Array<APPhoto>
                self.feedPhotos = photos
                if self.feedPhotos.count > 0 {
                    self.setBackBlurPhoto(with: URL(string: (self.feedPhotos.first?.urls?.regular)!)!)
                    self.photographerLabel!.attributedText = self.convert((self.feedPhotos.first?.user?.name)!)
                }
                self.photoCollectionView?.reloadData()
            } else {
                print("refresh data failed.")
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
        cell.setPhoto(with:URL(string: (feedPhotos[indexPath.item].urls?.regular)!)!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedPhotos.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let index: Int = Int(offset.x / ScreenWidth)
        if index != currentPhotoIndex {
            currentPhotoIndex = index
            let photo = feedPhotos[currentPhotoIndex]
            DispatchQueue.main.async {
                self.setBackBlurPhoto(with: (URL(string: (photo.urls?.regular)!))!)
                self.photographerLabel!.attributedText = self.convert((photo.user?.name)!)
            }
        }
    }
    
    func setBackBlurPhoto(with url: URL) {
        let backView = backBlurPhotoViews[1 - currentBackPhotoIndex]
        backView.sd_setImage(with: url) { (image, error, cacheType, url) in
            backView.addBlurEffect(50)
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.backBlurPhotoViews[self.currentBackPhotoIndex].alpha = 0
            self.backBlurPhotoViews[1 - self.currentBackPhotoIndex].alpha = 1
        })
        currentBackPhotoIndex = 1 - currentBackPhotoIndex
    }
    
    func convert(_ name: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: String.init(format: "powered by %@", name), attributes: [NSForegroundColorAttributeName:UIColor.white, NSFontAttributeName:UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)])
        attributedText.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFont(ofSize: 14), range: NSMakeRange(11, name.characters.count))
        return attributedText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
