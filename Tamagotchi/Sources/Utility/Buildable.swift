//
//  Buildable.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/13/24.
//

import Foundation

protocol Buildable { }

extension Buildable where Self: NSObject {
    func build(
        _ block: ((_ builder: Builder<Self>) -> Builder<Self>)
    ) -> Self {
        block(Builder(self)).finalize()
    }
}

// MARK: NSObject
extension NSObject: Buildable { }

// MARK: Builder
@dynamicMemberLookup
struct Builder<Base: AnyObject> {
    private let base: Base
    
    init(_ base: Base) {
        self.base = base
    }
    
    subscript<Property>(
        dynamicMember keyPath: ReferenceWritableKeyPath<Base, Property>
    ) -> (_ newValue: Property) -> Builder<Base> {
        { newValue in
            base[keyPath: keyPath] = newValue
            return Builder(base)
        }
    }
    
    func capture(_ block: (_ base: Base) -> Void) -> Builder<Base> {
        block(base)
        return Builder(base)
    }
    
    fileprivate func finalize() -> Base {
        base
    }
}
