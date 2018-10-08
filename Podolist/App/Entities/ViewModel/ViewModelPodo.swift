//
//  ViewModelPodo.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

class ViewModelPodo {
    var id: Int?
    var title: String?
    var isCompleted: Bool?
    var priority: Priority?

    init(id: Int?, title: String?, isCompleted: Bool?, priority: Priority?) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.priority = priority
    }

    convenience init(podo: Podo) {
        self.init(id: podo.id,
                  title: podo.title,
                  isCompleted: podo.isCompleted,
                  priority: podo.priority)
    }
}
