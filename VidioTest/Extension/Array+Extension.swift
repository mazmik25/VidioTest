//
//  Array+Extension.swift
//  VidioTest
//
//  Created by Muhammad Azmi Khairullah on 29/10/22.
//

import Foundation
extension Array {
    subscript(safe index: Int) -> Element? {
        if indices ~= index {
            return self[index]
        } else {
            return nil
        }
    }
}
