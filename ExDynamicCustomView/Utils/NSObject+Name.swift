//
//  NSObject+Name.swift
//  ExDynamicCustomView
//
//  Created by 김종권 on 2021/12/01.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
