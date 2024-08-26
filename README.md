# Subject-Library
Useful Codes For GDScript

## Overview
SLib is a Godot library designed to simplify and enhance your development experience. It provides a set of ready-to-use, standard codes that eliminate the need to write repetitive and lengthy scripts. SLib is lightweight, easy to install, and helps make your code more readable and maintainable.

## Key Features

- **Lightweight**: Requires minimal space in your application (less than 100KB).
- **Easy Installation**: Simple setup process to get you started quickly.
- **Code Readability**: Transforms complex and unreadable code into clear and understandable expressions.
- **Efficiency**: Reduces the need for duplicate code and allows execution of multiple lines with a single command.
- **Standardization**: Provides standard methods for common tasks, optimizing your app for any platform.

## Why use?
- SLib need very small space in your application (now less than 100KB)
- SLib installation is very easy
- With SLib you can make unreadable codes readable quickly
- You will not need to write duplicate sections
- You can execute multiple lines of code with one line
- It replaces incomprehensible parts with useful and comprehensible expressions
- It gives you standard ways to do certain thing
- Optimizes your app export for any platform

## How To Install
To start using SLib, follow these steps:

1. **Save the SLib Script**: Download `SLibFull.zip` and extract it in the root directory of your project. [Download releases](https://github.com/Subject-Team/SLib/releases)
2. **Check extraction**: If files save in ``res://SLib/SLib.gd`` and ``res://SLib/SLibSettings.gd`` extraction is correct.
3. **Auto Load Setup**: Go to Project Settings > Auto Load, and add `res://SLib/SLib.gd` with the name `SLib` and `res://SLib/SLibSettings.gd` with the name `SLibSettings`.

Now you can use SLib functions in your scripts like this:
```
SLib.FunctionName(parameters)
```

## Available Functions
- Appear()
- BackupFile()
- Disappear()
- Exit()
- FindChildOfClass()
- FullPath()
- GetLog()
- GetProjectSetting()
- GoToScene()
- LoadFile()
- MergeUnique()
- OSOpen()
- PauseChange()
- Reload()
- ReverseDict()
- SaveFile()
- SaveLog()
- SendAlert()
- SendError()
- SendWarning()
- SetProjectSetting()
- Wait()
- expDecay()

## How To Use
Install project, press F1 and search `SLib` or `SLibSetting` to see docs.

## Automation
See [Automation wiki page](https://github.com/Subject-Team/SLib/wiki/Automation) for automation SLib.

## Documentation

For detailed documentation and examples, visit our [GitHub repository](https://github.com/Subject-Team/SLib).

## Community and Support

Join our community to share your experiences, ask questions, and get support from other SLib users. Check out our [GitHub repository](https://github.com/Subject-Team/SLib) for the latest updates and contributions.

[Godot forum page](https://forum.godotengine.org/t/slib-library-for-useful-codes/77760/1)

## Contribute
If you want to contribute to this project and extend the library, please fork the repository and submit a pull request. Or you can open an issue to discuss what you want to change.
For help, see the [project's wiki guide](https://github.com/Subject-Team/SLib/wiki/Contribute-guide), or use the [Q&A page](https://github.com/Subject-Team/SLib/discussions/categories/q-a).

## Thanks
[snipercup](https://github.com/snipercup) for:
- Add MergeUnique function
- Declaration FullUnique parameter for MergeUnique function

[gertkeno](https://forum.godotengine.org/u/gertkeno/summary) for:
- Add FindChildOfClass function
- Add expDecay function
- [Bug report](https://github.com/Subject-Team/SLib/issues/5)
- [Correction documentation](https://github.com/Subject-Team/SLib/issues/6)

[Locher](https://forum.godotengine.org/u/Locher) for:
- Add ChangePause function
- Add Appear function
- Add Disappear function

[AlexanderLife](https://forum.godotengine.org/u/AlexanderLife) for:
- Add ReverseDict function

## Versions
[V1.0.3 - Beta2](https://github.com/Subject-Team/SLib/releases/tag/1.0.3-B2)

[V1.0.3 - Beta1](https://github.com/Subject-Team/SLib/releases/tag/1.0.3-B1)

[V1.0.2 - Stable](https://github.com/Subject-Team/SLib/releases/tag/1.0.2-S)

[V1.0.1 - Stable](https://github.com/Subject-Team/SLib/releases/tag/1.0.1-S)

[V1.0.0 - Stable](https://github.com/Subject-Team/SLib/releases/tag/1.0.0-S)
