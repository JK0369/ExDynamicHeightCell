//
//  SectionModel.swift
//  ExDynamicCustomView
//
//  Created by 김종권 on 2021/12/01.
//

import RxDataSources

public struct SectionModel<Section, ItemType> {
    public var section: Section
    public var items: [Item]
}

extension SectionModel: SectionModelType {
    
    public typealias Identity = Section
    public typealias Item = ItemType
    
    public var identity: Section {
        return section
    }
    
    public init(original: SectionModel<Section, ItemType>, items: [ItemType]) {
        self.section = original.section
        self.items = items
    }
}
