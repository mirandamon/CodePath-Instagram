//
//  PhotosViewController.swift
//  Instagram
//
//  Created by Nathan Miranda on 1/28/16.
//  Copyright © 2016 Miraen. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var instagramTableView: UITableView!
    var photos: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instagramTableView.dataSource = self
        instagramTableView.delegate = self
        instagramTableView.rowHeight = 320;
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            self.photos = responseDictionary["data"] as! [NSDictionary]
                            //NSLog("response: \(self.photos)")
                            self.instagramTableView.reloadData()
                    }
                }
        });
        task.resume()

        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let photos = photos {
            return photos.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.miraen.instagramTableViewCell", forIndexPath: indexPath) as! instagramTableViewCell
        let photo = photos![indexPath.row]
        let photoPath = photo["images"]!["standard_resolution"]!!["url"] as! String
        let username = photo["user"]!["username"]
        cell.usernameLabel.text = username as! String
        //"http://vignette4.wikia.nocookie.net/theuncledolanshow/images/9/95/Spoderman.gif/revision/latest?cb=20130403143047"
        //NSLog("response: \(self.photos)")
        let imageUrl = NSURLRequest(URL: NSURL(string: photoPath)!)
        cell.instagramImageView.setImageWithURLRequest(
            imageUrl,
            placeholderImage: nil,
            success: { (imageUrl, imageResponse, image) -> Void in
                if imageResponse != nil {
                    //print("Image was NOT cached, fade in image")
                    cell.instagramImageView.alpha = 0.0
                    cell.instagramImageView.image = image
                    UIView.animateWithDuration(0.3, animations: {() -> Void in
                        cell.instagramImageView.alpha = 1.0
                    })
                } else {
                    //print ("Image was cached so just updated the image")
                    cell.instagramImageView.image = image
                }
            },
            failure: { (imageUrl, imageResponse, error) -> Void in
                print ("Failure to fetch image")
        })
        return cell
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
