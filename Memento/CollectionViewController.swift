//
//  CollectionViewController.swift
//  MemeMento
//
//  Created by Molly Cox on 6/19/16.
//  Copyright © 2016 Molly Cox. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
//    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // Get memes from memes array
    var myMemes: [Meme] = []
    
    @IBOutlet var memeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let space: CGFloat = 0.75
//        let dimensionWidth = (view.frame.size.width - (2 * space)) / 3.0
//        //      let dimensionHeight = (view.frame.size.height - (2 * space)) / 3.0
//        
//        flowLayout.minimumInteritemSpacing = space
//        flowLayout.minimumLineSpacing = space * 4
//        flowLayout.itemSize = CGSizeMake(dimensionWidth, dimensionWidth)
//        //       flowLayout.itemSize = CGSizeMake(100,100)
        
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = false
        myMemes = memes
        memeCollectionView.reloadData()
        
    }
 
    // MARK: Collection View Data Source

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.myMemes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let currentMeme = self.myMemes[indexPath.row]
        
        // Set the image 
        cell.memeImage?.image = currentMeme.originalImage
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.memeImageAndText.image = self.myMemes[indexPath.row].memeImage
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    

}
