//
//  KeyboardLayoutProvider+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-25.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardLayoutProvider where Self == PreviewKeyboardLayoutProvider {
    
    /**
     This layout provider can be used in SwiftUI previews.
     */
    static var preview: KeyboardLayoutProvider { PreviewKeyboardLayoutProvider() }
}


/**
 This layout provider can be used in SwiftUI previews.
 */
public class PreviewKeyboardLayoutProvider: KeyboardLayoutProvider {
    
    public init(context: KeyboardContext = .preview) {
        let inputProvider = StandardKeyboardInputSetProvider(context: context)
        provider = StandardKeyboardLayoutProvider(inputSetProvider: inputProvider)
    }
    
    private let provider: KeyboardLayoutProvider
    
    public func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        provider.keyboardLayout(for: context)
    }
    
    public func register(inputSetProvider: KeyboardInputSetProvider) {
        provider.register(inputSetProvider: inputSetProvider)
    }
}
