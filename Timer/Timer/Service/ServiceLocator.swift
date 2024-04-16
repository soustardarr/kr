//
//  ServiceLocator.swift
//  Timer
//
//  Created by Ruslan Kozlov on 16.04.2024.
//

import Foundation

class ServiceLocator {


    static var shared = ServiceLocator()

    private init() { }

    private var services: [String: Any] = [:]

    func addService<T>(service: T) {

        let key = String(describing: T.self)
        services[key] = service

    }

    func getService<T>() -> T? {
        let key = String(describing: T.self)

        return services[key] as? T
    }

}
