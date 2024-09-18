class_name SLibMain
extends Node
# Press F1 and search for SLib to see documentation

# TODO

# NOTE

# WARNING

# TEST

## SLib (Subject Library) is a Godot library that provides Godot capabilities in a simpler way.[br][br]
## See [url]https://github.com/Subject-Team/SLib[/url] for the main repository
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
## ● Dictionary reverser[br]
## ● Global file locations space[br]
## [br]
## NOTE: Use [code]Project > Project Settings > SLib[/code] for change defaults and file locations.

#region config
## Default values
var defaults := {
	"Descendants": false,
	"AlertTitle": "Alert!",
	"Error": "Error",
	"Warning": "Warning",
	"BackupSuffix": "Backup",
	"ScenesFolder": "Scene",
}

## Library file locations
var file_locations := {
	"Log": "user://App.log",
}
#endregion

#region private variables
var _user_pattern: Array
#endregion

#region initalizing
func _enter_tree():
	defaults = ProjectSettings.get_setting("SLib/Defaults", defaults)
	file_locations = ProjectSettings.get_setting("SLib/FileLocations", file_locations)
#endregion

#region main
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
func change_scene(scene_name: String, folder: String = defaults["ScenesFolder"]) -> void:
	if folder == "/root":
		get_tree().change_scene_to_file("res://" + scene_name + ".tscn")
	else:
		get_tree().change_scene_to_file("res://" + folder + "/" + scene_name + ".tscn")


## This function changes the project settings, for this it needs two parameters:
## [br]
## ● Path: can use [kbd]Ctrl+Shift+C[/kbd] on property of project settings window
## [br]
## ● Value: this parameter set to selected property
func set_project_setting(path: String, value) -> void:
	ProjectSettings.set_setting(path, value)


## This function returns the variable stored in the desired property, its use is as follows:
## [codeblock]
## MyVar = SLib.GetPrjectSetting("application/config/windows_native_icon")
## [/codeblock]
func get_project_setting(path: String):
	return ProjectSettings.get_setting(path)


## This function reloads the current scene, this is just a shortcut to increase code readability.
func reload() -> void:
	get_tree().reload_current_scene()


## This function closes the program and also uses the optional exit code, added for code readability.
func exit(exit_code: int = 0) -> void:
	get_tree().quit(exit_code)


## This function creates a break in the program that puts a space between the code befor and after it. (on seconds)
## [br][br]
## NOTE:
## You must write [code]await[/code] at the beginning of this line for it to work!
func wait(wait_time: float) -> void:
	await get_tree().create_timer(wait_time).timeout


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
func save_file(location: String, value = null) -> void:
	var file = FileAccess.open(location,FileAccess.WRITE)
	file.store_var(value)
	file.close()


## This function returns the content stored in the file, you can use it for all file created by your godot application.
## [br][br]
## NOTE:
## If the file doesn't exist, it will send an error to the console like this: [code]SLib.gd:x @ SendError(): SLib File Loader: Can't load from -->file_location<--, file not exists![/code]
func load_file(location: String):
	if FileAccess.file_exists(location):
		var file = FileAccess.open(location,FileAccess.READ)
		var data = file.get_var()
		file.close()
		return data
	else:
		send_error("Can't load from " + location + ", file not exists!", "SLib File Loader")


## Backup function create a new file with [code]main file name-suffix[/code] in main file location, if you doesn't select a custom suffix, [code]-Backup[/code] append to file name.
## [br][br]
## NOTE:
## If the file doesn't exist, it will send an error to the console like this: [code]SLib.gd:x @ SendError(): SLib File Backup: Can't load from -->file_location<--, file not exists![/code]
## [br][br]
func backup_file(location: String, suffix: String = defaults["BackupSuffix"]) -> void:
	if FileAccess.file_exists(location):
		var file = FileAccess.open(location,FileAccess.READ)
		var data = file.get_var()
		var backup_location = location.get_basename() + "-" + suffix + "." + location.get_extension()
		var backup = FileAccess.open(backup_location,FileAccess.WRITE)
		backup.store_var(data)
		file.close()
		backup.close()
	else:
		send_error("Can't load from " + location + ", file not exists!", "SLib File Backup")


## Sends a custom error to the console that can be viewed in the engine debugger, error like this: [code]SLib.gd:x @ SendError(): ->From<-: ->Error<-[/code]
func send_error(error: String = defaults["Error"], from: String = "Debugger") -> void:
	push_error(from + ": " + error)


## Sends a custom warning to the console that can be viewed in the engine debugger like this: [code]SLib.gd:x @ SendWarning(): ->From<-: ->Warning<-[/code]
func send_warning(warning: String = defaults["Warning"], from: String = "Debugger") -> void:
	push_warning(from + ": " + warning)


## Displays a modal dialog box using the host OS' facilities with alert text and title.
func send_alert(alert: String, title: String = defaults["AlertTitle"]) -> void:
	OS.alert(alert, title)


## Save log parameter in log file, log file save in [code]user://Log.ject[/code] as default.
## [br][br]
## NOTE:
## You can see log data with [code]print(LoadFile("user://Log.ject"))[/code].
## [br][br]
## NOTE:
## You can change the log file path with [code]SLib.Log_FileLcation[/code].
func save_log(custom_log) -> void:
	save_file(file_locations["Log"], custom_log)


## Return saved log.
func get_log():
	return load_file(file_locations["Log"])


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
func os_open(uri: String) -> void:
	OS.shell_open(uri)


## Returns the absolute, native OS path corresponding to the localized path (starting with [code]res://[/code] or [code]user://[/code]).
## The returned path will vary depending on the operating system and user preferences.
## See [url=https://docs.godotengine.org/en/4.2/tutorials/io/data_paths.html]File paths in Godot projects[/url] to see what those paths convert to.
func full_path(path: String) -> String:
	if path[0] == "u":
		return ProjectSettings.globalize_path(path)
	else:
		if OS.has_feature("editor"):
			path = ProjectSettings.globalize_path(path)
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
## var merged_array: Array = SLib.merge_unique(myarray1,myarray2)
## print(merged_array) # prints [1,2,3,4,5,6]
## [/codeblock]
func merge_unique(array1: Array, array2: Array) -> Array:
	var merged_array = []
	for i in array1:
		if not merged_array.has(i):
			merged_array.append(i)
	for j in array2:
		if not merged_array.has(j):
			merged_array.append(j)
	return merged_array


## Finds the first child of a given class, does not find class_name declarations
func find_child_of_class(target_node: Node, type_name: StringName, descendants: bool = defaults["Descendants"]) -> Node:
	for child in target_node.get_children():
		if child.is_class(type_name):
			return child
		elif descendants:
			var found: Node = find_child_of_class(child, type_name, descendants)
			if found:
				return found
	return null


## Time based smooth interpolation, [b]not framedependant[/b] like [code]a = lerp(a, b, delta)[/code][br][br]
## NOTE: Set [i]decay[/i] to 1-25 for a good range of values
func exp_decay(a: float, b: float, decay: float, delta: float) -> float:
	return b + (a - b) * exp(-decay * delta)


## Auto Change get_tree().paused, if true, the SceneTree is paused. Doing so will have the following behavior:
## [br][br]
## - 2D and 3D physics will be stopped. This includes signals and collision detection.
## [br][br]
## - Node._process(), Node._physics_process() and Node._input() will not be called anymore in nodes.
## [br][br]
## If you need fast change, only use [code]PauseChange()[/code]. When need to set pause, use [code]ChagePause(true)[/code] or [code]ChagePause(false)[/code].
## [br][br]
## NOTE: If you set a not-boolean parameter, it will send an error to the console: [code]SLib.gd:x @ SendError(): SLib Pause Changer: Only use boolean parameters![/code]
func change_pause(pause = null) -> void:
	if pause == null:
		get_tree().paused = !get_tree().paused
	elif typeof(pause) == 1:
		get_tree().paused = pause
	else:
		send_error("Only use boolean parameters!", "SLib Pause Changer")


## This function shows an object and creates an animation to change its color.
func appear(object) -> void:
	object.show() 
	create_tween().tween_property(object, "modulate", Color.WHITE, 1.0)

## This function creates an animation to make an object disappear by changing its color to transparent.
func disappear(object) -> void:
	var tween = create_tween()
	tween.tween_property(object, "modulate", Color.TRANSPARENT, 1.0)
	tween.finished.connect(func(): object.hide())


## Reverses the key-value pairs in a given dictionary.
func reverse_dict(dict: Dictionary) -> Dictionary:
	var reverse := {}
	for key in dict.keys():
		reverse[dict[key]] = key
	return reverse


## Sorts the array based on the sorter, eg:
## [codeblock]
## var Scrambled = ["5", "A", "10", "K", "J", "Q", "3"]
## var Pattern = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
##
## var Sorted = SLib.patterned_sort(Scrambled, Pattern) #-> ["A", "3", "5", "10", "J", "Q", "K"] 
## [/codeblock]
func patterned_sort(scrambled_array : Array, pattern: Array) -> Array:
	_user_pattern = pattern
	scrambled_array.sort_custom(_sorter)
	var sorted_array = scrambled_array
	return sorted_array


## Return global file locations by key.
func file_path(key: String) -> String:
	return file_locations[key]


## Cast a ray between two points and return the result
## Parameters:[br]
## - from: The starting point of the ray (Vector3)[br]
## - to: The ending point of the ray (Vector3)[br]
## - exclude_nodes: An array of nodes (or RIDs) to exclude from the raycast (Array)[br]
## Returns: A Dictionary with the raycast result, or an empty dictionary if nothing is hit.
##
## Example usage:
## [codeblock]
## var start_pos = player.global_transform.origin
## var end_pos = target.global_transform.origin
## var exclude = [self, player]
## var world = get_world_3d()
## var result = SLib.cast_ray_between_points(start_pos, end_pos, exclude, world)
## if result.size() != 0:
##     print("Ray hit: ", result.collider)
## else:
##     print("No collision detected.")
## [/codeblock]
func cast_ray_between_points(from: Vector3, to: Vector3, exclude: Array, world: World3D) -> Dictionary:
	var query = PhysicsRayQueryParameters3D.new()
	query.from = from
	query.to = to
	query.exclude = exclude
	var space_state = world.direct_space_state
	return space_state.intersect_ray(query)


## Returns the local IP address of the operating system[br][br]
## NOTE: Works for Windows, Mac and Linux, returns [code]""[/code] for all other operating systems
func get_local_ip() -> String:
	if OS.has_feature("windows"):
		if OS.has_environment("COMPUTERNAME"):
			return IP.resolve_hostname(str(OS.get_environment("COMPUTERNAME")),1)
	elif OS.has_feature("x11"):
		if OS.has_environment("HOSTNAME"):
			return IP.resolve_hostname(str(OS.get_environment("HOSTNAME")),1)
	elif OS.has_feature("OSX"):
		if OS.has_environment("HOSTNAME"):
			return IP.resolve_hostname(str(OS.get_environment("HOSTNAME")),1)
	return ""
#endregion

#region private functions
func _sorter(a, b):
	if _user_pattern.find(a) < _user_pattern.find(b):
		return true
	return false
#endregion

