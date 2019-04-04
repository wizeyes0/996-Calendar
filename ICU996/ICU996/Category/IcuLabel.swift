//
//  IcuLabel.swift
//  ICU996
//
//  Created by Harry Duan on 2019/4/4.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit

class IcuLabel: UILabel {
    public var edgeInsets: UIEdgeInsets
    
    convenience init() {
        self.init(frame: .zero, inset: .zero)
    }
    
    init(frame: CGRect, inset: UIEdgeInsets) {
        self.edgeInsets = inset
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: self.edgeInsets))
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insets = self.edgeInsets
        var rect = super.textRect(forBounds: bounds.inset(by: insets), limitedToNumberOfLines: numberOfLines)
        rect.origin.x -= insets.left
        rect.origin.y -= insets.top
        rect.size.width += insets.left + insets.right
        rect.size.height += insets.top + insets.bottom
        return rect
    }
}

extension String {
    
    func boundingRect(with constrainedSize: CGSize, font: UIFont, lineSpacing: CGFloat? = nil) -> CGSize {
        let attritube = NSMutableAttributedString(string: self)
        let range = NSRange(location: 0, length: attritube.length)
        attritube.addAttributes([NSAttributedString.Key.font: font], range: range)
        if lineSpacing != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing!
            attritube.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        }
        
        let rect = attritube.boundingRect(with: constrainedSize, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        var size = rect.size
        
        if let currentLineSpacing = lineSpacing {
            // 文本的高度减去字体高度小于等于行间距，判断为当前只有1行
            let spacing = size.height - font.lineHeight
            if spacing <= currentLineSpacing && spacing > 0 {
                size = CGSize(width: size.width, height: font.lineHeight)
            }
        }
        
        return size
    }
    
    func boundingRect(with constrainedSize: CGSize, font: UIFont, lineSpacing: CGFloat? = nil, lines: Int) -> CGSize {
        if lines < 0 {
            return .zero
        }
        
        let size = boundingRect(with: constrainedSize, font: font, lineSpacing: lineSpacing)
        if lines == 0 {
            return size
        }
        
        let currentLineSpacing = (lineSpacing == nil) ? (font.lineHeight - font.pointSize) : lineSpacing!
        let maximumHeight = font.lineHeight*CGFloat(lines) + currentLineSpacing*CGFloat(lines - 1)
        if size.height >= maximumHeight {
            return CGSize(width: size.width, height: maximumHeight)
        }
        
        return size
    }
}


