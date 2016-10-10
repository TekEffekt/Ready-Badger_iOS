//
//  FeedItem.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/10/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

protocol FeedItem {
    var countyName: String { get }
    var title: String { get }
    var description: String { get }
}
