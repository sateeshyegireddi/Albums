//
//  Dynamic.swift
//  Resplash
//
//  Created by Sateesh Yemireddi on 3/2/21.
//

import Foundation

struct Dynamic<T> {
    
    typealias Listener = (T) -> Void
    
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    mutating func bind(listener: Listener?) {
        self.listener = listener
    }
    
    mutating func bindAndFire(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
