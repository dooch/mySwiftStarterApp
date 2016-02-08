//
//  ViewController.swift
//  Oauth2Test
//
//  Created by Edwin Vermeer on 7/15/15.
//  Copyright (c) 2015 evict. All rights reserved.
//

import UIKit
import Alamofire

class InitialAuthViewController: UIViewController {
    
    
    @IBOutlet weak var result: UITextView!
    
    @IBAction func startWordpressOauth2Test(sender: AnyObject) {
    
   // @IBAction func startWordpressOauth2Test(sender: AnyObject) {
        self.result.text = ""
        UsingOauth2(wordpressOauth2Settings, performWithToken: { token in
            WordPressRequestConvertible.OAuthToken = token
            Alamofire.request(WordPressRequestConvertible.Me())
                .responseJSON(completionHandler: { (result) -> Void in
                    if let data = result.data {
                        let response = NSString(data: data, encoding: NSUTF8StringEncoding)
                        self.result.text = "\(response)"
                        print("JSON = \(response)")
                        
                    }
                })
            }, errorHandler: {
                print("Oauth2 failed")
        })
    }
    
    @IBAction func startGoogleOauth2Test(sender: AnyObject) {
        self.result.text = ""
        UsingOauth2(googleOauth2Settings, performWithToken: { token in
            GoogleRequestConvertible.OAuthToken = token
            Alamofire.request(GoogleRequestConvertible.Me())
                .responseJSON(completionHandler: { (result) -> Void in
                    if let data = result.data {
                        let response = NSString(data: data, encoding: NSUTF8StringEncoding)
                        self.result.text = "\(response)"
                        print("JSON = \(response)")
                        
                    }
                    
                })
            }, errorHandler: {
                print("Oauth2 failed")
        })
    }
    
    @IBAction func clearTokens(sender: AnyObject) {
    
   // @IBAction func clearTokens(sender: AnyObject) {
        Oauth2ClearTokensFromKeychain(wordpressOauth2Settings)
        Oauth2ClearTokensFromKeychain(googleOauth2Settings)
    }
}

//.responseObject { (result:Result<T>) -> Void in
//    self.handleResponse(result, completionHandler: completionHandler)




// Create your own clientID and clientSecret at http://streetartcritic.com/wp-admin
let wordpressOauth2Settings = Oauth2Settings(
    baseURL: "http://streetartcritic.com/wp-json/wp/v2",
    authorizeURL: "http://streetartcritic.com/oauth/authorize",
    tokenURL: "http://streetartcritic.com/oauth/token",
    redirectURL: "alamofireoauth2://wordpress/oauth_callback",
    clientID: "23tLRR0j01FtFioKXSM7m5k7UV4pG4",
    clientSecret: "1J8vuZmvinwYRcggWe8JluOFBJAG8g"
)


// Minimal Alamofire implementation. For more info see https://github.com/Alamofire/Alamofire#crud--authorization
public enum WordPressRequestConvertible: URLRequestConvertible {
    static var baseURLString: String? = wordpressOauth2Settings.baseURL
    static var OAuthToken: String?
    
    case Me()
    
    public var URLRequest: NSMutableURLRequest { get {
        let URL = NSURL(string: WordPressRequestConvertible.baseURLString!)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent("/posts"))
        mutableURLRequest.HTTPMethod = "GET"
        
        if let token = WordPressRequestConvertible.OAuthToken {
            mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        return mutableURLRequest
        }
    }
}




// Create your own clientID at https://console.developers.google.com/project (secret can be left blank!)
// For more info see https://developers.google.com/identity/protocols/OAuth2WebServer#handlingtheresponse
// And https://developers.google.com/+/web/api/rest/oauth
let googleOauth2Settings = Oauth2Settings(
    baseURL: "https://www.googleapis.com/plus/v1",
    authorizeURL: "https://accounts.google.com/o/oauth2/auth",
    tokenURL: "https://www.googleapis.com/oauth2/v3/token",
    redirectURL: "http://localhost",
    clientID: "618987844532-o5jrtm8hfl5vaehoa080nd3869o3uebu.apps.googleusercontent.com",
    clientSecret: "",
    scope: "profile"
)

// Minimal Alamofire implementation. For more info see https://github.com/Alamofire/Alamofire#crud--authorization
public enum GoogleRequestConvertible: URLRequestConvertible {
    static var baseURLString: String? = googleOauth2Settings.baseURL
    static var OAuthToken: String?
    
    case Me()
    
    public var URLRequest: NSMutableURLRequest {
        get  {
            let URL = NSURL(string: GoogleRequestConvertible.baseURLString!)!
            let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent("/people/me"))
            mutableURLRequest.HTTPMethod = "GET"
            
            if let token = GoogleRequestConvertible.OAuthToken {
                mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            
            return mutableURLRequest
        }
    }
}