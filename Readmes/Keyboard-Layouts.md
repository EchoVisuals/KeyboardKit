# Keyboard Layouts

KeyboardKit comes with a layout engine that makes it easy to create specific keyboard layouts for various devices, orientations and locales.


## Keyboard Layout

KeyboardKit has a `KeyboardLayout` struct that represents the complete set of actions on a keyboard.

Native keyboards like alphabetic, numeric and symbolic keyboards, are made up of a basic `input set`, surrounded by system buttons. All these actions, together with their sizes, insets and positions, make up the total `keyboard layout`.


## Keyboard layout providers

KeyboardKit has a `KeyboardLayoutProvider` protocol that can be used to provide layouts to the extension. 

Using a layout provider instead of creating layouts manually gives you a dynamic way of working with layouts.

`KeyboardInputViewController` will automatically create a `StandardKeyboardLayoutProvider` when the extension is started. You can use it as is or replace it with a custom provider.

Implementing a custom provider is tricky, since you must account for the locale, device, orientation etc.


## Input set vs. keyboard layout

A *keyboard input set* is the characters that make up the input part of a keyboard.

A *keyboard layout* is the actions that make up the complete keyboard, together with layout-specific information.


## Supporting more devices, orientations etc.

The `StandardKeyboardLayoutProvider` is initialized with a few device-specific providers that are included in this library. 

At the time of writing, this gives you basic support for `iPhone` and `iPad`-specific layouts.

However, `iPhoneKeyboardLayoutProvider` and `iPadKeyboardLayoutProvider` are not perfect and will not create a pixel-perfect layout for all devices, orientations and locales. 

If you aim for pixel perfection, you will therefore probably have to customize the existing layout approach. Here are some ways to do so:

* Replace the view controller's `keyboardLayoutProvider` with a custom provider, as described above.
* Subclass `StandardKeyboardLayoutProvider` and override  `keyboardLayout(for:)`.
* Replace `StandardKeyboardLayoutProvider`'s `iPadProvider` with a custom provider.
* Replace `StandardKeyboardLayoutProvider`'s `iPhoneProvider` with a custom provider.
* Subclass `iPhoneKeyboardLayoutProvider` and override any parts you'd like to change.
* Subclass `iPadKeyboardLayoutProvider` and override any parts you'd like to change.  

I will gladly accept any PRs that improve the layout providers in this library. 👍


## Optional

It's worth mentioning that keyboard layouts is just a convenience. KeyboardKit doesn't force you to use keyboard layouts. Your keyboard extensions can look and behave however you want.
