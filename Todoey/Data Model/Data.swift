//
//  Data.swift
//  Todoey
//
//  Created by MacAir_Petchpol on 25/1/2561 BE.
//  Copyright © 2561 TochsapornP. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var age : Int = 0
}
