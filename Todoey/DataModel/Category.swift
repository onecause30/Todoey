//
//  Category.swift
//  Todoey
//
//  Created by Anthony Hall on 7/29/18.
//  Copyright © 2018 Anthony Hall. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
    
}
