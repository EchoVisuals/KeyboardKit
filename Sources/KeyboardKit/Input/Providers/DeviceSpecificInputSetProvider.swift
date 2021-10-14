//
//  DeviceSpecificInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This protocol extends `KeyboardInputSetProvider` and can be
 implemented by any provider that bases its input set on the
 device being used.
 */
public protocol DeviceSpecificInputSetProvider: KeyboardInputSetProvider {
    
    /**
     The device being used.
     */
    var device: UIDevice { get }
}

public extension DeviceSpecificInputSetProvider {
    
    /**
     This function creates an input row where each character
     in the provided string is converted to a `KeyboardInput`,
     using its upper- and lowercased form.
     */
    func row(_ chars: String) -> KeyboardInputRow {
        row(chars.chars)
    }
    
    /**
     This function creates an input row where each character
     is converted to a `KeyboardInput`, using its upper- and
     lowercased form.
     */
    func row(_ chars: [String]) -> KeyboardInputRow {
        KeyboardInputRow(chars)
    }
    
    /**
     This function creates an input row where each character
     tuple is converted to a `KeyboardInput` using the first
     tuple element as lowercase and the second as uppercase.
     */
    func row(_ chars: [(String, String)]) -> KeyboardInputRow {
        KeyboardInputRow(chars)
    }
    
    /**
     This function creates a device-specific input row for a
     phone or pad, depending on the device's interface idiom.
     Every character tuple is converted to a `KeyboardInput`,
     using the first element as lowercase then the second as
     uppercase.
     */
    func row(phone: [(String, String)], pad: [(String, String)]) -> KeyboardInputRow {
        device.isPhone ? row(phone) : row(pad)
    }
    
    /**
     This function creates a device-specific input row for a
     phone or pad, depending on the device's interface idiom.
     Each character in the provided string is converted to a
     `KeyboardInput` using its upper- and lowercased form.
     */
    func row(phone: String, pad: String) -> KeyboardInputRow {
        device.isPhone ? row(phone) : row(pad)
    }
}
