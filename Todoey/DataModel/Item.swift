//
//  Item.swift
//  Todoey
//
//  Created by Anthony Hall on 7/29/18.
//  Copyright © 2018 Anthony Hall. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentcategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
