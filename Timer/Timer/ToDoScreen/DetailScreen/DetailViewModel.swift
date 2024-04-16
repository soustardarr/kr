//
//  DetailViewModel.swift
//  Timer
//
//  Created by Ruslan Kozlov on 16.04.2024.
//

import Foundation
import Combine

class DetailViewModel {

    var taskManager: TaskManager
    var cancellable: Set<AnyCancellable> = []

    init(taskManager: TaskManager = ServiceLocator.shared.getService()!) {
        self.taskManager = taskManager
    }

    func addTask(_ task: MyTask) {
        taskManager.myTasks.append(task)
    }

    func printTask() {
        taskManager.$myTasks.sink { array in
            print(array)
        }.store(in: &cancellable)
    }

    

}
