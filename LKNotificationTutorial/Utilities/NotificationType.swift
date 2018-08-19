//NotificationType.swift
/*
 * LKNotificationTutorial
 * Created by penumutchu.prasad@gmail.com on 19/08/18
 * Is a product created by abnboys
 * For the LKNotificationTutorial in the LKNotificationTutorial
 
 * Here the permission is granted to this file with free of use anywhere in the IOS Projects.
 * Copyright © 2018 ABNBoys.com All rights reserved.
*/

import Foundation

enum NotificationType: String {
    
    case timer
    case calendar
    case location
    
    var value: String {
        switch self {
        case .timer:
            return rawValue
        case .calendar:
            return rawValue
        default:
            return rawValue
        }
    }
    
}
