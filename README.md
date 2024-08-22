# Subject-Library
 SLib (Subject Library) is a Godot library that provides Godot capabilities in a simpler way.

### What is SLib?
SLib is a set of ready and standard code that makes you unnecessary to write many long and frequently used codes.

### Why use?
- SLib need very small space in your application (now less than 10KB)
- SLib installation is very easy
- With SLib you can make unreadable codes readable quickly
- You will not need to write duplicate sections
- You can execute multiple lines of code with one line
- It replaces incomprehensible parts with useful and comprehensible expressions
- It gives you standard ways to do certain thing
- Optimizes your app export for any platform

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
- OSOpen()
- FullPath()
- MergeUnique()

### How To Use
#### GoToScene
    SLib.GoToScene(SceneName: String, Folder: String = "Scene")

You can use this function to transition between scenes, this increases code readability and helps you understand which scene in the target.

**1- Standard format (Recommended):**

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

#### SetProjectSetting
    SLib.SetProjectSetting(Path: Sting, Value)

This function changes the project settings, for this it needs two parameters:

1- **Path:** can use Ctrl+Shift+C on property of project settings window

2- **Value:** this parameter set to selected property
````
SLib.SetProjectSetting("application/config/windows_native_icon", "res://icon.ico")
````
This can also be used to erase custom project settings. To do this change the setting value to null.

#### GetProjectSetting
    SLib.GetPrjectSetting(Path: Sting)

This function returns the variable stored in the desired property, its use is as follows:
````
MyVar = SLib.GetPrjectSetting("application/config/windows_native_icon") 
````

#### Reload
    SLib.Reload()

This function reloads the current scene, this is just a shortcut to increase code readability.

#### Exit
    SLib.Exit(ExitCode: int = 0)

Quits the application at the end of the current iteration. Argument exit_code can optionally be given (defaulting to 0) to customize the exit status code.

By convention, an exit code of 0 indicates success whereas a non-zero exit code indicates an error.

For portability reasons, the exit code should be set between 0 and 125 (inclusive).

> [!NOTE] 
> On iOS this method doesn't work. Instead, as recommended by the iOS Human Interface Guidelines, the user is 
expected to close apps via the Home button.

#### Wait
    await SLib.Wait(WaitTime: float)

This function creates a break in the program that puts a space between the code befor and after it. (on seconds)
> [!IMPORTANT]
> You must write ```await``` at the beginning of this line for it to work! 

#### SaveFile
    SLib.SaveFile(Location: String, Variable = null)

This function will save a file with a customized path, this is very useful because the file saving process will be 
readable and fast.
> [!TIP]
> For use project directory type ```res://``` and for hidden user data directory use ```user://```.

> [!TIP]
> If you don't select Variable parameter, Variable set to ```null```.

> [!IMPORTANT]
> You should type a format for your file, you can select any format but default format not open in other programs!

#### LoadFile
    Slib.LoadFile(Location: String)

This function returns the content stored in the file, you can use it for all file created by your godot application.
> [!NOTE]
> If the file doesn't exist, it will send an error to the console like this:
> ```SLib.gd:57 @ SendError(): "Can't load from -->file_location<--, file not exists!" From "LoadFile"```

#### BackupFile
    SLib.BackupFile(Location: String, Suffix: String = "Backup")

Backup function create a new file with "/main file name/-/Suffix/" in main file location, if you doesn't select a 
custom suffix, "-Backup" append to file name.
> [!NOTE]
> If the file doesn't exist, it will send an error to the console like this:
> ```SLib.gd:57 @ SendError(): "Can't load from -->file_location<--, file not exists!" From "BackupFile"```

> [!NOTE]
> If Suffix set to "", it will send an error to the console like this:
> ```SLib.gd:57 @ SendError(): "Need Suffix option" From "BackupFile"```

#### SendError
    SLib.SendError(Error: String = "Error", From: String = "null")

Sends a custom error to the console that can be viewed in the engine debugger, error like this:
```SLib.gd:57 @ SendError(): -->Error<-- From -->From<--```

#### SendWarning
    SLib.SendWarning(Warning: String = "Warning", From: String = "null")

Sends a custom warning to the console that can be viewed in the engine debugger like this:
```SLib.gd:60 @ SendWarning(): -->Warning<-- From -->From<--```

#### SendAlert
    SLib.SendAlert(Alert: String, Title: String = "Alert!")

Displays a modal dialog box using the host OS' facilities with alert text and title.

#### SaveLog
    SLib.SaveLog(Log)

Save log parameter in log file, log file save in ```user://Log.ject```.

> [!TIP]
> You can see log data with ```print(LoadFile("user://Log.ject"))```.

> [!NOTE]
> You can change the log file path with ```SLib.Log_FileLcation```.

#### OSOpen
    SLib.OSOpen(URI: String)

Requests the OS to open a resource with the most appropriate program. For example:

- "C:\\Users\name\Downloads" on Windows opens the file explorer at the user's Downloads folder.

- "https://godotengine.org" opens the default web browser on the official Godot website.

- "mailto:example@example.com" opens the default email client with the "To" field set to example@example.com.

> [!IMPORTANT]
> File URI only works with globalized path, Use SLib.FullPath(path) to convert a res:// or user:// path 
> into a system path for use with this method.

> [!NOTE]
> Use String.uri_encode() to encode characters within URLs in a URL-safe, portable way. This is especially required 
> for line breaks. Otherwise, function may not work correctly in a project exported to the Web platform.

> [!NOTE]
> This method is implemented on Android, iOS, Web, Linux, macOS and Windows.

#### FullPath
    SLib.FullPath(Path: String)

Returns the absolute, native OS path corresponding to the localized path (starting with res:// or user://). The 
returned path will vary depending on the operating system and user preferences. See [File paths in Godot projects](https://docs.godotengine.org/en/4.2/tutorials/io/data_paths.html) to 
see what those paths convert to.

#### MergeUnique
    SLib.MergeUnique(Array1: Array, Array2: Array, FullUnique: bool = false)

It combines two arrays and only adds items from the second array to the first array if the first array does not already contain them.
As default, if the first array contains duplicate values to begin with, then the resulting array will not contain only unique values.

(By [snipercup](https://github.com/snipercup))

### Contribute
If you want to contribute to this project and extend the library, please fork the repository and submit a pull request. Or you can open an issue to discuss what you want to change.
For help, see the [project's wiki guide](https://github.com/Subject-Team/SLib/wiki/Contribute-guide), or use the [Q&A page](https://github.com/Subject-Team/SLib/discussions/categories/q-a).

### Thanks
[snipercup](https://github.com/snipercup) for:
- Add MergeUnique function
- Declaration FullUnique parameter for MergeUnique function

### Versions
[V1.0.2 - Stable](https://github.com/Subject-Team/SLib/releases/tag/1.0.2-S)

[V1.0.1 - Stable](https://github.com/Subject-Team/SLib/releases/tag/1.0.1-S)

[V1.0.0 - Stable](https://github.com/Subject-Team/SLib/releases/tag/1.0.0-S)
