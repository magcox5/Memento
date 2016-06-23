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
        
        let memeCell = tableView.dequeueReusableCellWithIdentifier("memeCell")!
        let currentMeme = memesList.memes[indexPath.row]
      
        // Set the name and image
        memeCell.textLabel?.text = currentMeme.topText
        memeCell.imageView?.image = currentMeme.originalImage
        
        // If the cell has a detail label, we will put the evil scheme in.
        if let detailTextLabel = memeCell.detailTextLabel {
            detailTextLabel.text = currentMeme.bottomText
        }
        
        return memeCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.detailMeme = memesList.memes[indexPath.row]
      self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    


}
