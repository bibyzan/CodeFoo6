//
//  ViewController.swift
//  ignApp
//
//  Created by Ben Rasmussen on 4/16/16.
//  Copyright © 2016 Ben Rasmussen. All rights reserved.
//  Class containing the code that is ran for the main article list view
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tblArticles: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //create service and pull json
        let service = IGNService()
        service.loadArticles(tblArticles)
        service.loadVideos(tblArticles)
    }
    
    
    
    //changes status bar color to white
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    //adjusts each cell height
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 240.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //tell how many cells are needed
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int)-> Int {
        return articles.count
    }
    
    //generate cells from the article class
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return articles[indexPath.row].makeTableCell(self.view.frame)
    }
    
    //opens a web view when articles are tapped
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        currentURL = articles[indexPath.row].makeURLString()
        currentArticleName = articles[indexPath.row].headline
        let controller = storyboard?.instantiateViewControllerWithIdentifier("WebViewController") as! WebViewController
        presentViewController(controller, animated: true, completion: nil)
    }
}

