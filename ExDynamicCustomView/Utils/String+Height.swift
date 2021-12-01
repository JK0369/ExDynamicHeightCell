//
//  String+Height.swift
//  ExDynamicCustomView
//
//  Created by 김종권 on 2021/12/01.
//

import Foundation
import UIKit

extension String {
    func getCalculatedHeight(contentWidth width: CGFloat, font: UIFont, maximumNumberOfLines: Int = 0) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let height = self.size(padding: size, font: font, maximumNumberOfLines: maximumNumberOfLines).height
        return height
    }
    
    private func size(padding size: CGSize, font: UIFont, maximumNumberOfLines: Int = 0) -> CGSize {
      let attributes: [NSAttributedString.Key: Any] = [.font: font]
      var size = self.boundingRect(with: size, attributes: attributes).size
      if maximumNumberOfLines > 0 {
        size.height = min(size.height, CGFloat(maximumNumberOfLines) * font.lineHeight)
      }
      return size
    }
    
    private func boundingRect(with size: CGSize, attributes: [NSAttributedString.Key: Any]) -> CGRect {
      let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
      let rect = self.boundingRect(with: size, options: options, attributes: attributes, context: nil)
      return rect
    }
}
