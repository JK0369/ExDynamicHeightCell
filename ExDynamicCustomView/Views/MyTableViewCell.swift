//
//  MyTableViewCell.swift
//  ExDynamicCustomView
//
//  Created by 김종권 on 2021/12/01.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    // MARK: Constants
    
    struct LabelConstant {
        static let maximumNumberOfLines = 5
        static let font = UIFont.systemFont(ofSize: 16)
    }
    
    struct Metric {
        static let cellPadding = 16.0
    }
    
    
    // MARK: UI
    
    @IBOutlet weak var messageLabel: UILabel!
    
    
    // MARK: Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupDynamicLayout()
    }

    private func setupDynamicLayout() {
        messageLabel.numberOfLines = LabelConstant.maximumNumberOfLines
        messageLabel.font = LabelConstant.font
        messageLabel.layer.frame.origin.y = Metric.cellPadding // top
        messageLabel.layer.frame.origin.x = Metric.cellPadding // left
        messageLabel.layer.frame.size.width = contentView.layer.frame.size.width - Metric.cellPadding * 2
        messageLabel.sizeToFit()
    }
    
    
    // MARK: Binding

    func bind(mySectionItem: MySection.Item) {
        messageLabel.text = mySectionItem.message
        accessoryType = mySectionItem.isDone ? .checkmark : .none
    }
    
    
    // MARK: Cell Height

    class func height(width: CGFloat, myModel: MyModel) -> CGFloat {
        let message = myModel.message
        let contentWidth = width - Metric.cellPadding * 2
        let contentsHeight = message.getCalculatedHeight(contentWidth: contentWidth,
                                                         font: LabelConstant.font,
                                                         maximumNumberOfLines: LabelConstant.maximumNumberOfLines)
        let heightWithPadding = contentsHeight + Metric.cellPadding * 2
        return heightWithPadding
    }
    
}
