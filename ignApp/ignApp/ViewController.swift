//
//  ViewController.swift
//  ignApp
//
//  Created by Ben Rasmussen on 4/16/16.
//  Copyright © 2016 Ben Rasmussen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tblArticles: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let service = IGNService()
        service.loadArticles(tblArticles)
        service.loadVideos(tblArticles)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 220.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int)-> Int {
        return articles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return articles[indexPath.row].makeTableCell(self.view.frame)
    }
    

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        currentURL = articles[indexPath.row].makeURLString()
        let controller = storyboard?.instantiateViewControllerWithIdentifier("WebViewController") as! WebViewController
        presentViewController(controller, animated: true, completion: nil)
    }
}

