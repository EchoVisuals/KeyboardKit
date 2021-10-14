//
//  CGSize+Device.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-08.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics

/**
 This extension specifies screen sizes, as they are reported
 when the keyboard prints out the size.
 */
extension CGSize {
    
    static let iPadProLargeScreenPortrait = CGSize(width: 1024, height: 1366)
    static let iPadProLargeScreenLandscape = iPadProLargeScreenPortrait.flipped()
    static let iPadProSmallScreenPortrait = CGSize(width: 834, height: 1194)
    static let iPadProSmallScreenLandscape = iPadProSmallScreenPortrait.flipped()
    static let iPadScreenPortrait = CGSize(width: 768, height: 1024)
    static let iPadScreenLandscape = iPadScreenPortrait.flipped()
    
    static let iPhoneProMaxScreenPortrait = CGSize(width: 428, height: 926)
    static let iPhoneProMaxScreenLandscape = iPhoneProMaxScreenPortrait.flipped()
    
    func flipped() -> CGSize {
        CGSize(width: height, height: width)
    }
    
    func isScreenSize(_ size: CGSize) -> Bool {
        self == size || self == size.flipped()
    }
}
