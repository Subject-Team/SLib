extends Control

const Log_FileLcation = "user://Log.ject"

func GoToScene(SceneName: String, Folder: String = "Scene"):
	if Folder == "/root":
		get_tree().change_scene_to_file("res://" + SceneName + ".tscn")
	else:
		get_tree().change_scene_to_file("res://" + Folder + "/" + SceneName + ".tscn")

func SetProjectSetting(Path: String, Value):
	ProjectSettings.set_setting(Path, Value)

func GetProjectSetting(Path: String):
	return ProjectSettings.get_setting(Path)

func Reload():
	get_tree().reload_current_scene()

func Exit(ExitCode: int = 0):
	get_tree().quit(ExitCode)

func Wait(WaitTime: float):
	await get_tree().create_timer(WaitTime).timeout

func SaveFile(Location: String, Variable = null):
	var file = FileAccess.open(Location,FileAccess.WRITE)
	file.store_var(Variable)
	file.close()

func LoadFile(Location: String):
	if FileAccess.file_exists(Location):
		var file = FileAccess.open(Location,FileAccess.READ)
		var data = file.get_var()
		file.close()
		return data
	else:
		SendError("LoadFile", "Can't load from " + Location + ", file not exists!")

func BackupFile(Location: String, Suffix: String = "Backup"):
	if FileAccess.file_exists(Location):
		if Suffix != "":
			var file = FileAccess.open(Location,FileAccess.READ)
			var data = file.get_var()
			var Spliter = Location.split(".",false)
			var Backup_Location = Spliter[0] + "-" + Suffix + "." + Spliter[1]
			var backup = FileAccess.open(Backup_Location,FileAccess.WRITE)
			backup.store_var(data)
			file.close()
			backup.close()
		else:
			SendError("BackupFile", "Need Suffix option")
	else:
		SendError("BackupFile", "Can't load from " + Location + ", file not exists!")

func SendError(Error: String = "Error", From: String = "null"):
	if From != "null":
		push_error('"' + Error + '" From "' + From + '"')
	else:
		push_error(Error)

func SendWarning(Warning: String = "Warning", From: String = "null"):
	if From != "null":
		push_warning('"' + Warning + '" From "' + From + '"')
	else:
		push_warning(Warning)

func SendAlert(Alert: String, Title: String = "Alert!"):
	OS.alert(Alert, Title)

func SaveLog(Log):
	SaveFile(Log_FileLcation, Log)

func OSOpen(URI: String):
	OS.shell_open(URI)

func FullPath(Path: String):
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
