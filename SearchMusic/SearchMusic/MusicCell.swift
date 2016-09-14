//
//  MusicCell.swift
//  SearchMusic
//
//  Created by Yiwei on 9/13/16.
//  Copyright © 2016 Elva. All rights reserved.
//

import UIKit

class MusicCell: UITableViewCell {

    @IBOutlet weak var albumImage: UIImageView!
   
    
    @IBOutlet weak var trackName: UILabel!
   
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var albumName: UILabel!

  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
