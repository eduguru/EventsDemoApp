//
//  CNContact.swift
//  Little Agent
//
//  Created by edwin weru on 28/12/2020.
//

import ContactsUI
import Foundation

extension CNContact {
    open func displayName() -> String {
        return givenName + " " + familyName
    }
}
