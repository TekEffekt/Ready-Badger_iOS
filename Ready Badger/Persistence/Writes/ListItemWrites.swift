//
//  ListItemWrites.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 12/4/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class ListItemWrites {
    
    static func add(list: ReadyList) {
        if list.id == 0 {
            list.id = ReadyList.incrementID()
        }
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(list, update: true)
        }
    }
    
    static func add(listItem: ListItem, inList list: ReadyList) {
        if listItem.id == 0 {
            listItem.id = ListItem.incrementID()
        }
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(listItem, update: true)
            list.items.append(listItem)
        }
    }
    
    static func remove(list: ReadyList) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(list)
        }
    }
    
    static func remove(listItem: ListItem, fromList list: ReadyList) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(listItem)
        }
    }
    
    static func update(item: ListItem, withName name: String) {
        let realm = try! Realm()
        try! realm.write {
            item.name = name
        }
    }
    
    static func update(item: ListItem, withDescription description: String) {
        let realm = try! Realm()
        try! realm.write {
            item.itemDescription = description
        }
    }
    
}
