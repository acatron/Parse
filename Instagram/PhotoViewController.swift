//
//  PhotoViewController.swift
//  Instagram
//
//  Created by Aurielle on 3/2/16.
//  Copyright © 2016 Aurielle. All rights reserved.
//

import UIKit
import Parse
import DGElasticPullToRefresh

class PhotoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var photoData : [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor.whiteColor()
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            self!.retrieve()
            self?.tableView.dg_stopLoading()
            }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor(UIColor(red: 184/255.0, green: 113/255.0, blue: 45/255.0, alpha: 1.0))
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
        
        tableView.rowHeight = 320
        
        
        retrieve()
        
    }
    
    func retrieve() {
//        print("here")
        let query = PFQuery(className: "UserMedia")
        query.orderByDescending("createdAt")           
        query.findObjectsInBackgroundWithBlock { (object:[PFObject]?, error:NSError?) -> Void in
            if nil != object && object?.count != 0{
                self.photoData = object!
//                print(object)
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoTableViewCell") as? PhotoTableViewCell
        let userMedia = self.photoData[indexPath.section]
        let media = userMedia.objectForKey("media") as! PFFile
        _ = userMedia.updatedAt
        cell!.insta_photo.image = UIImage(named: "icon")
        media.getDataInBackgroundWithBlock({ (data:NSData?, error:NSError?) -> Void in
            if data != nil {
                cell!.insta_photo.image = UIImage(data: data!)
            }
        })
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        profileView.layer.borderWidth = 1;
        
        //         Use the section number to get the right URL
        //         profileView.setImageWithURL(...)
        
        // Add a UILabel for the username here
        let label = UILabel(frame: CGRect(x: 0, y: 2, width: 320, height: 50))
        let label2 = UILabel(frame: CGRect(x: 0, y: -5, width: 320, height: 50))
        label2.textAlignment = NSTextAlignment.Center
        
//        label.center = CGPointMake(160, 284)
        label.textAlignment = NSTextAlignment.Center
        //        let user = feed![section]["user"] as! NSDictionary
        //
        //        if let name = user["username"] as? String {
        //            label.text = name
        //        } else {
        //            label.text = "no name"
        //        }
        print(section)
        let userMedia = self.photoData[section]
        
        print(userMedia)
        
        let media = userMedia.objectForKey("media") as! PFFile
        let author = userMedia.objectForKey("username1") as! String
        label.text = author
        
        profileView.image = UIImage(named: "icon")
        
        media.getDataInBackgroundWithBlock({ (data:NSData?, error:NSError?) -> Void in
            if data != nil {
                
                profileView.image = UIImage(data: data!)
            }
        })
        
        headerView.addSubview(label)
        headerView.addSubview(profileView)
        
        return headerView
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.photoData.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}


extension UIScrollView {
    // to fix a problem where all the constraints of the tableview
    // are deleted
    func dg_stopScrollingAnimation() {}
}
