//
//  ToDoViewModel.swift
//  Timer
//
//  Created by Ruslan Kozlov on 16.04.2024.
//

import Foundation
import Combine
import UserNotifications

class ToDoViewModel {
    
    var taskManager: TaskManager
    var notificationManager: NotificationManager

    init(taskManager: TaskManager = ServiceLocator.shared.getService()!,
         notificationManager: NotificationManager = ServiceLocator.shared.getService()!) {
        self.taskManager = taskManager
        self.notificationManager = notificationManager
        requestNotificationManager()

    }

    private func requestNotificationManager() {
        Task {
            let _ =  try? await notificationManager.requestAuth()
        }
    }

    func addRequest(task: MyTask) {

        let content = UNMutableNotificationContent()
        content.title = "Приступаем, смотри watch"
        content.body = "\(String(describing: task.title))"

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "taskReminder", content: content, trigger: trigger)

        notificationManager.notificationCenter.add(request) { (error) in
            if let error = error {
                print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
            } else {
                print("Уведомление успешно добавлено")
            }
        }

    }


}
