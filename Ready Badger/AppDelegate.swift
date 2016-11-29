//
//  AppDelegate.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/2/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let cancelButtonAttributes: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes as? [String : AnyObject], for: UIControlState.normal)
        
        NetworkQueue.shared.addOperation(AllCountyOperation(withRequest: AllCountyRequest()))
        NetworkQueue.shared.addOperation(DisasterResourceOperation(withRequest: DisasterResourceRequest()))
        
//        let url = URL(string: "http://imageserver.appfactoryuwp.com/images")
//        var urlRequest = URLRequest(url: url!)
//        urlRequest.httpMethod = "POST"
//        urlRequest.allHTTPHeaderFields = ["X-API-KEY": "c7crds7c3b2xqzdx0g4dnnld2tvr76re", "Accept": "applications/json", "Content-Type": "application/json"]
//        let params = ["title": "test" as AnyObject, "description": "Test Description" as AnyObject, "albumid": 10 as  AnyObject] as [String: AnyObject]
//        urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
//        print(NSString(data: urlRequest.httpBody!, encoding: String.Encoding.utf8.rawValue))
//        let urlSession = URLSession.shared
//        let task = urlSession.dataTask(with: urlRequest, completionHandler: {(data, error, other) in
//            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
//        })
//        task.resume()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

