//
//  SystemKeyboardButtonRowItem.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view is meant to be used within a `SystemKeyboard` and
 will apply the correct frames and paddings, to mitigate any
 dead tap areas that would exist if a system keyboard placed
 its buttons with margins between the buttons and rows.
 */
public struct SystemKeyboardButtonRowItem<Content: View>: View {
    
    /**
     Create a system keyboard button row item.
     
     - Parameters:
       - content: The content view to use within the item.
       - item: The layout item to use within the item.
       - context: The keyboard context to which the item should apply.
       - keyboardWidth: The total width of the keyboard.
       - inputWidth: The input width within the keyboard.
       - appearance: The appearance to apply to the item.
       - actionHandler: The button style to apply.
     */
    public init(
        content: Content,
        item: KeyboardLayoutItem,
        context: KeyboardContext,
        keyboardWidth: CGFloat,
        inputWidth: CGFloat,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler) {
        self.content = content
        self.item = item
        self.context = context
        self.keyboardWidth = keyboardWidth
        self.inputWidth = inputWidth
        self.appearance = appearance
        self.actionHandler = actionHandler
    }
    
    private let content: Content
    private let item: KeyboardLayoutItem
    private var context: KeyboardContext
    private let keyboardWidth: CGFloat
    private let inputWidth: CGFloat
    private let appearance: KeyboardAppearance
    private let actionHandler: KeyboardActionHandler
    
    @State private var isPressed = false
    
    public var body: some View {
        content
            .frame(maxWidth: .infinity)
            .frame(height: item.size.height - item.insets.top - item.insets.bottom)
            .rowItemWidth(for: item, totalWidth: keyboardWidth, referenceWidth: inputWidth)
            .systemKeyboardButtonStyle(buttonStyle)
            .padding(item.insets)
            .background(Color.clearInteractable)
            .keyboardGestures(
                for: item.action,
                context: context,
                actionHandler: actionHandler,
                isPressed: $isPressed)
    }
}

private extension SystemKeyboardButtonRowItem {
    
    var buttonStyle: SystemKeyboardButtonStyle {
        appearance.systemKeyboardButtonStyle(for: item.action, isPressed: isPressed)
    }
}

public extension View {
    
    /**
     Apply a certain layout width to the view, in a way that
     works with the rot item composition above.
     */
    @ViewBuilder
    func rowItemWidth(for item: KeyboardLayoutItem, totalWidth: CGFloat, referenceWidth: CGFloat) -> some View {
        let insets = item.insets.leading + item.insets.trailing
        switch item.size.width {
        case .available: self.frame(maxWidth: .infinity)
        case .input: self.frame(width: referenceWidth - insets)
        case .inputPercentage(let percent): self.frame(width: percent * referenceWidth - insets)
        case .percentage(let percent): self.frame(width: percent * totalWidth - insets)
        case .points(let points): self.frame(width: points - insets)
        }
    }
}

struct SystemKeyboardButtonRowItem_Previews: PreviewProvider {
    
    static func previewItem(_ text: String, width: KeyboardLayoutItemWidth) -> some View {
        SystemKeyboardButtonRowItem(
            content: Text(text),
            item: KeyboardLayoutItem(
                action: .backspace,
                size: KeyboardLayoutItemSize(
                    width: width,
                    height: 100),
                insets: .horizontal(0, vertical: 0)),
            context: .preview,
            keyboardWidth: 320,
            inputWidth: 30,
            appearance: .preview,
            actionHandler: PreviewKeyboardActionHandler())
    }
    
    static var previews: some View {
        HStack {
            previewItem("1", width: .inputPercentage(0.5))
            previewItem("2", width: .input)
            previewItem("3", width: .available)
            previewItem("4", width: .percentage(0.1))
            previewItem("5", width: .points(10))
        }
    }
}
