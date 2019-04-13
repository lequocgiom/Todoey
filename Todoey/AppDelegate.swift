//
//  AppDelegate.swift
//  Todoey
//
//  Created by Le Trung on 4/8/19.
//  Copyright © 2019 Le Trung. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        
        do {
            _ = try Realm()
        }
        catch {
            print("Error initialising new realm, \(error)")
        }
        return true
    }
    

}

