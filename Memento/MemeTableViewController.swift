//
//  MemeTableViewController.swift
//  MemeMento
//
//  Created by Molly Cox on 6/19/16.
//  Copyright © 2016 Molly Cox. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {

    // Get memes from MemesList
    let memesList = MemesList.sharedInstance
    
    @IBOutlet var memeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memeTableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = false
        memeTableView.reloadData()
    }
    

    // MARK: Table View Data Source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memesList.memes.count
  }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let memeCell = tableView.dequeueReusableCellWithIdentifier("memeCell")!  as! MemeTableViewCell
        let currentMeme = memesList.memes[indexPath.row]
      
        // Set the labels and image
        memeCell.topText?.text = currentMeme.topText
        memeCell.bottomText?.text = currentMeme.bottomText
        memeCell.imageView?.image = currentMeme.memeImage

        // Set image size for cell
        let itemSize = CGSizeMake(115,115)
        UIGraphicsBeginImageContextWithOptions(itemSize, false, UIScreen.mainScreen().scale)
        let imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height)
        memeCell.imageView?.image!.drawInRect(imageRect)
        memeCell.imageView?.image! = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return memeCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.detailMeme = memesList.memes[indexPath.row]
      self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            memesList.memes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }

}
