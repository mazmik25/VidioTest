//
//  Optional+Extension.swift
//  VidioTest
//
//  Created by Muhammad Azmi Khairullah on 29/10/22.
//

import Foundation

extension Optional {
    func safeUnwrap(_ def: Wrapped) -> Wrapped {
        if let self = self {
            return self
        } else {
            return def
        }
    }
}

extension Optional where Wrapped: ExpressibleByStringLiteral {
    func safeUnwrap() -> Wrapped {
        if let self = self {
            return self
        } else {
            return ""
        }
    }
}

extension Optional where Wrapped: Numeric {
    func safeUnwrap() -> Wrapped {
        if let self = self {
            return self
        } else {
            return .zero
        }
    }
}

extension Optional where Wrapped: ExpressibleByArrayLiteral {
    func safeUnwrap() -> Wrapped {
        if let self = self {
            return self
        } else {
            return []
        }
    }
}

extension Optional where Wrapped: ExpressibleByDictionaryLiteral {
    func safeUnwrap() -> Wrapped {
        if let self = self {
            return self
        } else {
            return [:]
        }
    }
}
