//
//  Converter.swift
//  Podolist
//
//  Created by NHNEnt on 2018. 9. 9..
//  Copyright © 2018년 podo. All rights reserved.
//

class Converter {

    static func convertToViewModelPodolist(with podolist: [Podo]) -> [ViewModelPodo] {
        var viewModelPodolist: [ViewModelPodo] = []
        for podo in podolist {
            let viewModelPodo = ViewModelPodo(id: podo.id, title: podo.title)
            viewModelPodolist.append(viewModelPodo)
        }

        return viewModelPodolist
    }
}
