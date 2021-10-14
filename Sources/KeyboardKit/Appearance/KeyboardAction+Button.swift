//
//  KeyboardAction+Button.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

public extension KeyboardAction {
    
    /**
     The action's standard button image.
     */
    func standardButtonImage(for context: KeyboardContext) -> Image? {
        if let image = standardButtonTextImageReplacement(for: context) { return image }
        
        switch self {
        case .backspace: return .keyboardBackspace
        case .command: return .keyboardCommand
        case .control: return .keyboardControl
        case .dictation: return .keyboardDictation
        case .dismissKeyboard: return .keyboardDismiss
        case .image(_, let imageName, _): return Image(imageName)
        case .keyboardType(let type): return type.standardButtonImage
        case .moveCursorBackward: return .keyboardLeft
        case .moveCursorForward: return .keyboardRight
        case .newLine: return .keyboardNewline
        case .nextKeyboard: return .keyboardGlobe
        case .option: return .keyboardOption
        case .primary(let type): return type.standardButtonImage
        case .settings: return .keyboardSettings
        case .shift(let currentState): return currentState.standardButtonImage
        case .systemImage(_, let imageName, _): return Image(systemName: imageName)
        case .tab: return .keyboardTab
        default: return nil
        }
    }
    
    /**
     The action's standard button text.
     */
    func standardButtonText(for context: KeyboardContext) -> String? {
        switch self {
        case .character(let char): return char
        case .emoji(let emoji): return emoji.char
        case .emojiCategory(let cat): return cat.fallbackDisplayEmoji.char
        case .keyboardType(let type): return type.standardButtonText(for: context)
        case .nextLocale: return context.locale.languageCode?.uppercased()
        case .primary(let type): return type.standardButtonText(for: context)
        case .return: return KKL10n.return.text(for: context)
        case .space: return KKL10n.space.text(for: context)
        default: return nil
        }
    }
    
    /**
     The action's standard button text image replacement, if
     the text represents an image asset.
     */
    func standardButtonTextImageReplacement(for context: KeyboardContext) -> Image? {
        switch standardButtonText(for: context) {
        case "↵": return .keyboardNewline
        default: return nil
        }
    }
}

private extension KeyboardAction.PrimaryType {
    
    var standardButtonImage: Image? {
        switch self {
        case .newLine: return .keyboardNewline
        default: return nil
        }
    }
    
    func standardButtonText(for context: KeyboardContext) -> String? {
        switch self {
        case .done: return KKL10n.done.text(for: context)
        case .go: return KKL10n.go.text(for: context)
        case .newLine: return nil
        case .ok: return KKL10n.ok.text(for: context)
        case .search: return KKL10n.search.text(for: context)
        }
    }
}

private extension KeyboardAction {
    
    func standardButtonBackgroundColorForAllStates() -> Color? {
        if case .none = self { return .clear }
        if case .emoji = self { return .clearInteractable }
        if case .emojiCategory = self { return .clearInteractable }
        return nil
    }
    
    func standardButtonBackgroundColorForIdleState(for context: KeyboardContext) -> Color {
        return .standardButton(for: context)
    }
    
    func standardButtonBackgroundColorForPressedState(for context: KeyboardContext) -> Color {
        if isSystemAction { return .white }
        return .standardDarkButton(for: context)
    }
    
    func standardButtonForegroundColorForIdleState(for context: KeyboardContext) -> Color {
        return .standardButtonTint(for: context)
    }
    
    func standardButtonForegroundColorForPressedState(for context: KeyboardContext) -> Color {
        return .standardButtonTint(for: context)
    }
}


struct KeyboardActionButton_Previews: PreviewProvider {
    
    static var context = KeyboardContext.preview
    static var appearance = StandardKeyboardAppearance(context: context)
    
    static var swedishAlphaLower = Image("iPhone12_sv_alphabetic_portrait_lowercase", bundle: .module)
    static var swedishAlphaUpper = Image("iPhone12_sv_alphabetic_portrait", bundle: .module)
    static var swedishNumeric = Image("iPhone12_sv_numeric_portrait", bundle: .module)
    static var swedishSymbolic = Image("iPhone12_sv_symbolic_portrait", bundle: .module)
    
    static var previews: some View {
        Group {
            alphaLowerPreview
            alphaUpperPreview
            numericPreview
        }.previewLayout(.sizeThatFits)
    }
    
    static var alphaLowerPreview: some View {
        swedishAlphaLower
            .resizable()
            .aspectRatio(contentMode: .fit)
            .overlay(view(for: .character("q")).offset(x: -178, y: -85))
            .overlay(view(for: .character("a")).offset(x: -177, y: -30.5))
            .overlay(view(for: .character("ä")).offset(x: 177, y: -30.5))
            .overlay(view(for: .shift(currentState: .lowercased)).offset(x: -170, y: 26))
            .overlay(view(for: .backspace).offset(x: 170, y: 26))
            .overlay(view(for: .keyboardType(.numeric)).offset(x: -171, y: 80.5))
            .overlay(view(for: .keyboardType(.emojis)).offset(x: -122, y: 80))
            .overlay(view(for: .emoji(Emoji("😄"))).offset(x: 0, y: 80))
            .overlay(view(for: .return).offset(x: 147, y: 79))
    }
    
    static var alphaUpperPreview: some View {
        swedishAlphaUpper
            .resizable()
            .aspectRatio(contentMode: .fit)
            .overlay(view(for: .character("Q")).offset(x: -177, y: -81))
            .overlay(view(for: .character("A")).offset(x: -178, y: -27))
            .overlay(view(for: .character("Ä")).offset(x: 177, y: -27))
            .overlay(view(for: .newLine).offset(x: 147, y: 79))
    }
    
    static var numericPreview: some View {
        swedishNumeric
            .resizable()
            .aspectRatio(contentMode: .fit)
            .overlay(view(for: .character("1")).offset(x: -176, y: -81))
            .overlay(view(for: .character("-")).offset(x: -176, y: -28))
            .overlay(view(for: .character("/")).offset(x: -136, y: -28))
            .overlay(view(for: .character("kr")).offset(x: 58, y: -28))
            .overlay(view(for: .keyboardType(.symbolic)).offset(x: -170, y: 27))
            .overlay(view(for: .keyboardType(.alphabetic(.neutral))).offset(x: -171, y: 81))
            .overlay(view(for: .character("↵")).offset(x: 147, y: 79))
    }
    
    static func view(for action: KeyboardAction) -> some View {
        let image = action.standardButtonImage(for: context)
        let text = action.standardButtonText(for: context) ?? ""
        return Group {
            if image != nil {
                image
            } else {
                Text(text)
            }
        }
        .font(action.standardButtonFont(for: context))
        .environment(\.sizeCategory, .medium)
        .foregroundColor(.red)
    }
}
