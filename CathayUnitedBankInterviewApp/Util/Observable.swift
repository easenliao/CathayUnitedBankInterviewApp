//
//  Observable.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/22.
//

import Foundation

class Observable<ObservableType> {
    typealias Observer = (ObservableType) -> Void
    private var observers: [(Observer, DispatchQueue?)] = []
    private var currentQueue: DispatchQueue?
    var value: ObservableType? {
        didSet {
            valueChanged()
        }
    }

    init(_ value: ObservableType? = nil) {
        self.value = value
    }

    func on(queue: DispatchQueue) -> Observable {
        currentQueue = queue
        return self
    }

    func bind(observer: @escaping Observer) {
        observers.append((observer, currentQueue))
        currentQueue = nil // Reset after binding
        valueChanged()
    }

    private func valueChanged() {
        guard let value else { return }
        for (observer, queue) in observers {
            if let queue {
                queue.async {
                    observer(value)
                }
            } else {
                observer(value)
            }
        }
    }
}
