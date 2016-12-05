//
//  ListItem.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 12/4/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class ListItem: Object {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var itemDescription = ""
    let list = LinkingObjects(fromType: ReadyList.self, property: "items")
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    static func incrementID() -> Int {
        let realm = try! Realm()
        let nextLocation = Array(realm.objects(ListItem.self).sorted(byProperty: "id"))
        let last = nextLocation.last
        if nextLocation.count > 0 {
            let currentID = last?.value(forKey: "id") as? Int
            return currentID! + 1
        }
        else {
            return 1
        }
    }
}
