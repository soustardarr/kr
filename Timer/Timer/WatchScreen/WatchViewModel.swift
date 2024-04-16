//
//  WatchViewModel.swift
//  Timer
//
//  Created by Ruslan Kozlov on 16.04.2024.
//

import Foundation


class WatchViewModel {

    var taskManager: TaskManager

    init(taskManager: TaskManager = ServiceLocator.shared.getService()!) {
        self.taskManager = taskManager
    }
    
}
