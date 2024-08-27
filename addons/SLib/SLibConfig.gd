@tool
class_name SLibConfig
extends EditorPlugin

## The name of the file that will store all settings from this plugin.
const SAVE_FILE_NAME: String = "res://addons/SLib/SLib.config"

var settings: Dictionary = {
	"Descendants": false,
	"AlertTitle": "Alert!",
	"Error": "Error",
	"Warning": "Warning",
	"BackupSuffix": "Backup",
	"ScenesFolder": "Scene"
	}

func _enter_tree():
	set_project_settings()

func _exit_tree():
	remove_project_settings()

func set_project_settings() -> void:
	if FileAccess.file_exists(SAVE_FILE_NAME):
		var file = FileAccess.open(SAVE_FILE_NAME,FileAccess.READ)
		settings = file.get_var()
		file.close()
	print(settings)
	ProjectSettings.set("SLib/Defaults", settings)

func remove_project_settings() -> void:
	settings = ProjectSettings.get_setting("SLib/Defaults")
	var file = FileAccess.open(SAVE_FILE_NAME,FileAccess.WRITE)
	file.store_var(settings)
	file.close()
