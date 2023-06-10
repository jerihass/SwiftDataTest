//
//  ModelTestTests.swift
//  ModelTestTests
//
//  Created by Jericho Hasselbush on 6/9/23.
//

import XCTest
import SwiftData
@testable import ModelTest

final class ModelTestTests: XCTestCase {
    
    var item = Item(timestamp: .now, name: "A name", number: 10)
    var id: UUID? = nil
    var timeStamp: Date? = nil
    var itemName: String? = nil
    var number: Int? = nil
    
    override func setUpWithError() throws {
        id = item.id
        timeStamp = item.timestamp
        itemName = item.name
        number = item.number
    }
    
    override func tearDownWithError() throws {
    }
    
    @MainActor func testID() throws {
        let sut = try ModelContainer(for: Item.self)
        sut.saveItem(item)
        
        let retrieved = sut.getItemByID(id ?? UUID())
        
        XCTAssertEqual(item.id, id)
        XCTAssertNotNil(retrieved)
        sut.deleteItem(item)
    }
    
    @MainActor func testIDByID() throws {
        let sut = try ModelContainer(for: Item.self)
        sut.saveItem(item)
        let retrieved = sut.getItem(id ?? UUID())
        
        XCTAssertEqual(item.id, id)
        XCTAssertNotNil(retrieved)
        sut.deleteItem(item)
    }
    
    @MainActor func testDate() throws {
        let sut = try ModelContainer(for: Item.self)
        sut.saveItem(item)
        let retrieved = sut.getItem(timeStamp ?? Date.now)
        
        XCTAssertEqual(item.timestamp, timeStamp)
        XCTAssertNotNil(retrieved)
        sut.deleteItem(item)
    }
    
    @MainActor func testName() throws {
        let sut = try ModelContainer(for: Item.self)
        sut.saveItem(item)
        let retrieved = sut.getItem(itemName ?? "")
        
        XCTAssertEqual(item.name, itemName)
        XCTAssertNotNil(retrieved)
        sut.deleteItem(item)
    }
    
    @MainActor func testNumber() throws {
        let sut = try ModelContainer(for: Item.self)
        sut.saveItem(item)
        let retrieved = sut.getItem(number ?? 0)
        
        XCTAssertEqual(item.number, number)
        XCTAssertNotNil(retrieved)
        sut.deleteItem(item)
    }
}


extension ModelContainer {
    
    @MainActor func saveItem(_ item: Item) {
        self.mainContext.insert(object: item)
    }
    
    @MainActor func deleteItem(_ item: Item) {
        self.mainContext.delete(object: item)
    }
    
    @MainActor func getItem(_ id: UUID) -> Item? {
        var item: Item
        let predicate = #Predicate<Item> { $0.id == id }
        
        let fetch = FetchDescriptor<Item>(predicate: predicate)
        do {
            if let results = try self.mainContext.fetch(fetch).first {
                item = results
            }
            else { return nil }
        } catch {
            print("\(error): \(predicate)")
            return nil
        }
        return item
    }
 
    @MainActor func getItem(_ name: String) -> Item? {
        var item: Item
        let predicate = #Predicate<Item> { $0.name == name }
        let fetch = FetchDescriptor<Item>(predicate: predicate)

        do {
            if let results = try self.mainContext.fetch(fetch).first {
                item = results
            }
            else { return nil }
        } catch {
            print("\(error): \(fetch)")
            return nil
        }
        return item
    }
    
    @MainActor func getItem(_ number: Int) -> Item? {
        var item: Item
        let predicate = #Predicate<Item> { $0.number == number }
        let fetch = FetchDescriptor<Item>(predicate: predicate)

        do {
            if let results = try self.mainContext.fetch(fetch).first {
                item = results
            }
            else { return nil }
        } catch {
            print("\(error): \(fetch)")
            return nil
        }
        return item
    }
    
    @MainActor func getItem(_ date: Date) -> Item? {
        var item: Item
        let fetch = FetchDescriptor<Item>(predicate: #Predicate { $0.timestamp == date })
        do {
            if let results = try self.mainContext.fetch(fetch).first {
                item = results
            }
            else { return nil }
        } catch {
            print("\(error): \(fetch)")
            return nil
        }
        return item
    }
    
    @MainActor func getItemByID(_ id: UUID) -> Item? {
        var item: Item?
        let fetch = FetchDescriptor<Item>()
        do {
            let results = try self.mainContext.fetch(fetch)
            item = results.first(where: {$0.id == id}) ?? nil
        } catch {
            print("\(error): \(fetch)")
            return nil
        }
        return item
    }

}
