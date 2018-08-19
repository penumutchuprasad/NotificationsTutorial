//NotificationViewController.swift
/*
 * NotificationContent
 * Created by penumutchu.prasad@gmail.com on 19/08/18
 * Is a product created by abnboys
 * For the NotificationContent in the LKNotificationTutorial
 
 * Here the permission is granted to this file with free of use anywhere in the IOS Projects.
 * Copyright © 2018 ABNBoys.com All rights reserved.
*/

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = "Ola...,\(notification.request.content.title)"
    }
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        if response.notification.request.content.categoryIdentifier == "timerCategory" {
            print("yoyoyoyo")
            completion(.dismissAndForwardAction)
        }
    }

}
