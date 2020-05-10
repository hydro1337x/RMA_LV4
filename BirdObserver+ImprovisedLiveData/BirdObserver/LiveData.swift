//
//  LiveData.swift
//  BirdObserver
//
//  Created by Benjamin Mecanovic on 10/05/2020.
//  Copyright © 2020 hydro1337x. All rights reserved.
//

import Foundation

class LiveData<T> {
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
    
    func observe(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
