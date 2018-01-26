//
//  Category.swift
//  Todoey
//
//  Created by MacAir_Petchpol on 26/1/2561 BE.
//  Copyright © 2561 TochsapornP. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
