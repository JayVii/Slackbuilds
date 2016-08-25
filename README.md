Slackbuilds
===========

Slackbuilds for various Applications
Queues for SBOPKG (https://sbopkg.org)


### Content

Folder `SBoPKGs/` contains queue-files to be used with [SBOPKG](https://sbopkg.org) in order to compile and install packages from [Slackbuilds.org](https://slackbuilds.org). The queue-files also contain build-options that may be used along with the queue.
Additionally, each queue-file also has a text-file with the same name, which briefly describes the main-application.

- - -

Folder `Slackbuilds/` contains several Slackbuilds in the style of the ones found on [Slackbuilds.org](https://slackbuilds.org) or on [Alien-Bob's Repository](http://www.slackware.com/~alien/slackbuilds/).
Its `pkg/` directory contains a pre-compiled binary - **USE AT YOUR OWN RISK**.
The *safer* way is to build it yourself with the help of the Slackbuild in the `build/` directory. That one also contains a `*.get-SB.sh` script which can be used to fetch all necessary build-files (\*.SlackBuild, \*.desc and the source-code or convertable binary).

#### Slackbuilds-Sidenote
The name of the folders inside `Slackbuilds/` represent packages. Folders with a _~bin_ attached are Slackbuilds that do not build from sourcecode, but converting already compiled packages into Slackware-conform _.tgz_ archives.
Example: `Slackbuilds/min~bin/`


### Structure
```
|- README.md
|
|- SBoPKGs/
|  |- *.txt
|  '- *.sqf
|
'- Slackbuilds/
   |- .../
   |  |- pkg64/
   |  |  '-%VER%/
   |  |    |- *.lst
   |  |    |- *.meta
   |  |    |- *.txt
   |  |    |- *.asc
   |  |    |- *.md5
   |  |    |- *.sha256
   |  |    '- *.tgz
   |  |
   |  '- build/
   |     |- *.SlackBuild
   |     |- *.desc
   |     '- *.get-SB.sh
   |
   '- .../
```
