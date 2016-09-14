//
//  HomeViewController.swift
//  SearchMusic
//
//  Created by Yiwei on 9/13/16.
//  Copyright © 2016 Elva. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController
{

    
    var dataList:[MusicModel]?
    let searchController = UISearchController(searchResultsController: nil)
    var filtered = [MusicModel]()
    
    override func viewDidLoad() {
         dataDownloading()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    
    func dataDownloading()
    {
        let url = NSURL(string: "https://itunes.apple.com/search?term=tom+waits")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!)
        { (data, response, error) in
            if(error == nil)
            {
                let dictArray = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves)
                guard let resultArray = dictArray!["results"]as? NSArray else{
                    print("no result")
                    return
                }
                var models = [MusicModel]()
                for model in resultArray
                {
                    let info = MusicModel(dict: model as! [String : AnyObject])
                    models.append(info)
                    
                    
                }
                self.dataList = models
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
            
        }
        task.resume()
        
    }
    
    func filterContentForSearchText(searchText:String, scope: String = "All")
    {
        filtered = dataList!.filter{ item in
        return item.trackName!.lowercaseString.containsString(searchText.lowercaseString)
        
        }
        tableView.reloadData()
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != ""
        {
            return filtered.count
        }
        
        
        return self.dataList?.count ?? 0
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(90)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell",forIndexPath: indexPath) as! MusicCell
    
        var data:MusicModel
        if searchController.active && searchController.searchBar.text != ""
        {
           data = self.filtered[indexPath.row]
        }
        else{
             data = self.dataList![indexPath.row]
        }

        cell.trackName.text = data.trackName
        cell.artistName.text = data.artistName
        cell.albumName.text = data.collectionName
        if let url = data.artworkUrl100
        {
            let imageURL = NSURL(string:url)
            cell.albumImage!.sd_setImageWithURL(imageURL, placeholderImage: UIImage(named: "placeholder"))
        }
        
        return cell    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detail"
        {
            if let indexPath = tableView.indexPathForSelectedRow
            {
                let detailInfo:MusicModel
                if searchController.active && searchController.searchBar.text != ""
                {
                    detailInfo = self.filtered[indexPath.row]
                }
                else{
                    detailInfo = self.dataList![indexPath.row]
                }

                let destinationController = segue.destinationViewController as! LyricViewController
        
                destinationController.detail = detailInfo
             
            }
        }

    }

}

extension HomeViewController: UISearchResultsUpdating
{
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
