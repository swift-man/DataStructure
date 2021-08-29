//
//  Node.swift
//  DataStructure
//
//  Created by 김승진 on 2021/08/29.
//

import Foundation

public class Node<T> {
  var value: T
  var next: Node?
  weak var previous: Node?
  
  public init(value: T) {
    self.value = value
  }
}
