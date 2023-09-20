//
//  NetworkUtils.swift
//  testmovies
//
//  Created by Stanislav Seryogin on 20.09.2023.
//

import Network

import Network

struct NetworkUtils {
    private static var monitor: NWPathMonitor? = {
        let monitor = NWPathMonitor()
        monitor.start(queue: DispatchQueue.global(qos: .background))
        return monitor
    }()

    static func hasInternetConnection() -> Bool {
        return monitor?.currentPath.status == .satisfied
    }
}
