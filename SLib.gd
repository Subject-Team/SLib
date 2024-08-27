class_name SLibMain
extends Node
# Press F1 and search for SLib to see documentation

## SLib (Subject Library) is a Godot library that provides Godot capabilities in a simpler way.
##
## SLib is a set of ready and standard code that makes you unnecessary to write many long and frequently used codes.[br][br]
## Available ability in this library now:[br]
## ● Fast, safe and similar change scene[br]
## ● Easy project setting modify and use with code[br]
## ● Optimized reload scene system[br]
## ● Similar exit and close application code[br]
## ● Best wait timer system for readability[br]
## ● Internal and automatic save and load files system[br]
## ● Fast backuping system[br]
## ● Optimized debugging with error and warning sender[br]
## ● optimized alert system for all OS[br]
## ● Customizable logging system[br]
## ● Similar URI using system[br]
## ● Fast path convertor[br]
## ● Similar array unique merge[br]
## ● Find the first child of a given class[br]
## ● Time based smooth interpolation[br]
## ● Standard and fast pause set[br]
## ● Tween controller[br]
## ● Pause changer[br]
## [br]
## NOTE: Use [code]Project > Project Settings > SLib[/code] for change defaults and file locations.

## Default values
var Defaults: Dictionary = {
	"Descendants": false,
	"AlertTitle": "Alert!",
	"Error": "Error",
	"Warning": "Warning",
	"BackupSuffix": "Backup",
	"ScenesFolder": "Scene"
	}

## Library file locations
var FileLocations: Dictionary = {
	"Log": "user://App.log"
}

## Global variable for [method SLibMain.CustomSort]
var UserPattern: Array

func _enter_tree():
	Defaults = ProjectSettings.get("SLib/Defaults")
	FileLocations = ProjectSettings.get("SLib/FileLocations")

## You can use this function to transition between scenes, this increases code readability and helps you understand which scene in the target.
## [br][br]
## [b]1- Standard format (Recommended):[/b]
## [br]
## If you save your [code].tscn[/code] files in the [code]res://Scene/[/code] path, just put the target file name:
## [codeblock]
## SLib.GoToScene("Game")
## [/codeblock]
## The code above works exactly like the code below:
## [codeblock]
## get_tree.change_scene_to_file("res://Scene/Game.tscn")
## [/codeblock]
## [b]2- Root folder:[/b]
## [br]
## If you save [code].tscn[/code] files in [code]res://[/code], use the Folder parameter and set it to [code]/root[/code]:
## [codeblock]
## SLib.GoToScene("Game", "/root")
## [/codeblock]
## This code replaces the following code:
## [codeblock]
## get_tree.change_scene_to_file("res://Game.tscn")
## [/codeblock]
## [b]3- Custom folder:[/b]
## [br]
## You can also choose the folder where you saved your scene:
## [codeblock]
## SLib.GoToScene("Game", "My Scenes")
## [/codeblock]
## In this way, the following code will be executed:
## [codeblock]
## get_tree.change_scene_to_file("res://My Scenes/Game.tscn")
## [/codeblock]
## NOTE:
## You can also call nested folders, for example: [code]Scenes/Old Files[/code]
func GoToScene(SceneName: String, Folder: String = Defaults["ScenesFolder"]) -> void:
	if Folder == "/root":
		get_tree().change_scene_to_file("res://" + SceneName + ".tscn")
	else:
		get_tree().change_scene_to_file("res://" + Folder + "/" + SceneName + ".tscn")

## This function changes the project settings, for this it needs two parameters:
## [br]
## ● Path: can use [kbd]Ctrl+Shift+C[/kbd] on property of project settings window
## [br]
## ● Value: this parameter set to selected property
func SetProjectSetting(Path: String, Value) -> void:
	ProjectSettings.set_setting(Path, Value)

## This function returns the variable stored in the desired property, its use is as follows:
## [codeblock]
## MyVar = SLib.GetPrjectSetting("application/config/windows_native_icon")
## [/codeblock]
func GetProjectSetting(Path: String):
	return ProjectSettings.get_setting(Path)

## This function reloads the current scene, this is just a shortcut to increase code readability.
func Reload() -> void:
	get_tree().reload_current_scene()

## This function closes the program and also uses the optional exit code, added for code readability.
func Exit(ExitCode: int = 0) -> void:
	get_tree().quit(ExitCode)

## This function creates a break in the program that puts a space between the code befor and after it. (on seconds)
## [br][br]
## NOTE:
## You must write [code]await[/code] at the beginning of this line for it to work!
func Wait(WaitTime: float) -> void:
	await get_tree().create_timer(WaitTime).timeout

## This function will save a file with a customized path, this is very useful because the file saving process will be readable and fast.
## [br][br]
## NOTE:
## For use project directory type [code]res://[/code] and for hidden user data directory use [code]user://[/code].
## [br][br]
## NOTE:
## If you don't select Variable parameter, Variable set to [code]null[/code].
## [br][br]
## NOTE:
## You should type a format for your file, you can select any format but default format not open in other programs!
func SaveFile(Location: String, Variable = null) -> void:
	var file = FileAccess.open(Location,FileAccess.WRITE)
	file.store_var(Variable)
	file.close()

## This function returns the content stored in the file, you can use it for all file created by your godot application.
## [br][br]
## NOTE:
## If the file doesn't exist, it will send an error to the console like this: [code]SLib.gd:x @ SendError(): LoadFile(): Can't load from -->file_location<--, file not exists![/code]
func LoadFile(Location: String):
	if FileAccess.file_exists(Location):
		var file = FileAccess.open(Location,FileAccess.READ)
		var data = file.get_var()
		file.close()
		return data
	else:
		SendError("Can't load from " + Location + ", file not exists!", "LoadFile()")

## Backup function create a new file with [code]main file name-Suffix[/code] in main file location, if you doesn't select a custom suffix, [code]-Backup[/code] append to file name.
## [br][br]
## NOTE:
## If the file doesn't exist, it will send an error to the console like this: [code]SLib.gd:x @ SendError(): BackupFile(): Can't load from -->file_location<--, file not exists![/code]
## [br][br]
func BackupFile(Location: String, Suffix: String = Defaults["BackupSuffix"]) -> void:
	if FileAccess.file_exists(Location):
		var file = FileAccess.open(Location,FileAccess.READ)
		var data = file.get_var()
		var Backup_Location = Location.get_basename() + "-" + Suffix + "." + Location.get_extension()
		var backup = FileAccess.open(Backup_Location,FileAccess.WRITE)
		backup.store_var(data)
		file.close()
		backup.close()
	else:
		SendError("Can't load from " + Location + ", file not exists!", "BackupFile()")

## Sends a custom error to the console that can be viewed in the engine debugger, error like this: [code]SLib.gd:x @ SendError(): ->From<-: ->Error<-[/code]
func SendError(Error: String = Defaults["Error"], From: String = "Debugger") -> void:
	push_error(From + ": " + Error)

## Sends a custom warning to the console that can be viewed in the engine debugger like this: [code]SLib.gd:x @ SendWarning(): ->From<-: ->Warning<-[/code]
func SendWarning(Warning: String = Defaults["Warning"], From: String = "Debugger") -> void:
	push_warning(From + ": " + Warning)

## Displays a modal dialog box using the host OS' facilities with alert text and title.
func SendAlert(Alert: String, Title: String = Defaults["AlertTitle"]) -> void:
	OS.alert(Alert, Title)

## Save log parameter in log file, log file save in [code]user://Log.ject[/code] as default.
## [br][br]
## NOTE:
## You can see log data with [code]print(LoadFile("user://Log.ject"))[/code].
## [br][br]
## NOTE:
## You can change the log file path with [code]SLib.Log_FileLcation[/code].
func SaveLog(Log) -> void:
	SaveFile(FileLocations["Log"], Log)

## Return saved log.
func GetLog():
	return LoadFile(FileLocations["Log"])

## Requests the OS to open a resource with the most appropriate program. For example:
## [br][br]
## ● [code]"C:\Users\name\Downloads"[/code] on Windows opens the file explorer at the user's Downloads folder.
## [br][br]
## ● [code]"https://godotengine.org"[/code] opens the default web browser on the official Godot website.
## [br][br]
## ● [code]"mailto:example@example.com"[/code] opens the default email client with the "To" field set to example@example.com.
## [br][br]
## NOTE:
## File URI only works with globalized path, Use [code]SLib.FullPath(path)[/code] to convert a [code]res://[/code] or [code]user://[/code] path into a system path for use with this method.
## [br][br]
## NOTE:
## Use [code]String.uri_encode()[/code] to encode characters within URLs in a URL-safe, portable way. This is especially required for line breaks. Otherwise, function may not work correctly in a project exported to the Web platform.
## [br][br]
## NOTE:
## This method is implemented on Android, iOS, Web, Linux, macOS and Windows.
func OSOpen(URI: String) -> void:
	OS.shell_open(URI)

## Returns the absolute, native OS path corresponding to the localized path (starting with [code]res://[/code] or [code]user://[/code]).
## The returned path will vary depending on the operating system and user preferences.
## See [url=https://docs.godotengine.org/en/4.2/tutorials/io/data_paths.html]File paths in Godot projects[/url] to see what those paths convert to.
func FullPath(Path: String) -> String:
	if Path[0] == "u":
		return ProjectSettings.globalize_path(Path)
	else:
		var path = Path
		if OS.has_feature("editor"):
			path = ProjectSettings.globalize_path(Path)
		else:
			path = path.erase(0,6)
			path = OS.get_executable_path().get_base_dir().path_join(path)
		return path

## It combines two arrays and only adds items from the second array to the first array if the first array does not already contain them.
## [br][br]
## Example:
## [codeblock]
## var myarray1: Array = [1,2,3,4]
## var myarray2: Array = [3,4,5,6]
## var merged_array: Array = SLib.MergeUnique(myarray1,myarray2)
## print(merged_array) # prints [1,2,3,4,5,6]
## [/codeblock]
## NOTE: Removing duplicate values ​​in the first array is determined by the FullUnique parameter, set it to [code]true[/code] for optimize all array items.
func MergeUnique(Array1: Array, Array2: Array) -> Array:
	var MergedArray = []
	for Array1Item in Array1:
		if not MergedArray.has(Array1Item):
			MergedArray.append(Array1Item)
	for Array2Item in Array2:
		if not MergedArray.has(Array2Item):
			MergedArray.append(Array2Item)
	return MergedArray

## @experimental
## Finds the first child of a given class, does not find class_name declarations
func FindChildOfClass(TargetNode: Node, TypeName: StringName, Descendants: bool = Defaults["Descendants"]) -> Node:
	for Child in TargetNode.get_children():
		if Child.is_class(TypeName):
			return Child
		elif Descendants:
			var Found: Node = FindChildOfClass(Child, TypeName, Descendants)
			if Found:
				return Found
	return null

## @experimental
## Time based smooth interpolation, [b]not framedependant[/b] like [code]a = lerp(a, b, delta)[/code][br][br]
## NOTE: Set [i]Decay[/i] to 1-25 for a good range of values
func expDecay(A: float, B: float, Decay: float, Delta: float) -> float:
	return B + (A - B) * exp(-Decay * Delta)

## @experimental
## Auto Change get_tree().paused, if true, the SceneTree is paused. Doing so will have the following behavior:
## [br][br]
## - 2D and 3D physics will be stopped. This includes signals and collision detection.
## [br][br]
## - Node._process(), Node._physics_process() and Node._input() will not be called anymore in nodes.
## [br][br]
## If you need fast change, only use [code]PauseChange()[/code]. When need to set pause, use [code]ChagePause(true)[/code] or [code]ChagePause(false)[/code].
## [br][br]
## NOTE: If you set a not-boolean parameter, it will send an error to the console: [code]SLib.gd:x @ SendError(): ChangePause(): Only use boolean parameters![/code]
func PauseChange(Pause = null):
	if Pause == null:
		get_tree().paused = !get_tree().paused
	elif typeof(Pause) == 1:
		get_tree().paused = Pause
	else:
		SendError("Only use boolean parameters!", "PauseChange()")

## This function shows an object and creates an animation to change its color.
func Appear(object) -> void:
	object.show() 
	create_tween().tween_property(object, "modulate", Color.WHITE, 1.0)

## This function creates an animation to make an object disappear by changing its color to transparent.
func Disappear(object) -> void:
	var tween = create_tween()
	tween.tween_property(object, "modulate", Color.TRANSPARENT, 1.0)
	tween.finished.connect(func(): object.hide())

## @experimental
## Reverses the key-value pairs in a given dictionary.
func ReverseDict(Dict: Dictionary):
	var Reverse: Dictionary = {}
	for Key in Dict.keys():
		Reverse[Dict[Key]] = Key
	return Reverse

## Sorts the array based on the sorter, eg:
## [codeblock]
## var Scrambled = ["5", "A", "10", "K", "J", "Q", "3"]
## var Pattern = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
##
## var Sorted = SLib.CustomSort(Scrambled, Pattern) #-> ["A", "3", "5", "10", "J", "Q", "K"] 
## [/codeblock]
func CustomSort(ScrambledArray : Array, Pattern: Array) -> Array:
	UserPattern = Pattern
	ScrambledArray.sort_custom(_sorter)
	return ScrambledArray

func _sorter(a, b):
	if UserPattern.find(a) < UserPattern.find(b):
		return true
	return false
