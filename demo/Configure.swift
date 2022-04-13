//
//  Configure.swift
//  demo
//
//  Created by CMTech on 12/4/22.
//

import UIKit

class Configure<T> {
    var value: T? {
        didSet {
            action?(value)
        }
    }
    init(_ value: T?)
    {
        self.value = value
    }
    
    private var action: ((T?) -> Void)?
    
    func bind(_ action: @escaping ((T?) -> Void))
    {
        action(value)
        self.action = action
    }
}
