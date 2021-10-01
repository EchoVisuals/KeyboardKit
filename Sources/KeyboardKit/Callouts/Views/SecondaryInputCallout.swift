//
//  SecondaryInputCallout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This callout can be used to present secondary input actions
 for a keyboard actions.
 */
public struct SecondaryInputCallout: View {
    
    public init(style: SecondaryInputCalloutStyle) {
        self.style = style
    }
    
    @EnvironmentObject private var context: SecondaryInputCalloutContext
    
    private let style: SecondaryInputCalloutStyle
    
    public var body: some View {
        VStack(alignment: context.alignment, spacing: 0) {
            callout
            buttonArea
        }
        .font(style.font)
        .compositingGroup()
        .position(x: positionX, y: positionY)
        .calloutShadow(style: calloutStyle)
        .opacity(context.isActive ? 1 : 0)
        .onTapGesture(perform: context.reset)
    }
}


// MARK: - Private Properties

private extension SecondaryInputCallout {
    
    var backgroundColor: Color { calloutStyle.backgroundColor }
    var buttonFrame: CGRect { context.buttonFrame.insetBy(dx: buttonInset.width, dy: buttonInset.height) }
    var buttonInset: CGSize { calloutStyle.buttonOverlayInset }
    var buttonSize: CGSize { buttonFrame.size }
    var calloutInputs: [String] { context.actions.compactMap { $0.input } }
    var calloutStyle: CalloutStyle { style.callout }
    var cornerRadius: CGFloat { calloutStyle.cornerRadius }
    var curveSize: CGSize { calloutStyle.curveSize }
    var isLeading: Bool { context.isLeading }
    var isTrailing: Bool { context.isTrailing }
    
    var buttonArea: some View {
        CalloutButtonArea(frame: buttonFrame, style: calloutStyle)
    }
    
    var callout: some View {
        HStack(spacing: 0) {
            ForEach(Array(calloutInputs.enumerated()), id: \.offset) {
                Text($0.element)
                    .frame(buttonSize)
                    .background(isSelected($0.offset) ? style.selectedBackgroundColor : .clear)
                    .foregroundColor(isSelected($0.offset) ? style.selectedTextColor : style.callout.textColor)
                    .cornerRadius(cornerRadius)
                    .padding(.vertical, style.verticalPadding)
            }
        }
        .padding(.horizontal, curveSize.width)
        .background(calloutBackground)
    }
    
    var calloutBackground: some View {
        CustomRoundedRectangle(
            topLeft: cornerRadius,
            topRight: cornerRadius,
            bottomLeft: isLeading ? 4 : cornerRadius,
            bottomRight: isTrailing ? 2 : cornerRadius)
            .foregroundColor(backgroundColor)
    }
    
    var positionX: CGFloat {
        let buttonWidth = buttonSize.width
        let adjustment = (CGFloat(calloutInputs.count) * buttonWidth)/2
        let signedAdjustment = isTrailing ? -adjustment + buttonWidth : adjustment
        return buttonFrame.origin.x + signedAdjustment
    }
    
    var positionY: CGFloat {
        buttonFrame.origin.y - style.verticalPadding
    }
}


// MARK: - Private Functions

private extension SecondaryInputCallout {
    
    func isSelected(_ offset: Int) -> Bool {
        context.selectedIndex == offset
    }
}


// MARK: - Private Extensions

private extension KeyboardAction {
    
    var input: String? {
        switch self {
        case .character(let char): return char
        default: return nil
        }
    }
}

struct SecondaryInputCallout_Previews: PreviewProvider {
    
    static let context = SecondaryInputCalloutContext(
        actionHandler: .preview,
        actionProvider: PreviewSecondaryCalloutActionProvider())
    
    static var previews: some View {
        VStack {
            Color.red.frame(width: 40, height: 50)
                .overlay(
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                context.updateInputs(
                                    for: .character("S"),
                                    in: geo,
                                    alignment: .trailing
                                )
                            }
                    }
                )
        }
        .secondaryInputCallout(style: .standard)
        .environmentObject(context)
    }
}
