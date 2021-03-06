//
//  KeyboardEnabledState.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-18.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import Combine
import UIKit

/**
 This state class implements `KeyboardEnabledStateInspector`
 by keeping a published `isKeyboardEnabled` in sync with the
 state of the associated keyboard.
 
 This class will call `refresh` whenever the app or keyboard
 extension becomes active.
 */
public class KeyboardEnabledState: KeyboardEnabledStateInspector, ObservableObject {
    
    /**
     Create an instance of this observable state class.
     
     When you call this function, make sure that you use the
     `bundleId` of the keyboard extension, not the app.
     
     - Parameters:
       - bundleId: The bundle id of the keyboard extension.
       - notificationCenter: The notification center to use to observe changes.
     */
    public init(
        bundleId: String,
        notificationCenter: NotificationCenter = .default) {
        self.bundleId = bundleId
        self.notificationCenter = notificationCenter
        self.activePublisher.sink(receiveValue: { [weak self] _ in
            self?.refresh()
        }).store(in: &cancellables)
        refresh()
    }
    
    private let bundleId: String
    private var cancellables = Set<AnyCancellable>()
    private let notificationCenter: NotificationCenter
    
    /**
     Whether or not the keyboard with the provided bundle id
     is enabled in system settings.
     */
    @Published public var isKeyboardEnabled: Bool = false
    
    /**
     Sync `isKeyboardEnabled` with the state of the keyboard
     with the provided bundle id.
     */
    public func refresh() {
        isKeyboardEnabled = isKeyboardEnabled(withBundleId: bundleId)
    }
}

private extension KeyboardEnabledState {
    
    var activePublisher: NotificationCenter.Publisher {
        publisher(for: UIApplication.didBecomeActiveNotification)
    }
    
    func publisher(for notification: Notification.Name) -> NotificationCenter.Publisher {
        notificationCenter.publisher(for: notification)
    }
}
