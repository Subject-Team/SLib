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
 
**1- Standard format: (Recommended)**

If you save your .tscn files in the "res://Scene/" path, just put the target file name:
```
SLib.GoToScene("Game")	
```
The code above works exactly like the code below:
```
get_tree.change_scene_to_file("res://Scene/Game.tscn")
```

**2- Root folder:**

If you save .tscn files in "res://", use the Folder parameter and set it to "/root":
```
SLib.GoToScene("Game", "/root")
```
This code replaces the following code:
````
get_tree.change_scene_to_file("res://Game.tscn")
````
**3- Custom folder:**

You can also choose the folder where you saved your scene:
````
SLib.GoToScene("Game", "My Scenes")
````
In this way, the following code will be executed:
````
get_tree.change_scene_to_file("res://My Scenes/Game.tscn")
````
> [!NOTE]
> You can also call nested folders, for example: "Scenes/Old Files"

#### SetProjectSetting(Path, Variable)
This function changes the project settings, for this it needs two parameters:

1- **Path:** can use Ctrl+Shift+C on property of project settings window

2- **Variable:** this parameter set to selected property
````
SLib.SetProjectSetting("application/config/windows_native_icon", "res://icon.ico")
````

#### GetProjectSetting(Path)

This function returns the variable stored in the desired property, its use is as follows:
````
MyVar = GetPrjectSetting("application/config/windows_native_icon") 

### Last Version
V1.0.0 Alpha (Pre-release) - [Last Alpha](https://github.com/Subject-Team/Subject-Library/releases/tag/AlphaReleases)
