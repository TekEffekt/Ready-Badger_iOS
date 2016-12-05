//
//  ListItemQueries.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 12/4/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class ListItemQueries {
    
    static func getListItems(forList list: ReadyList) -> [ListItem] {
        return Array(list.items)
    }
    
    static func getLists() -> [ReadyList] {
        let realm = try! Realm()
        return Array(realm.objects(ReadyList.self))
    }
    
}
