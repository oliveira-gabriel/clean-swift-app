//
//  AccountModelFactory.swift
//  DataTests
//
//  Created by Gabriel Oliveira on 24/02/22.
//

import Foundation
import Domain

func makeAccountModel() -> AccountModel {
    return AccountModel(id: "any_id", name: "any_name", email: "any_email@email.com", password: "any_password")
}