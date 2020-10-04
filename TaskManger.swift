//
//  TaskManager.swift
//  ToDo
//
//  Created by MOHANNED on 03/10/2020.
//  Copyright © 2020 MOHANNED. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveTasksList(_ tasks: Task) {
        try! realm.write {
            realm.add(tasks)
        }
    }
    
    static func deleteTasks(_ tasks: Task) {
    try! realm.write {
        realm.delete(tasks)
    }
    }
}

