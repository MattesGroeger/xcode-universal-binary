[![endorse](http://api.coderwall.com/mattesgroeger/endorsecount.png)](http://coderwall.com/mattesgroeger)

What it does
------------

Builds an `iphoneos` (Device) and `iphonesimulator` (Simulator) binary using `xcodebuild` (comes with Xcode). The two binaries get merged afterwards using `lipo`. It also copies eventually existing header files in the result directory.

Usage
-----

1. Do `git clone git@github.com:MattesGroeger/xcode-universal-binary.git` wherever you want to have the shell script reside.
2. Navigate to the repository `cd xcode-universal-binary`.
3. Grant executable rights: `chmod a+x universal_binary.sh`.
4. Add the `universal_binary.sh` to your `PATH` (e.g. in .bash_profile).
5. Navigate to the project you want to create a universal binary of.
6. Call `universal_binary.sh {target} {lib.a}` where you have to replace `{target}` with the Xcode target and `{lib.a}` with the target library name.

Hint
----

This version only creates the `Release` configurations.

Credits
-------

Thanks to [Eonil](http://stackoverflow.com/users/246776/eonil) who did the basic work in [this stackoverflow post](http://stackoverflow.com/a/3616733).
