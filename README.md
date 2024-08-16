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

### How To Use
#### GoToScene(SceneName, Folder = "Scene")
  
  You can use this function to transition between scenes, this increases code readability and helps you understanding whick scene in the target.
  
  **1- Standard format:**
  
  	If you save your .tscn files in the "res://Scene/" path, just put the target file name:
   
  	```
	SLib.GoToScene(Game)
	```
 
  	The code above works exactly like the code below:
    

### Last Version
V1.0.0 Alpha (Pre-release) - [Last Alpha](https://github.com/Subject-Team/Subject-Library/releases/tag/AlphaReleases)
