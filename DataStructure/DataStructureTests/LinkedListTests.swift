//
//  LinkedListTests.swift
//  DataStructureTests
//
//  Created by 김승진 on 2021/08/29.
//

@testable import DataStructure
import Quick
import Nimble

/*
 - Given (설명하려는 동작)
 - When (해당 동작 / 동작의 컨텍스트)
 - Then (발생할 것 으로 예상되는 동작)
 */
class LinkedListTests: QuickSpec {
  override func spec() {
    var linkedList: LinkedList<Int>!
    beforeEach {
      linkedList = LinkedList()
      linkedList.append(0)
    }
    
    describe("linkedList 테스트") {
      context("초기화 테스트") {
        it("초기화시 header value 0") {
          expect(linkedList.head?.value).to(equal(0))
        }
        it("초기화시 header next nil") {
          expect(linkedList.head?.next).to(beNil())
        }
      }
      
      context("삽입이 완료 되면 next") {
        beforeEach {
          linkedList = LinkedList()
          linkedList.append(0)
          let head = linkedList.head
          head?.next = Node(value: 2)
        }
        
        it("header value 는 0 이고, next value 2") {
          expect(linkedList.head?.value).to(equal(0))
          expect(linkedList.head?.next?.value).to(equal(2))
        }
        it("next 의 next 는 nil") {
          expect(linkedList.head?.next?.next).to(beNil())
        }
      }
      
      context("2, 3, 5 삽입 후 insert 4 테스트") {
        beforeEach {
          linkedList = LinkedList(2)
          let head = linkedList.head
          head?.next = Node(value: 3)
          head?.next?.next = Node(value: 5)
          linkedList = linkedList.insertInFront(value: 4)
        }
        
        it("header 는 4 next 는 2, 3, 5") {
          print(linkedList.debugDescription)
          expect(linkedList.head?.value).to(equal(4))
          expect(linkedList.head?.next?.value).to(equal(2))
          expect(linkedList.head?.next?.next?.value).to(equal(3))
          expect(linkedList.head?.next?.next?.next?.value).to(equal(5))
          expect(linkedList.head?.next?.next?.next?.next?.value).to(beNil())
        }
      }
      
      context("find 테스트 0, 2, 4 데이터 세팅") {
        beforeEach() {
          linkedList = LinkedList(0)
          linkedList.head?.next = Node(value: 2)
          let next = linkedList.head?.next
          next?.next = Node(value: 4)
        }
        
        it("0, 2, 5 찾기") {
          let findZero = linkedList.first(where: { $0.value == 0 })
          let findTwo = linkedList.first(where: { $0.value == 2 })
          let findFive = linkedList.first(where: { $0.value == 5 })
          
          expect(findZero?.value).to(equal(0))
          expect(findTwo?.value).to(equal(2))
          expect(findFive).to(beNil())
        }
      }
      
      // 삭제 테스트
    }
  }
}
