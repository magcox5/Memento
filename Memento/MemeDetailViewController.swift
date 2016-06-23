//
//  MemeDetailViewController.swift
//  MemeMento
//
//  Created by Molly Cox on 6/20/16.
//  Copyright © 2016 Molly Cox. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var detailMeme: Meme!
    
    @IBOutlet weak var memeImageAndText: UIImageView!
    
//    @IBAction func backToSentMemes(sender: AnyObject) {
//        dismissViewControllerAnimated(true, completion: nil)
//    }
    
    override func viewWillAppear(animated: Bool) {

        super.viewWillAppear(animated)

        self.tabBarController?.tabBar.hidden = true
        self.memeImageAndText!.image = detailMeme.memeImage
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }


}
