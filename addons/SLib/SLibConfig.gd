@tool
class_name SLibConfig
extends EditorPlugin

## File locations for config files.
const ConfigFiles: Dictionary = {
	"Defaults": "res://addons/SLib/SLibDefaults.cfg",
	"FileLocations": "res://addons/SLib/SLibFileLocations.cfg"
	}

## Default values
var Defaults: Dictionary = {
	"Descendants": false,
	"AlertTitle": "Alert!",
	"Error": "Error",
	"Warning": "Warning",
	"BackupSuffix": "Backup",
	"ScenesFolder": "Scene"
	}

## Global file locations
var FileLocations: Dictionary = {
	"Log": "user://App.log"
}

func _enter_tree():
	set_project_settings()

func _exit_tree():
	remove_project_settings()

## Load config files and set config values to project setting
func set_project_settings() -> void:
	if FileAccess.file_exists(ConfigFiles["Defaults"]):
		var file = FileAccess.open(ConfigFiles["Defaults"],FileAccess.READ)
		Defaults = file.get_var()
		file.close()
	if FileAccess.file_exists(ConfigFiles["FileLocations"]):
		var file = FileAccess.open(ConfigFiles["FileLocations"],FileAccess.READ)
		FileLocations = file.get_var()
		file.close()
	ProjectSettings.set("SLib/Defaults", Defaults)
	ProjectSettings.set_initial_value("SLib/Defaults", Defaults)
	ProjectSettings.set("SLib/FileLocations", FileLocations)
	ProjectSettings.set_initial_value("SLib/FileLocations", FileLocations)
	var file = FileAccess.open(ConfigFiles["FileLocations"],FileAccess.WRITE)
	file.store_var(FileLocations)
	file.close()
	var file2 = FileAccess.open(ConfigFiles["Defaults"],FileAccess.WRITE)
	file2.store_var(Defaults)
	file2.close()

## Save config values from project setting
func remove_project_settings() -> void:
	Defaults = ProjectSettings.get_setting("SLib/Defaults")
	FileLocations = ProjectSettings.get_setting("SLib/FileLocations")
	var file = FileAccess.open(ConfigFiles["Defaults"],FileAccess.WRITE)
	file.store_var(Defaults)
	file.close()
	var file2 = FileAccess.open(ConfigFiles["FileLocations"],FileAccess.WRITE)
	file2.store_var(FileLocations)
	file2.close()
