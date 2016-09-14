//
//  LyricViewController.swift
//  SearchMusic
//
//  Created by Yiwei on 9/13/16.
//  Copyright © 2016 Elva. All rights reserved.
//

import UIKit

class LyricViewController: UIViewController
{
   
    @IBOutlet weak var albumImage: UIImageView!
    
    @IBOutlet weak var trackName: UILabel!
    
    @IBOutlet weak var albumName: UILabel!
    
    @IBOutlet weak var ArtistName: UILabel!
    
    @IBOutlet weak var LyricLabel: UILabel!
    
    
 
    var detail: MusicModel?
    override func viewDidLoad()
    {
        self.trackName.text = detail?.trackName
        self.albumName.text = detail?.collectionName
        self.ArtistName.text = detail?.artistName
       
        
        let imageURL = NSURL(string:detail!.artworkUrl100!)
        self.albumImage!.sd_setImageWithURL(imageURL, placeholderImage: UIImage(named: "placeholder"))
        
        let manager = AFHTTPSessionManager()

        
       manager.responseSerializer.acceptableContentTypes = NSSet(objects:"text/html; charset=UTF-8") as? Set<String>
    //   manager.responseSerializer = AFJSONResponseSerializer.init(readingOptions: NSJSONReadingOptions.AllowFragments)
        manager.responseSerializer = AFHTTPResponseSerializer()
        let url = "http://lyrics.wikia.com/api.php"
       // let strurl = url.dataUsingEncoding(NSUTF8StringEncoding)
        let parameters = NSMutableDictionary()
        parameters["func"] = "getSong"
        parameters["artist"] = detail!.artistName
        parameters["song"] = detail!.trackName
        parameters["fmt"] = "json"
        
        manager.GET(url, parameters: parameters, progress: { (progress) in
              // print("\(progress)")
            }, success: { (dataTask, object) in
                 print("success")
             //   print(object!["lyrics"])
                if(object!["lyrics"] == nil)
                {
                    self.LyricLabel.text = String("There is no lyric availble")
                }
                else{
                    self.LyricLabel.text = String(format: "Lyric \n %@", "\(object!["lyrics"])")
                }
                           }) { (dataTask, error) in
                print("\(error)")
        }
        
    }
    
    

}
