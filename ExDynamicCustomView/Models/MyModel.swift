//
//  MyModel.swift
//  ExDynamicCustomView
//
//  Created by 김종권 on 2021/12/01.
//

import Foundation
import RxDataSources

public typealias MySection = SectionModel<String, MyModel>

public struct MyModel {
    var message: String
    var isDone: Bool = false
}

extension MyModel: IdentifiableType {
    public var identity: String {
        return UUID().uuidString
    }
    
}
