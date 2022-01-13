//
//  String+ext.swift
//  DodoApp
//
//  Created by Surgeont on 13.12.2021.
//

import UIKit

extension String{
    func widthOfString(usingFont font: UIFont) -> CGFloat {
             let fontAttributes = [NSAttributedString.Key.font: font]
             let size = (self as NSString).size(withAttributes: fontAttributes)
             return ceil(size.width)
    }
}
