//AppDelegate.swift
/*
 * LKNotificationTutorial
 * Created by penumutchu.prasad@gmail.com on 09/08/18
 * Is a product created by abnboys
 * For the  in the LKNotificationTutorial
 
 * Here the permission is granted to this file with free of use anywhere in the IOS Projects.
 * Copyright © 2018 ABNBoys.com All rights reserved.
*/

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        requestPermissionWithCompletionHanlder(completion: nil)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {

    }

    
    private func requestPermissionWithCompletionHanlder(completion: ((Bool) -> ())?) {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge, .carPlay]) { (granted, error) in
            
            guard error == nil else {
                
                completion?(false)
                return
            }
            
            if granted {
                UNUserNotificationCenter.current().delegate = self
            }
            
            completion?(granted)
        }
        
    }
    
    private func setNotificationCategories() {
        
        let openAction = UNNotificationAction.init(identifier: "open", title: "Open", options: [.foreground,.authenticationRequired])
        
        let clearAction = UNNotificationAction.init(identifier: "clear", title: "Clear", options: [.destructive])
        
        let likeAction = UNNotificationAction.init(identifier: "like", title: "Like", options: [])
        
        let archiveAction = UNNotificationAction.init(identifier: "archive", title: "Archive", options: [.authenticationRequired])
        
        let addNoteAction = UNTextInputNotificationAction.init(identifier: "addNoteAction", title: "Add Note", options: [], textInputButtonTitle: "Add On", textInputPlaceholder: "Enter an event here")
        
        let timerCategory = UNNotificationCategory.init(identifier: "timerCategory", actions: [openAction, clearAction], intentIdentifiers: [], options: [])
        
        let calenderCategory = UNNotificationCategory.init(identifier: "calenderCategory", actions: [openAction, archiveAction, addNoteAction], intentIdentifiers: [], options: [])

        let locationCategory = UNNotificationCategory.init(identifier: "locationCategory", actions: [openAction, likeAction,archiveAction,clearAction], intentIdentifiers: [], options: [])

        
    }
    
    //For Time InterVal Notification
    func sendNotificationForTimer(withTimeInterval timeInterval: TimeInterval) {
        
        
        
    }
    
    //For Calender Notification
    func sendNotificationForCalender(withDate reminderDate: DateComponents) {
        
        
        
    }
    
    //For Calender Notification
    func sendNotificationForLocation() {
        
        
        
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        
        completionHandler()
    }
    
}

