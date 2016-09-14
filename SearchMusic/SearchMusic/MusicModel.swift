//
//  MusicModel.swift
//  SearchMusic
//
//  Created by Yiwei on 9/13/16.
//  Copyright © 2016 Elva. All rights reserved.
//

import UIKit

class MusicModel: NSObject
{
    var trackName:String?
    var artistName: String?
    var collectionName:String?
    var artworkUrl100:String?
    
    init(dict:[String:AnyObject])
    {
        super.init()
        setValuesForKeysWithDictionary(dict)
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    
    }

}
