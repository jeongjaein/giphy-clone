//
//  NSObject+Ext.swift
//  GiphyClone
//
//  Created by 정재인 on 2021/04/21.
//

import Foundation

protocol Do { }

extension NSObject: Do { }

extension Do where Self: Any {
    func `do`(_ block: (Self) throws -> Void) rethrows {
      try block(self)
    }
}
