# Subject-Library
 SLib (Subject Library) is a Godot library that provides Godot capabilities in a simpler way.

### How To Install
For start using SLib:

1- Save SLib.gd in root directory of your project

2- Go to Project Setting/Auto Load and add "res://SLib.gd" with "SLib" Name

3- Add this code in top of all GDScript files:
```
var SLib

func _ready():
	SLib = get_node("/root/SLib")
```
Now you can use SLib functions in this format: SLib.FunctionName(Parameters)

### Available Functions
- GoToScene()
- SetProjectSetting()
- GetProjectSetting()
- Reload()
- Exit()
- Wait()
- SaveFile()
- LoadFile()
- BackupFile()
- SendError()
- SendWarning()
- SendAlert()
- SaveLog()
- OSDefaultOpen()
- FullPath()

### Last Version
V1.0.0 Alpha (Pre-release) - [Last Alpha](https://github.com/Subject-Team/Subject-Library/releases/tag/AlphaReleases)
