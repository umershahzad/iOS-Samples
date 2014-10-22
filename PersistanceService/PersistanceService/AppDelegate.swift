//
//  AppDelegate.swift
//  PersistanceService
//
//  Created by Vyacheslav Vdovichenko on 10/16/14.
//  Copyright (c) 2014 BACKENDLESS.COM. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let APP_ID = ""
    let SECRET_KEY = ""
    let VERSION_NUM = "v1"
    
    var backendless = Backendless.sharedInstance()

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        NSLog("!!! APP IS LAUNCHED !!!")
        
        // Override point for customization after application launch.
        
        //DebLog.setIsActive(true)
        
        backendless.initApp(APP_ID, secret:SECRET_KEY, version:VERSION_NUM)
        //backendless.hostURL = "http://api.backendless.com"
        backendless.setThrowException(false)
        
        // --------------- UserService -------------------------------------
        
        // - user login
        var user = backendless.userService.login("bob3@foo.com", password:"bob3")
        NSLog("LOGGINED USER: %@", user.description)
        //
        
        /* - array
        //var firm = ["Apple", "Google"]
        var firm : NSArray = ["Apple", "Google"]
        user.setProperty("firms", object:firm)
        */
        
        /* - dictionary
        var oss = ["iOS":"Apple", "Android":"Google"]
        user.setProperty("os", object: oss)
        */
        
        // - user update
        var counter: AnyObject! = user.getProperty("counter")
        user.setProperty("counter", object: counter)
        
        user = backendless.userService.update(user)
        NSLog("UPDATED USER: %@", user.description)
        //
        
        // -------------- PersistenceService -------------------------------
        
        /*
        var obj = PersistentObjectQB()
        var result : AnyObject = backendless.persistenceService.save(obj)
        
        if (result is PersistentObjectQB) {
        var res : PersistentObjectQB = result as PersistentObjectQB
        }
        
        if (result is Fault) {
        var fault : Fault = result as Fault
        }
        */
        
        var result : AnyObject
        var fault : Fault?
        
        /*
        // - sync method with fault as reference
        var item : OrderItem = backendless.persistenceService.save(OrderItem(), error: &fault) as OrderItem
        if (fault == nil) {
            var obj : AnyObject = backendless.persistenceService.findById("OrderItem", sid: item.objectId)
            if (obj is OrderItem) {
                item = obj as OrderItem
                println("OrderItem: \(item.itemName) <\(item.objectId)>")
            }
            else {
                println("\nFAULT (0): \(fault!.description)")
           }
        }
        else {
            println("\nFAULT (0): \(fault!.description)")
        }
        */
        
        /* - sorting for the selected columns (ascending and descending)
        
        NSLog(" ------------------ TEST: sorting for the selected columns ---------------------------------")
        
        var query1 : QueryOptions = QueryOptions()
        query1.sortBy = ["name", "objectId"]
        var dataQuery1 : BackendlessDataQuery = BackendlessDataQuery()
        dataQuery1.queryOptions = query1
        
        result = backendless.persistenceService.find(Order().ofClass(), dataQuery:dataQuery1)
        if (result is BackendlessCollection) {
            var bc1 : BackendlessCollection = result as BackendlessCollection
            for order : Order in bc1.data as [Order] {
                println("OrderItem: \(order.name) <\(order.objectId)>")
            }
        }
        if (result is Fault) {
            println("\nFAULT (0): \(fault!.description)")
        }
        
        */
        // - sync method with class instance/fault as return
        result = backendless.persistenceService.save(Weather())
        if (result is Weather) {
            var obj : AnyObject = backendless.persistenceService.findById("Weather", sid:(result as Weather).objectId)
            if (obj is Weather) {
                var obj1 = obj as Weather
                println("\nWeather (1): \(obj1.description)")
            }
        }
        if (result is Fault) {
            println("\nFAULT (1): \(fault!.description)")
        }
        //
        
        //
        // - sync method with fault as reference
        var weather : Weather = backendless.persistenceService.save(Weather(), error: &fault) as Weather
        if (fault == nil) {
            var obj : AnyObject = backendless.persistenceService.findById("Weather", sid: weather.objectId)
            if (obj is Weather) {
                var obj1 = obj as Weather
                println("\nWeather (2): \(obj1.description)")
            }
        }
        else {
            println("\nFAULT (2): \(fault!.description)")
        }
        //
        
        
        // - async method with block-based callbacks
        backendless.persistenceService.save(
            Weather(),
            response: { (var result : AnyObject!) -> () in
                var obj : AnyObject = self.backendless.persistenceService.findById("Weather", sid: (result as Weather).objectId)
                if (obj is Weather) {
                    var obj1 = obj as Weather
                    println("\nWeather (3): \(obj1.description)")
                }
            },
            error: { (var fault : Fault!) -> () in
                println("\nFAULT (3): \(fault!.description)")
            }
        )
        //
        
        // - dictionary
        var os = ["iOS":"Apple", "android":"Google"]
        result = backendless.persistenceService.save("MobileOS", entity:os, error: &fault)
        if (fault != nil) {
            println("\nFAULT (4): \(fault!.description)")
        }
        //

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

