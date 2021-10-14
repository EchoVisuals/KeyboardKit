//
//  KeyboardAction+ButtonTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import SwiftUI

class KeyboardAction_SystemTests: QuickSpec {
    
    override func spec() {
        
        let actions = KeyboardAction.testActions
        var context: KeyboardContext!
        
        var expected: [KeyboardAction]! {
            didSet {
                unexpected = actions
                expected.forEach { action in
                    unexpected.removeAll { $0 == action }
                }
            }
        }
        
        var unexpected: [KeyboardAction]!
        
        beforeEach {
            context = KeyboardContext(controller: MockKeyboardInputViewController())
            unexpected = KeyboardAction.testActions
            expected = []
        }
        
        describe("standard button image") {
            
            func result(for action: KeyboardAction) -> Image? {
                action.standardButtonImage(for: context)
            }
            
            it("is defined for some actions") {
                expected = [
                    .backspace,
                    .command,
                    .control,
                    .dictation,
                    .dismissKeyboard,
                    .image(description: "", keyboardImageName: "", imageName: ""),
                    .keyboardType(.email),
                    .keyboardType(.emojis),
                    .keyboardType(.images),
                    .moveCursorBackward,
                    .moveCursorForward,
                    .newLine,
                    .nextKeyboard,
                    .option,
                    .primary(.newLine),
                    .settings,
                    .shift(currentState: .lowercased),
                    .shift(currentState: .uppercased),
                    .shift(currentState: .capsLocked),
                    .systemImage(description: "", keyboardImageName: "", imageName: ""),
                    .tab
                ]
                expected.forEach { expect(result(for: $0)).toNot(beNil()) }
                unexpected.forEach { expect(result(for: $0)).to(beNil()) }
            }
        }
        
        describe("standard button text") {
            
            func result(for action: KeyboardAction) -> String? {
                action.standardButtonText(for: context)
            }
            
            it("is defined for some actions") {
                expect(result(for: .character("A"))).to(equal("A"))
                expect(result(for: .emoji(Emoji("🛸")))).to(equal("🛸"))
                expect(result(for: .emojiCategory(.animals))).to(equal("🐻"))
                
                expect(result(for: .keyboardType(.alphabetic(.capsLocked)))).to(equal("ABC"))
                expect(result(for: .keyboardType(.alphabetic(.lowercased)))).to(equal("ABC"))
                expect(result(for: .keyboardType(.alphabetic(.uppercased)))).to(equal("ABC"))
                expect(result(for: .keyboardType(.numeric))).to(equal("123"))
                expect(result(for: .keyboardType(.symbolic))).to(equal("#+="))
                expect(result(for: .keyboardType(.custom(named: "")))).to(beNil())
                expect(result(for: .nextLocale)).to(equal("EN"))
                expect(result(for: .primary(.done))).to(equal("done"))
                expect(result(for: .primary(.go))).to(equal("go"))
                expect(result(for: .primary(.ok))).to(equal("OK"))
                expect(result(for: .primary(.search))).to(equal("search"))
                expect(result(for: .return)).to(equal("return"))
                expect(result(for: .space)).to(equal("space"))
                
                expect(result(for: .none)).to(beNil())
                expect(result(for: .backspace)).to(beNil())
                expect(result(for: .command)).to(beNil())
                expect(result(for: .control)).to(beNil())
                expect(result(for: .custom(named: ""))).to(beNil())
                expect(result(for: .dictation)).to(beNil())
                expect(result(for: .dismissKeyboard)).to(beNil())
                expect(result(for: .escape)).to(beNil())
                expect(result(for: .function)).to(beNil())
                expect(result(for: .keyboardType(.email))).to(beNil())
                expect(result(for: .keyboardType(.images))).to(beNil())
                expect(result(for: .moveCursorBackward)).to(beNil())
                expect(result(for: .moveCursorForward)).to(beNil())
                expect(result(for: .newLine)).to(beNil())
                expect(result(for: .nextKeyboard)).to(beNil())
                expect(result(for: .option)).to(beNil())
                expect(result(for: .primary(.newLine))).to(beNil())
                expect(result(for: .shift(currentState: .lowercased))).to(beNil())
                expect(result(for: .shift(currentState: .uppercased))).to(beNil())
                expect(result(for: .shift(currentState: .capsLocked))).to(beNil())
                expect(result(for: .tab)).to(beNil())
            }
        }
    }
}
