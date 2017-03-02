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
    
    static func getListItems(forList list: ReadyList) -> List<ListItem> {
        return list.items
    }
    
    static func getLists() -> Results<ReadyList> {
        let realm = try! Realm()
        return realm.objects(ReadyList.self)
    }
    
}
