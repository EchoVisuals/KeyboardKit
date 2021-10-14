# KeyboardKit

<p align="center">
    <img src ="Resources/Logo.png" width=600 />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/KeyboardKit/KeyboardKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/cocoapods/p/KeyboardKit.svg?style=flat" alt="Platform" />
    <img src="https://img.shields.io/badge/Swift-5.3-orange.svg" alt="Swift 5.3" />
    <img src="https://img.shields.io/github/license/KeyboardKit/KeyboardKit" alt="MIT License" />
    <a href="https://twitter.com/danielsaidi">
        <img src="https://img.shields.io/badge/contact-@danielsaidi-blue.svg?style=flat" alt="Twitter: @danielsaidi" />
    </a>
</p>



## About KeyboardKit

KeyboardKit is a Swift library that helps you create custom keyboard extensions for `iOS` and `iPadOS` using `SwiftUI`. 

The end result can look something like this...or entirely different:

<p align="center">
    <img src ="Resources/Demo.gif" width="300" />
</p>

KeyboardKit lets you create rich system keyboards with support for multiple locales, gestures, callouts etc. 

If you're new to iOS keyboard extensions, [this great guide][Guide] will help you get started. You can also have a look at the demo app for inspiration.



## Installation

### Swift Package Manager

```
https://github.com/KeyboardKit/KeyboardKit.git
```

### CocoaPods

```ruby
target 'MyApp' do
  pod 'KeyboardKit'
end

target 'MyKeyboard' do
  pod 'KeyboardKit'
end

post_install do |installer|
   installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
          config.build_settings['APPLICATION_EXTENSION_API_ONLY'] = 'No'
      end
   end
end
```



## Getting Started

To build a keyboard extension with KeyboardKit, first add `KeyboardKit` to your app's keyboard extension as shown above. You can add it to the main app target as well, if you want to use it there.

Then, inherit `KeyboardInputViewController` instead of `UIInputViewController`. It provides you with a lot of additional functionality, e.g. new lifecycle functions, observables like `keyboardContext` and services like `keyboardActionHandler`, `keyboardAppearance`, autocomplete logic etc.  

`KeyboardInputViewController` will call `viewWillSetupKeyboard` whenever the keyboard must be created or re-created. You can use `setup(with:)` in that function, to setup your extension with any `SwiftUI` view. 

Setting up the view controller with a SwiftUI view will make the view the main view of the extension, inject necessary environment objects and resize the keyboard extension to fit the view.

Have a look at the demo application and read more below to see how it all fits together.



## 🇸🇪 Localization

KeyboardKit is localized in the following languages:

* 🇺🇸 English (US - Default)

* 🇩🇰 Danish
* 🇳🇱 Dutch
* 🇬🇧 English (UK)
* 🇫🇮 Finnish
* 🇫🇷 French
* 🇩🇪 German
* 🇮🇹 Italian
* 🇳🇴 Norwegian
* 🇪🇸 Spanish
* 🇸🇪 Swedish

KeyboardKit also supports localized keyboards, where the keyboard layout, secondary actions etc. behave just like they should for a certain locale.

[Read more here][Localization]



## Features 

Even though KeyboardKit contains a lot of features, you can use its' extensions and views alone to simplify working with keyboard extensions. For instance, there are a bunch of `UITextDocumentProxy` extensions that make your life easier, and views that don't require you to use the rest of the library. 

Check out the demo apps and source code for examples and more information.


### 💥 Actions

KeyboardKit comes with many keyboard-specific actions, like `character` inputs, `emojis`, `backspace`, `space`, `newline`, `image` etc. You can even create your own actions.

[Read more here][Actions]


### 🎨 Appearance

KeyboardKit comes with an appearance engine that lets you easily style your keyboards.

[Read more here][Appearance]


### 🔊 Audio

KeyboardKit defines system audio types and ways to play them.

[Read more here][Audio-Feedback]


### 💡Autocomplete

KeyboardKit can present autocomplete suggestions as users type.

[Read more here][Autocomplete]


### 🗯 Callouts

KeyboardKit lets you show input callouts as users type, as well as secondary action callouts with secondary input actions.

[Read more here][Callouts]


### 😊 Emojis

KeyboardKit defines emojis and emoji categories that you can use in your own keyboards.

[Read more here][Emojis]


### 🧩 Extensions

KeyboardKit provides a bunch of extensions to native types.

[Read more here][Extensions]


### ⌨️ External Keyboards

KeyboardKit lets you detect whether or not an external keyboard is used.

[Read more here][External]


### 👋 Feedback

KeyboardKit keyboards can give audio and haptic feedback as users type. 

Read more about [audio feedback][Audio-Feedback] and [haptic feedback][Haptic-Feedback].


### 👆 Gestures

KeyboardKit comes with keyboard-specific gestures that you can use in your own keyboards.

[Read more here][Gestures]


### 👋 Haptics

KeyboardKit defines haptic feedback types and ways to trigger them.

[Read more here][Haptic-Feedback]


### 🔤 Input

KeyboardKit comes with an input set engine that make it easy to create `alphabetic`, `numeric` and `symbolic`  keyboards in different languages.

[Read more here][Input-Sets]


### ⌨️ Keyboard Layouts

KeyboardKit comes with a layout engine that makes it easy to create specific keyboard layouts for various devices, orientations and locales.

[Read more here][Keyboard-Layouts]


### 💱 Keyboard Types

KeyboardKit comes with many different keyboard types, like `alphabetic`, `numeric`, `symbolic`, `emoji` etc. You can even create your own types.

[Read more here][Keyboard-Types]


### 🌐 Locales

KeyboardKit defines keyboard-specific locales and provides localized content for the supported locales.

[Read more here][Locales]


### 👁 Previews

KeyboardKit defines a bunch of preview-specific types that simplify previewing keyboard views in SwiftUI.

[Read more here][Previews]


### ➡️ Proxy

KeyboardKit defines a bunch of extensions to `UITextDocumentProxy` and ways to route text to other sources.

[Read more here][Proxy]


### 🎨 Styles

KeyboardKit defines a bunch of styles that simplify customizing the look of various keyboard components and buttons.

[Read more here][Styles]


### 🖼 Views

KeyboardKit comes with a bunch of keyboard-specific views:

* `Autocomplete` contains autocomplete toolbars and toolbar items.
* `Callouts` contains input and secondary input callout views.
* `Emojis` contains various emoji keyboards and keyboard components.
* `Input` contains text inputs that can be used in a keyboard extension.
* `System` contains views that can be used to mimic native systme keyboards. 
* `KeyboardGrid` can be used to evenly space a set of views in a grid.
* `NextKeyboardButton` can be used to switch to the next keyboard.

You can also use these views without using the rest of KeyboardKit.



## Demo Application

This repository contains a demo app that demonstrates different keyboards, like `alphabetical` (lowercased, uppercased and capslocked), `numerical`, `symbols`, `emojis` and `images`. 

The demo app is not intended to be production ready, but rather to give you inspiration to how you can build your own keyboards. Just keep in mind that your keyboards can look anyway you like. They don't have to look like a system keyboard.

To run the demo app, open and run the `Demo/Demo.xcodeproj` project, then enable the keyboards under system settings. Enable full access to support all features, like audio and haptic feedback.

Note that you may have to update the KeyboardKit dependencies for the demo to run. If so, you can do that under `File/Swift Packages/Update to Latest Package Versions`.



## KeyboardKit Pro

KeyboardKit Pro is a license-based extensions that unlocks pro features, such as additional locales and an autocomplete engine. Going pro is also a way to support this project. 

[Go Pro here!][Pro]



## Contact

Feel free to reach out if you have questions or if you want to contribute in any way:

* E-mail: [daniel.saidi@gmail.com][Email]
* Twitter: [@getkeyboardkit][Twitter]
* Web site: [getkeyboardkit.com][Website]


## Sponsors and Clients

This project is proudly sponsored by the following individuals and companies:

* [@booch](https://github.com/booch)

<a href="https://www.oribi.se/en">
    <img src="Resources/logos/oribi.png" alt="Oribi Logo" title="Oribi" width=150 />
</a>
<a href="http://anomaly.net.au">
    <img src="Resources/logos/anomaly.png" alt="Anomaly Software Logo" title="Anomaly Software" width=150 />
</a>
<a href="https://www.milocreative.com">
    <img src="Resources/logos/milo.png" alt="Milo Creative Logo" title="Milo Creative" width=150 />
</a>

You can support KeyboardKit by sponsoring the project on [GitHub Sponsors][Sponsors], signing up for a [KeyboardKit Pro][Pro] license or hiring me for consultation.



## License

KeyboardKit is available under the MIT license. See LICENSE file for more info.


[Email]: mailto:daniel.saidi@gmail.com
[Twitter]: https://twitter.com/getkeyboardkit
[Website]: https://getkeyboardkit.com
[Sponsors]: https://github.com/sponsors/danielsaidi

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

[Actions]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Actions.md
[Appearance]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Appearance.md
[Audio-Feedback]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Audio-Feedback.md
[Autocomplete]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Autocomplete.md
[Callouts]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Callouts.md
[Emojis]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Emojis.md
[Extensions]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Extensions.md
[External]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/External.md
[Gestures]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Gestures.md
[Haptic-Feedback]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Haptic-Feedback.md
[Input-Sets]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Input-Sets.md
[Keyboard-Layouts]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Keyboard-Layouts.md
[Keyboard-Types]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Keyboard-Types.md
[Locales]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Locales.md
[Previews]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Previews.md
[Proxy]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Proxy.md
[Styles]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Styles.md

[Guide]: https://shyngys.com/ios-custom-keyboard-guide
