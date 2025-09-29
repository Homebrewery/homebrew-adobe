_[Homebrew]_ Adobe
==================
Homebrew _[tap]_ for [Adobe] apps, and even [plugins]!

Install
-------
~~~ sh
brew tap Homebrewery/adobe
brew install #cask #formula
~~~

[Some] [_Cask_]s rely on an [environment variable] to function, which can be set in your [shell startup file], for example: `export HOMEBREW_ADOBE_CASK=value >> ~/.bashrc`. Further information will be displayed as [`caveats`], which are always available by running `brew info cask`.

[Contribute][guide]
-------------------
`git config core.hooksPath .github/hooks` and follow the contribution [guide], or copy and adapt an [existing] Cask or _[formula]_.

License
-------
[MIT] © [Daniel Bayley]

[MIT]:                    LICENSE.md
[Daniel Bayley]:          https://github.com/danielbayley

[adobe]:                  https://adobe.com
[plugins]:                https://exchange.adobe.com/addons

[homebrew]:               http://brew.sh
[tap]:                    https://docs.brew.sh/Taps
[_cask_]:                 http://caskroom.github.io

[guide]:                  https://github.com/caskroom/homebrew-cask/blob/master/doc/development/adding_a_cask.md
[existing]:               Casks
[some]:                   https://github.com/Homebrewery/homebrew-adobe/blob/master/Casks/rubberhose.rb#L20-L21
[`caveats`]:              https://github.com/caskroom/homebrew-cask/blob/master/doc/cask_language_reference/stanzas/caveats.md#caveats

[environment variable]:   https://en.wikipedia.org/wiki/environment_variable
[shell startup file]:     https://en.wikipedia.org/wiki/Unix_shell#Configuration_files
