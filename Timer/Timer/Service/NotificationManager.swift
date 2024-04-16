//
//  NotificationManager.swift
//  Timer
//
//  Created by Ruslan Kozlov on 16.04.2024.
//

import Foundation
import UserNotifications

class NotificationManager {

    let notificationCenter = UNUserNotificationCenter.current()

    func requestAuth() async throws -> Bool {
        try await notificationCenter.requestAuthorization(options: [.alert, .badge])
    }

}

