//
//  MySection.swift
//  ExDynamicCustomView
//
//  Created by 김종권 on 2021/12/01.
//

import RxDataSources

struct MySection {
    var headerTitle: String
    var items: [Item]
}

extension MySection: AnimatableSectionModelType {
    typealias Item = MyModel
    
    var identity: String {
        return headerTitle
    }
    
    init(original: MySection, items: [MyModel]) {
        self = original
        self.items = items
    }
}
