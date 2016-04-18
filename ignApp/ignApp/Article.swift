//
//  Article.swift
//  ignApp
//
//  Created by Ben Rasmussen on 4/18/16.
//  Copyright © 2016 Ben Rasmussen. All rights reserved.
//  This file contains the 2 related classes Video and Article that are filled from a json string pulled from the web
//

import UIKit


//class containing all the data pulled from json for an online article
class Article {
    var thumbnailURL: String = ""
    var state: String = ""
    var articleType: String = ""
    var publishDate: String = ""
    var headline: String = "" //same as title from video json
    var subHeadline: String = "" //same as description from video json
    var slug: String = ""
    
    //build url to the article from the date and the slug
    func makeURLString()->String {
        //parse date
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        let date = dateFormatter.dateFromString(publishDate)!
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        //build url string
        let year =  components.year
        let month = components.month
        let day = components.day
        var str = "http://www.ign.com/articles/" + year.description + "/"
        
        //account for 0's before single digit numbers
        if month < 10 {
            str += "0"
        }
        str += month.description + "/"
        if day < 9 {
            str += "0"
        }
        str += day.description + "/" + slug
        
        return str
    }
    
    //Take the systems current time and generate a string telling how long ago that was
    func generateTimeSincePublishDate()->String {
        //parse the date from the json
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        let datePublish = dateFormatter.dateFromString(publishDate)!
        let calendarPublish = NSCalendar.currentCalendar()
        let componentsPublish = calendarPublish.components([.Minute ,.Hour ,.Day , .Month , .Year], fromDate: datePublish)
        
        let dateCurrent = NSDate()
        let calendarCurrent = NSCalendar.currentCalendar()
        let componentsCurrent = calendarCurrent.components([.Minute , .Hour , .Day , .Month , .Year], fromDate: dateCurrent)
        
        let minutesPast = String(componentsCurrent.minute - componentsPublish.minute)
        let hoursPast = String(componentsCurrent.hour - componentsPublish.hour)
        let daysPast = String(componentsCurrent.day - componentsPublish.day)
        let monthsPast = String(componentsCurrent.month - componentsPublish.month)
        let yearsPast = String(componentsCurrent.year - componentsPublish.year)
        
        //generate string for different cases depending on how long ago it was
        if componentsCurrent.hour == componentsPublish.hour {
            return minutesPast + " minutes ago"
        } else if componentsCurrent.day == componentsPublish.day {
            return hoursPast + " hours ago"
        } else if componentsCurrent.month == componentsPublish.month {
            return daysPast + " days ago"
        } else if componentsCurrent.year == componentsPublish.year {
            return monthsPast + " months ago"
        }
        
        return yearsPast + " years ago"
    }
    
    //this code runs and formats an article or video nicely for every article displayed
    func makeTableCell(frame: CGRect)->UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Default")
        
        //put space between cells
        let spacePath = UIBezierPath()
        spacePath.moveToPoint(CGPoint(x: 0, y: 0))
        spacePath.addLineToPoint(CGPoint(x: frame.width,y: 0))
        spacePath.addLineToPoint(CGPoint(x: frame.width, y: 10))
        spacePath.addLineToPoint(CGPoint(x: 0,y: 10))
        spacePath.addLineToPoint(CGPoint(x: 0, y: 0))
        spacePath.closePath()
        let spaceLayer = CAShapeLayer()
        spaceLayer.path = spacePath.CGPath
        spaceLayer.fillColor = UIColor.blackColor().CGColor
        cell.layer.addSublayer(spaceLayer)
        
        //add red line above cell
        let redLinePath = UIBezierPath()
        redLinePath.moveToPoint(CGPoint(x: 0, y: 9))
        redLinePath.addLineToPoint(CGPoint(x: frame.width * 0.25, y: 9.0))
        redLinePath.addLineToPoint(CGPoint(x: frame.width * 0.25, y: 10.0))
        redLinePath.addLineToPoint(CGPoint(x: 0, y: 10))
        redLinePath.closePath()
        let redLayer = CAShapeLayer()
        redLayer.path = redLinePath.CGPath
        redLayer.fillColor = UIColor.redColor().CGColor
        cell.layer.addSublayer(redLayer)
        
        //make published at label
        let publishLabel = UILabel()
        publishLabel.font = UIFont(name: "Futura-Medium", size: 8)
        publishLabel.text = self.generateTimeSincePublishDate().uppercaseString
        publishLabel.textColor = UIColor.darkGrayColor()
        publishLabel.frame = CGRect(x: 5, y: 15, width: frame.width, height: 10)
        
        //make headline label
        let headlineLabel = UILabel()
        headlineLabel.font = UIFont(name: "Futura-Medium", size: 10)
        headlineLabel.text = headline.uppercaseString
        headlineLabel.textColor = UIColor.whiteColor()
        headlineLabel.frame = CGRect(x: 5, y: 25, width: frame.width, height: 20)
        
        //instantiate and pull thumbnails from web
        let previewImage = UIImageView()
        let url = NSURL(string: thumbnailURL)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let data = NSData(contentsOfURL: url!)
            dispatch_async(dispatch_get_main_queue(), {
                previewImage.image = UIImage(data: data!)
            });
        }
        previewImage.frame = CGRect(x: 0, y: 60, width: frame.width, height: 180)
        
        //add subviews
        cell.addSubview(publishLabel)
        cell.addSubview(previewImage)
        cell.addSubview(headlineLabel)
        cell.backgroundColor = UIColor(red: 30.0 / 255.0,green: 30.0 / 255.0,blue: 30.0 / 255.0,alpha: 1)
        
        return cell
    }
}

//inherits from article, and adds extra fields that the article doesn't have from json
class Video: Article {
    var name: String = ""
    var longTitle: String = ""
    var duration: String = ""
    var URL: String = ""
    var ageGate: String = ""
    var classification: String = ""
    var subClassification: String = ""
    var noads: Bool = false
    var prime: Bool = false
    var subscription: Bool = false
    var downloadable: Bool = false
    var origin: String = ""
    var genre: String = ""
    
    //since the url is just given for videos, return that instead of generating it
    override func makeURLString() -> String {
        return self.URL
    }
}
