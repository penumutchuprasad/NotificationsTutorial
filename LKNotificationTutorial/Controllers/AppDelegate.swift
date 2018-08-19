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
        
        CLService.shared.requestLocationAuthorization()
        NotificationCenter.default.addObserver(self, selector: #selector(sendNotificationForLocation), name: Notification.Name.init("LocationCaptured"), object: nil)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(_ application: UIApplication) {

    }
    
    class func getAppDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    
    private func requestPermissionWithCompletionHanlder(completion: ((Bool) -> ())?) {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge, .carPlay]) { (granted, error) in
            
            guard error == nil else {
                
                completion?(false)
                return
            }
            
            if granted {
                UNUserNotificationCenter.current().delegate = self
                self.setNotificationCategories()
            }
            
            completion?(granted)
        }
        
    }
    
    func getAttachmentFor(_ type: NotificationType) -> UNNotificationAttachment? {
        
        let imageName = type.rawValue
        
        guard let url = Bundle.main.url(forResource: imageName, withExtension: "png") else {return nil}
        
        do {
            let attchment = try UNNotificationAttachment.init(identifier: type.rawValue, url: url, options: [:])
            return attchment
        } catch {
            print("Attchment error")
            return nil
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

        UNUserNotificationCenter.current().setNotificationCategories([timerCategory, calenderCategory, locationCategory])
    }
    
    //For Time InterVal Notification
    func sendNotificationForTimer(withTimeInterval timeInterval: TimeInterval) {
        
        let content = UNMutableNotificationContent.init()
        content.title = "Time Reminder"
        content.body = "It is a Time Interval Reminder"
        if let attchment = getAttachmentFor(.timer) {
            content.attachments = [attchment]
        }
        content.sound = .default()
        content.categoryIdentifier = "timerCategory"
        
        content.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: timeInterval, repeats: false)
        
        let request = UNNotificationRequest.init(identifier: "Timer", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    //For Calender Notification
    func sendNotificationForCalender(withDate reminderDate: DateComponents) {
        
        let content = UNMutableNotificationContent.init()
        content.title = "Calender Reminder"
        content.body = "It is a Date Reminder"
        if let attchment = getAttachmentFor(.calendar) {
            content.attachments = [attchment]
        }
        content.sound = .default()
        content.categoryIdentifier = "calenderCategory"

        content.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber
        
        let trigger = UNCalendarNotificationTrigger.init(dateMatching: reminderDate, repeats: false)
        
        let request = UNNotificationRequest.init(identifier: "Calender", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    //For Calender Notification
   @objc func sendNotificationForLocation() {
        
    let content = UNMutableNotificationContent.init()
    content.title = "Location Reminder"
    content.body = "It is a Location Reminder"
    if let attchment = getAttachmentFor(.location) {
        content.attachments = [attchment]
    }
    content.sound = .default()
    content.categoryIdentifier = "locationCategory"

    content.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber
    
    let request = UNNotificationRequest.init(identifier: "LocationReminder", content: content, trigger: nil)
    
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
//        UIApplication.shared.applicationIconBadgeNumber = 0

        completionHandler()
    }
    
}

