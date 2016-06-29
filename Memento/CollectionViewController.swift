//
//  CollectionViewController.swift
//  MemeMento
//
//  Created by Molly Cox on 6/19/16.
//  Copyright © 2016 Molly Cox. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // Get memes from memes memesList
    let memesList = MemesList.sharedInstance
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet var memeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memeCollectionView.reloadData()
        
        let space: CGFloat = 1.5
        let width: CGFloat = 320.0
        let height: CGFloat = 568.0
        
        let dimension:CGFloat = width >= height ? (width - (5 * space)) / 6.0 :  (width - (2 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space * 4
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = false
        memeCollectionView.reloadData()
        
    }
 
    // MARK: Collection View Data Source

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memesList.memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let memeCell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let currentMeme = memesList.memes[indexPath.row]
      
        // Set the image
        memeCell.memeImage?.image = currentMeme.memeImage
        return memeCell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.detailMeme = memesList.memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
//    // MARK: - UICollectionViewFlowLayout
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let picDimension = self.view.frame.size.width / 2.0
//        return CGSizeMake(picDimension, picDimension)
//    }
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//        let leftRightInset = self.view.frame.size.width / 40.0
//        return UIEdgeInsetsMake(0, leftRightInset, 0, leftRightInset)
//    }
//
}
