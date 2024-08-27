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

### Step1: Install SLib Main Script 
1. **Get SLib Main Script**: Download and copy `SLib.gd` in your project directory. [Download from releases](https://github.com/Subject-Team/SLib/releases)
2. **AutoLoad Setup**: Go to `Project Settings > Auto Load`, and add `res://SLib.gd` with the name `SLib` in project autoload.

### Step2: Install SLibConfig Plugin
1. **Get SLibConfig**: Download `SLibConfig.zip` from [releases](https://github.com/Subject-Team/SLib/releases).
2. **Import Plugin**: Open your project, go to `AssetLib`, click on `Import...` and import `SLibConfig.zip` file.
3. **Activate Plugin**: Go to `Project > Project Settings > Plugins` and set `SLibConfig` status to enable.

### Step3: Activate Automation
See [here](https://github.com/Subject-Team/SLib/wiki/Automation) for set up automation.

### Step3: Finishing Installation
1. **Reload Project**: To apply changes use `Project > Reload Current Project`.
2. **Check Plugin**: Go to `Project > Project Settings > General` and search `SLib/`, if you have settings in `SLib/` plugin installed.
3. **Check Script**: Open a GDScript file and paste this code in the file and wait a few moments, if you do not receive an error, the installation is complete, and you can erase the code:
```gdscript
func _ready():
    SLib.MergeUnique([2],[3])
```
4. **Check Automation**: Write `Save "Test" in "res://Test.save"` and press enter or right-arrow, if code changed to `SLib.SaveFile("res://Test.save", "Test")` automation setup is correct.

### Finish
Congratulations, now you can use all the features of SLib!

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
Install project, press F1 and search `SLib` to see docs.

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
- Remove FullUnique parameter from MergeUnique
- SLib config advice

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
[V1.0.3 - Stable](https://github.com/Subject-Team/SLib/releases/tag/1.0.3-S)

[V1.0.3 - Beta2](https://github.com/Subject-Team/SLib/releases/tag/1.0.3-B2)

[V1.0.3 - Beta1](https://github.com/Subject-Team/SLib/releases/tag/1.0.3-B1)

[V1.0.2 - Stable](https://github.com/Subject-Team/SLib/releases/tag/1.0.2-S)

[V1.0.1 - Stable](https://github.com/Subject-Team/SLib/releases/tag/1.0.1-S)

[V1.0.0 - Stable](https://github.com/Subject-Team/SLib/releases/tag/1.0.0-S)
