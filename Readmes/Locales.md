# Locales

KeyboardKit defines keyboard-specific locales and provides localized content for the supported locales.


## Keyboard Locale

KeyboardKit has a `KeyboardLocale` enum with these locales:

* 🇺🇸 English (US - Default)

* 🇩🇰 Danish
* 🇳🇱 Dutch
* 🇬🇧 English (UK)
* 🇺🇸 English (US)
* 🇫🇮 Finnish
* 🇫🇷 French
* 🇩🇪 German
* 🇮🇹 Italian
* 🇳🇴 Norwegian
* 🇸🇪 Swedish
* 🇪🇸 Spanish

More locales will be added in the future.


## Localized strings

KeyboardKit has a `KKL10n` enum that provides localized texts for all locales. These texts are used to localize certain buttons, labels etc.

Localized texts are managed under `Sources/Resources`.


## Adding new locales

Keyboard locales does not just involve localized strings.

Adding a new locale to KeyboardKit requires the following:

* Define the new `KeyboardLocale` case
* Define its properties, like `flag`, `isLeftToRight` etc.
* Provide a `Resources/<id>.lproj` folder.
* Implement a custom `KeyboardInputSetProvider`.
* Implement a custom `SecondaryCalloutActionProvider`.

If the locale has a keyboard layout that differs from the English 10-9-7 layout or the German 11-11-7 layouts, a new `KeyboardLayoutProvider` must be specified.

Custom keyboard locales must ensure that the keyboard layout is correct for:

* locale
* iPhone portrait
* iPhone landscape
* iPad portrait
* iPad landscape  

This involves specifying margins, system actions etc. to make the keyboard behave correctly for all these cases.


## KeyboardKit Pro

KeyboardKit Pro defines input sets and secondary actions for all keyboard locales.

[Read more here][Pro] regarding how to obtain a KeyboardKit Pro license. 


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
