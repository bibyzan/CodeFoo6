import UIKit

//global array of articles used all around the app
var articles = [Article]()

//This class pulls the video and article json from the web and fills the article array
class IGNService {
    func loadVideos(table: UITableView!) {
        //connect to http
        let requestURL: NSURL = NSURL(string: "https://ign-apis.herokuapp.com/videos?startIndex=30&6count=5")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                do{
                    //parse json
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    
                    if let data = json["data"] as? [[String: AnyObject]] {
                        
                        for article in data {
                            //fill the article array with all videos pulled from json
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
                            
                            print(newVideo)
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
        //connect to http
        let requestURL: NSURL = NSURL(string: "https://ign-apis.herokuapp.com/articles?startIndex=30&6count=5")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                do{
                    //parse json
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    
                    if let data = json["data"] as? [[String: AnyObject]] {
                        
                        for article in data {
                            //add all articles to article array from json
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
                        
                            print(newArticle)
                            articles.append(newArticle)
                        }
                        
                    }
                    
                } catch {
                    print("Error with Json: \(error)")
                }
            }
            
        }
        task.resume()
    }
}




