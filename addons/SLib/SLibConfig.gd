@tool
class_name SLibConfig
extends EditorPlugin

## File locations for config files.
const CONFIG_FILES: Dictionary = {
	"Defaults": "res://addons/SLib/SLibDefaults.cfg",
	"FileLocations": "res://addons/SLib/SLibFileLocations.cfg"
}

#region config
## Default values
var defaults: Dictionary = {
	"Descendants": false,
	"AlertTitle": "Alert!",
	"Error": "Error",
	"Warning": "Warning",
	"BackupSuffix": "Backup",
	"ScenesFolder": "Scene"
}

## Global file locations
var file_locations: Dictionary = {
	"Log": "user://App.log"
}
#endregion

#region main
func _enter_tree():
	if FileAccess.file_exists(CONFIG_FILES["Defaults"]):
		var file = FileAccess.open(CONFIG_FILES["Defaults"],FileAccess.READ)
		defaults = file.get_var()
		file.close()
	if FileAccess.file_exists(CONFIG_FILES["FileLocations"]):
		var file = FileAccess.open(CONFIG_FILES["FileLocations"],FileAccess.READ)
		file_locations = file.get_var()
		file.close()
	ProjectSettings.set("SLib/Defaults", defaults)
	ProjectSettings.set_initial_value("SLib/Defaults", defaults)
	ProjectSettings.set("SLib/FileLocations", file_locations)
	ProjectSettings.set_initial_value("SLib/FileLocations", file_locations)
	var file = FileAccess.open(CONFIG_FILES["FileLocations"],FileAccess.WRITE)
	file.store_var(file_locations)
	file.close()
	var file2 = FileAccess.open(CONFIG_FILES["Defaults"],FileAccess.WRITE)
	file2.store_var(defaults)
	file2.close()


func _exit_tree():
	defaults = ProjectSettings.get_setting("SLib/Defaults")
	file_locations = ProjectSettings.get_setting("SLib/FileLocations")
	var file = FileAccess.open(CONFIG_FILES["Defaults"],FileAccess.WRITE)
	file.store_var(defaults)
	file.close()
	var file2 = FileAccess.open(CONFIG_FILES["FileLocations"],FileAccess.WRITE)
	file2.store_var(file_locations)
	file2.close()
#endregion
