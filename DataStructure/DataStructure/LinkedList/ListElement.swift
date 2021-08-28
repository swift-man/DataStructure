//
//  ListElement.swift
//  DataStructure
//
//  Created by 김승진 on 2021/08/28.
//

import Foundation

public class ListElement<T> {
    private var _data: T
    private var _next: ListElement<T>?
    
    public init(value: T) {
        self._data = value
    }
    
    public var next: ListElement<T>? {
        return _next
    }
    
    public var value: T {
        return _data
    }
    
    public func setNext(_ next: ListElement<T>) {
        _next = next
    }
    
    public func setValue(_ value: T) {
        _data = value
    }
}
