![Icon](icons/icon32.png)

# Pseudo Pins

A Chrome extension that automatically rearranges tabs based on a set of regular
expressions provided by the user. This mimics, in a way, the "pin" behavior
built into Chrome since tabs that match a given expression are moved as far to
the left as possible and grouped together.

The extension attempts, within reason, to maintain its arrangements.

## Building

Version 2 is being rewritten in Dart. You'll need a working
[Dart](https://www.dartlang.org/) tool chain to build it. Once you've got that,
you can build the extension easily:

```
pub build extension
```

The JavaScript files and everything else needed to use the extension in Chrome
will end up in `build/extension`.

![Screenshot](screenshot0.png)

## Credits

Extension created by George Lesica (<george@lesica.com>).

Pin icon created by [Joe Harrison](https://thenounproject.com/joe_harrison/).
Retrieved from The Noun Project and modified, licensed CC-BY.

Question mark icon created by [Mateo
Zlatar](https://thenounproject.com/mateozlatar/). Retrieved from The Noun
Project, licensed CC-BY.
