//
//  LinkedList.swift
//  DataStructure
//
//  Created by 김승진 on 2021/08/28.
//

import Foundation

public final class LinkedList<T> {
  /// The head of the Linked List
  private(set) var head: Node<T>?
  
  /// Computed property to iterate through the linked list and return the last node in the list (if any)
  public var last: Node<T>? {
    guard var node = head else {
      return nil
    }
    
    while let next = node.next {
      node = next
    }
    return node
  }
  
  /// Computed property to check if the linked list is empty
  public var isEmpty: Bool {
    return head == nil
  }
  
  /// Computed property to iterate through the linked list and return the total number of nodes
  public var count: Int {
    guard var node = head else {
      return 0
    }
    
    var count = 1
    while let next = node.next {
      node = next
      count += 1
    }
    return count
  }
  
  /// Default initializer
  public init() {}
  
  public init(_ value: T) {
    head = Node(value: value)
  }
  
  
  /// Subscript function to return the node at a specific index
  ///
  /// - Parameter index: Integer value of the requested value's index
  public subscript(index: Int) -> T? {
    let node = self.node(at: index)
    return node?.value
  }
  
  /// Function to return the node at a specific index. Crashes if index is out of bounds (0...self.count)
  ///
  /// - Parameter index: Integer value of the node's index to be returned
  /// - Returns: LinkedListNode
  public func node(at index: Int) -> Node<T>? {
    guard let head = head else { return nil }
    guard index >= 0 else { return nil }
    
    if index == 0 {
      return head
    } else {
      var node = head.next
      for _ in 1..<index {
        node = node?.next
        if node == nil {
          break
        }
      }
      
      guard let node = node else { return nil }
      return node
    }
  }
  
  /// Append a value to the end of the list
  ///
  /// - Parameter value: The data value to be appended
  public func append(_ value: T) {
    let newNode = Node(value: value)
    append(newNode)
  }
  
  /// Append a copy of a LinkedListNode to the end of the list.
  ///
  /// - Parameter node: The node containing the value to be appended
  public func append(_ node: Node<T>) {
    let newNode = node
    if let lastNode = last {
      newNode.previous = lastNode
      lastNode.next = newNode
    } else {
      head = newNode
    }
  }
  
  /// Append a copy of a LinkedList to the end of the list.
  ///
  /// - Parameter list: The list to be copied and appended.
  public func append(_ list: LinkedList) {
    var nodeToCopy = list.head
    while let node = nodeToCopy {
      append(node.value)
      nodeToCopy = node.next
    }
  }
  
  /// Insert a value at a specific index. Crashes if index is out of bounds (0...self.count)
  ///
  /// - Parameters:
  ///   - value: The data value to be inserted
  ///   - index: Integer value of the index to be insterted at
  public func insert(_ value: T, at index: Int) {
    let newNode = Node(value: value)
    insert(newNode, at: index)
  }
  
  /// Insert a copy of a node at a specific index. Crashes if index is out of bounds (0...self.count)
  ///
  /// - Parameters:
  ///   - node: The node containing the value to be inserted
  ///   - index: Integer value of the index to be inserted at
  public func insert(_ newNode: Node<T>, at index: Int) {
    if index == 0 {
      newNode.next = head
      head?.previous = newNode
      head = newNode
    } else if let prev = node(at: index - 1) {
      let next = prev.next
      newNode.previous = prev
      newNode.next = next
      next?.previous = newNode
      prev.next = newNode
    }
  }
  
  /// Insert a copy of a LinkedList at a specific index. Crashes if index is out of bounds (0...self.count)
  ///
  /// - Parameters:
  ///   - list: The LinkedList to be copied and inserted
  ///   - index: Integer value of the index to be inserted at
  public func insert(_ list: LinkedList, at index: Int) {
    guard !list.isEmpty else { return }
    
    if index == 0 {
      list.last?.next = head
      head = list.head
    } else if let prev = node(at: index - 1) {
      let next = prev.next
      
      prev.next = list.head
      list.head?.previous = prev
      
      list.last?.next = next
      next?.previous = list.last
    }
  }
  
  @discardableResult
  public func insertInFront(value: T) -> LinkedList<T> {
    let newList = LinkedList(value)
    guard let head = head else { return newList }
    newList.head?.next = head
    return newList
  }
  
  @discardableResult
  public func insertInFront(value: T) -> Node<T> {
    let newList = LinkedList(value)
    guard let head = head else { return newList.head! }
    newList.head!.next = head
    return newList.head!
  }
  
  /// Function to remove all nodes/value from the list
  public func removeAll() {
    head = nil
  }
  
  /// Function to remove a specific node.
  ///
  /// - Parameter node: The node to be deleted
  /// - Returns: The data value contained in the deleted node.
  @discardableResult
  public func remove(node: Node<T>) -> T {
    let prev = node.previous
    let next = node.next
    
    if let prev = prev {
      prev.next = next
    } else {
      head = next
    }
    next?.previous = prev
    
    node.previous = nil
    node.next = nil
    return node.value
  }
  
  /// Function to remove the last node/value in the list. Crashes if the list is empty
  ///
  /// - Returns: The data value contained in the deleted node.
  @discardableResult
  public func removeLast() throws -> T? {
    guard !isEmpty else { return nil }
    return remove(node: last!)
  }
  
  /// Function to remove a node/value at a specific index. Crashes if index is out of bounds (0...self.count)
  ///
  /// - Parameter index: Integer value of the index of the node to be removed
  /// - Returns: The data value contained in the deleted node
  @discardableResult
  public func remove(at index: Int) -> T? {
    guard let node = self.node(at: index) else { return nil }
    return remove(node: node)
  }
  
  @discardableResult
  public func delete(node: Node<T>) -> Bool {
    guard let head = head else { return false }
    
    if head === node {
      self.head = node.next
      return true
    }
    
    var next: Node? = head
    while next != nil {
      if next?.next === node {
        next?.next = node.next
        return true
      }
      
      next = next?.next
    }
    
    return false
  }
}

//: End of the base class declarations & beginning of extensions' declarations:
// MARK: - Extension to enable the standard conversion of a list to String
extension LinkedList: CustomDebugStringConvertible {
  public var debugDescription: String {
    var s = "["
    var node = head
    while let nd = node {
      s += "\(nd.value)"
      node = nd.next
      if node != nil { s += ", " }
    }
    return s + "]"
  }
}

// MARK: - Extension to add a 'reverse' function to the list
extension LinkedList {
  public func reverse() {
    var node = head
    while let currentNode = node {
      node = currentNode.next
      swap(&currentNode.next, &currentNode.previous)
      head = currentNode
    }
  }
}

// MARK: - An extension with an implementation of 'map' & 'filter' functions
extension LinkedList {
  public func map<U>(transform: (T) -> U) -> LinkedList<U> {
    let result = LinkedList<U>()
    var node = head
    while let nd = node {
      result.append(transform(nd.value))
      node = nd.next
    }
    return result
  }
  
  public func filter(predicate: (T) -> Bool) -> LinkedList<T> {
    let result = LinkedList<T>()
    var node = head
    while let nd = node {
      if predicate(nd.value) {
        result.append(nd.value)
      }
      node = nd.next
    }
    return result
  }
  
  public func first(where predicate: (Node<T>) -> Bool) -> Node<T>? {
    var node = head
    
    while let nd = node {
      if predicate(nd) {
        return nd
      }
      
      node = nd.next
    }
    return nil
  }
}

// MARK: - Extension to enable initialization from an Array
extension LinkedList {
  convenience init(array: Array<T>) {
    self.init()
    
    array.forEach { append($0) }
  }
}

// MARK: - Extension to enable initialization from an Array Literal
extension LinkedList: ExpressibleByArrayLiteral {
  public convenience init(arrayLiteral elements: T...) {
    self.init()
    
    elements.forEach { append($0) }
  }
}

// MARK: - Collection
extension LinkedList: Collection {
  // MARK: - Collection Index
  /// Custom index type that contains a reference to the node at index 'tag'
  public struct Index<T>: Comparable {
    fileprivate let node: Node<T>?
    fileprivate let tag: Int
    
    public static func==<T>(lhs: Index<T>, rhs: Index<T>) -> Bool {
      return (lhs.tag == rhs.tag)
    }
    
    public static func< <T>(lhs: Index<T>, rhs: Index<T>) -> Bool {
      return (lhs.tag < rhs.tag)
    }
  }
  
  /// The position of the first element in a nonempty collection.
  ///
  /// If the collection is empty, `startIndex` is equal to `endIndex`.
  /// - Complexity: O(1)
  public var startIndex: Index<T> {
    get {
      return Index(node: head, tag: 0)
    }
  }
  
  /// The collection's "past the end" position---that is, the position one
  /// greater than the last valid subscript argument.
  /// - Complexity: O(n), where n is the number of elements in the list. This can be improved by keeping a reference
  ///   to the last node in the collection.
  public var endIndex: Index<T> {
    get {
      if let h = self.head {
        return Index(node: h, tag: count)
      } else {
        return Index(node: nil, tag: startIndex.tag)
      }
    }
  }
  
  public subscript(position: Index<T>) -> T {
    get {
      return position.node!.value
    }
  }
  
  public func index(after idx: Index<T>) -> Index<T> {
    return Index(node: idx.node?.next, tag: idx.tag + 1)
  }
}

