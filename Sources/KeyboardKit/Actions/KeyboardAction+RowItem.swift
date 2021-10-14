//
//  KeyboardAction+RowItem.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This extension makes `KeyboardAction` conform to `RowItem`.
 */
extension KeyboardAction: RowItem {

    /**
     The row-specific ID to use when the action is presented
     in a keyboard row.
     */
    public var rowId: KeyboardAction { self }
}
