//
//  AppDelegate.swift
//  Todoey
//
//  Created by Anthony Hall on 7/19/18.
//  Copyright © 2018 Anthony Hall. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        do {
            _ = try Realm()
        }catch{
            print("Error intailising new realm, \(error)")
        }
        
        
        return true
    }


     }




