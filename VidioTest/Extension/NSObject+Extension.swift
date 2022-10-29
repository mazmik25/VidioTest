//
//  NSObject+Extension.swift
//  VidioTest
//
//  Created by Muhammad Azmi Khairullah on 29/10/22.
//

import Foundation

extension NSObject {
    static func className() -> String {
        return (NSStringFromClass(self).components(separatedBy: ".").last).safeUnwrap()
    }
}
