
import UIKit

var articles = [Article]()

class IGNService {
    func loadVideos(table: UITableView!) {
        let requestURL: NSURL = NSURL(string: "https://ign-apis.herokuapp.com/videos?startIndex=30&6count=5")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                do{
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    
                    if let data = json["data"] as? [[String: AnyObject]] {
                        
                        for article in data {
                            var newVideo = Video()
                            
                            if let thumbnail = article["thumbnail"] as? String {
                                newVideo.thumbnailURL = thumbnail
                            }
                            if let headline = article["metadata"]!["title"] as? String {
                                newVideo.headline = headline
                            }
                            if let state = article["metadata"]!["state"] as? String {
                                newVideo.state = state
                            }
                            if let slug = article["metadata"]!["slug"] as? String {
                                newVideo.slug = slug
                            }
                            if let subHeadline = article["metadata"]!["description"] as? String {
                                newVideo.subHeadline = subHeadline
                            }
                            if let publishDate = article["metadata"]!["publishDate"] as? String {
                                newVideo.publishDate = publishDate
                            }
                            if let name = article["metadata"]!["name"] as? String {
                                newVideo.name = name
                            }
                            if let longTitle = article["metadata"]!["longTitle"] as? String {
                                newVideo.longTitle = longTitle
                            }
                            if let duration = article["metadata"]!["duration"] as? String {
                                newVideo.duration = duration
                            }
                            if let url = article["metadata"]!["url"] as? String {
                                newVideo.URL = url
                            }
                            if let ageGate = article["metadata"]!["ageGate"] as? String {
                                newVideo.ageGate = ageGate
                            }
                            if let classification = article["metadata"]!["classification"] as? String {
                                newVideo.classification = classification
                            }
                            if let subClassification = article["metadata"]!["subClassification"] as? String {
                                newVideo.subClassification = subClassification
                            }
                            if let noads = article["metadata"]!["noads"] as? Bool {
                                newVideo.noads = noads
                            }
                            if let prime = article["metadata"]!["prime"] as? Bool {
                                newVideo.prime = prime
                            }
                            if let subscription = article["metadata"]!["subscription"] as? Bool {
                                newVideo.subscription = subscription
                            }
                            if let downloadable = article["metadata"]!["downloadable"] as? Bool {
                                newVideo.downloadable = downloadable
                            }
                            if let origin = article["metadata"]!["origin"] as? String {
                                newVideo.origin = origin
                            }
                            if let genre = article["metadata"]!["genre"] as? String {
                                newVideo.genre = genre
                            }

                            articles.append(newVideo)
                        }
                        
                        table.reloadData()
                    }
                    
                } catch {
                    print("Error with Json: \(error)")
                }
            }
            
        }
        task.resume()
    }
    
    func loadArticles(table: UITableView!) {
        let requestURL: NSURL = NSURL(string: "https://ign-apis.herokuapp.com/articles?startIndex=30&6count=5")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                do{
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    
                    if let data = json["data"] as? [[String: AnyObject]] {
                        
                        for article in data {
                            var newArticle = Article()
                            
                            if let thumbnail = article["thumbnail"] as? String {
                                newArticle.thumbnailURL = thumbnail
                            }
                            if let headline = article["metadata"]!["headline"] as? String {
                                newArticle.headline = headline
                            }
                            if let state = article["metadata"]!["state"] as? String {
                                newArticle.state = state
                            }
                            if let slug = article["metadata"]!["slug"] as? String {
                                newArticle.slug = slug
                            }
                            if let subHeadline = article["metadata"]!["subHeadline"] as? String {
                                newArticle.subHeadline = subHeadline
                            }
                            if let publishDate = article["metadata"]!["publishDate"] as? String {
                                newArticle.publishDate = publishDate
                            }
                            if let articleType = article["metadata"]!["articleType"] as? String {
                                newArticle.articleType = articleType
                            }
                        
                            articles.append(newArticle)
                        }
                        
                        table.reloadData()
                    }
                    
                } catch {
                    print("Error with Json: \(error)")
                }
            }
            
        }
        task.resume()
    }
}

class Article {
    var thumbnailURL: String = ""
    var state: String = ""
    var articleType: String = ""
    var publishDate: String = ""
    var headline: String = "" //same as title from video json
    var subHeadline: String = "" //same as description from video json
    var slug: String = ""
    var networks: [String] = [String]()
    
    func makeURLString()->String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        let date = dateFormatter.dateFromString(publishDate)!
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        
        let year =  components.year
        let month = components.month
        let day = components.day
        var str = "http://www.ign.com/articles/" + year.description + "/"

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
    
    func generateTimeSincePublishDate()->String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        let datePublish = dateFormatter.dateFromString(publishDate)!
        let calendarPublish = NSCalendar.currentCalendar()
        let componentsPublish = calendarPublish.components([.Day , .Month , .Year], fromDate: datePublish)
        
        let dateCurrent = NSDate()
        let calendarCurrent = NSCalendar.currentCalendar()
        let componentsCurrent = calendarCurrent.components([.Day , .Month , .Year], fromDate: dateCurrent)
        
        if componentsCurrent.day == componentsPublish.day {
            return String(componentsCurrent.hour - componentsPublish.hour) + " hours ago"
        } else if componentsCurrent.month == componentsPublish.month {
            return String(componentsCurrent.day - componentsPublish.day) + " days ago"
        } else if componentsCurrent.year == componentsPublish.year {
            return String(componentsCurrent.month - componentsPublish.month) + " months ago"
        }
        
        return String(componentsCurrent.year - componentsPublish.year) + " years ago"
    }
    
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
        previewImage.frame = CGRect(x: 0, y: 60, width: frame.width, height: 160)
        
        //add subviews
        cell.addSubview(publishLabel)
        cell.addSubview(previewImage)
        cell.addSubview(headlineLabel)
        cell.backgroundColor = UIColor(red: 30.0 / 255.0,green: 30.0 / 255.0,blue: 30.0 / 255.0,alpha: 1)
        
        return cell
    }
}

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
    
    override func makeURLString() -> String {
        return self.URL
    }
}




