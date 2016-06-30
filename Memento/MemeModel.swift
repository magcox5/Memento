//
//  MemeModel.swift
//  MemeMento
//
//  Created by Molly Cox on 5/18/16.
//  Copyright © 2016 Molly Cox. All rights reserved.
//
//  Thanks to Udacity coach Owen for help with meme array and
//  the post on implementing the singleton pattern
import UIKit

struct Meme {
    var topText: String?
    var bottomText: String?
    var originalImage: UIImage?
    var memeImage: UIImage!
}


class MemesList {
    var memes: [Meme] = []

    class var sharedInstance : MemesList {
        struct Static {
            static let instance: MemesList = MemesList()
        }
        return Static.instance
    }
}
