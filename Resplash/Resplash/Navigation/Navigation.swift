//
//  Navigation.swift
//  Resplash
//
//  Created by Sateesh Yemireddi on 3/2/21.
//

import UIKit

struct Navigation {
    static func navigate(to route: Route, data: [String: Any] = [:]) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyboard.instantiateViewController(identifier: route.rawValue)
        guard let navigationController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController else {
            fatalError("\(#file): \n\(#function): \n Unable to get navigationController!")
        }
        switch route {
        case .photos:
            if let photosViewController = destination as? PhotosViewController {
                if let album = data["data"] as? Album {
                    photosViewController.album = album
                }
            }
            navigationController.pushViewController(destination, animated: true)
        }
    }
}

