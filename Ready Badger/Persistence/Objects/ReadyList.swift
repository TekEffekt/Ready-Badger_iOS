//
//  List.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 12/4/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class ReadyList: Object {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var listDescription = ""
    let items = List<ListItem>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    static func incrementID() -> Int {
        let realm = try! Realm()
        let items = realm.objects(ReadyList.self).sorted(byProperty: "id")
        let lastItem = items.last
        if items.count > 0 {
            let currentID = lastItem?.value(forKey: "id") as? Int
            return currentID! + 1
        }
        else {
            return 1
        }
    }
}
