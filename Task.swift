//
//  Task.swift
//  ToDo
//
//  Created by MOHANNED on 03/10/2020.
//  Copyright © 2020 MOHANNED. All rights reserved.
//

import RealmSwift

class Task: Object {
    @objc dynamic var name = ""
    @objc dynamic var complited = false
}
