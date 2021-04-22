//
//  UITextField+Ext.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import UIKit

extension UITextField {
    func addLeftPadding(_ w: CGFloat = 10) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: w, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
