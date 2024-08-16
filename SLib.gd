extends Control

const Log_FileLcation = "user://Log.ject"

func GoToScene(SceneName, Standard = true, Folder = "--NotSelected--"):
	if Standard == true:
		get_tree().change_scene_to_file("res://Scene/" + SceneName + ".tscn")
	elif Folder == "--NotSelected--":
		get_tree().change_scene_to_file("res://" + SceneName + ".tscn")
	else:
		get_tree().change_scene_to_file("res://" + Folder + "/" + SceneName + ".tscn")

func SetProjectSetting(Path, Variable):
	ProjectSettings.set_setting(Path, Variable)

func GetProjectSetting(Path):
	return ProjectSettings.get_setting(Path)

func Reload():
	get_tree().reload_current_scene()

func Exit(ExitCode = 0):
	get_tree().quit(ExitCode)

func Wait(WaitTime):
	await get_tree().create_timer(WaitTime).timeout

func SaveFile(Location, Variable = null):
	var file = FileAccess.open(Location,FileAccess.WRITE)
	file.store_var(Variable)
	file.close()

func LoadFile(Location):
	if FileAccess.file_exists(Location):
		var file = FileAccess.open(Location,FileAccess.READ)
		var data = file.get_var()
		file.close()
		return data

func BackupFile(Location, Suffix = "-Backup"):
	if FileAccess.file_exists(Location):
		var file = FileAccess.open(Location,FileAccess.READ)
		var data = file.get_var()
		var Spliter = Location.split(".",false)
		var Backup_Location = Spliter[0] + Suffix + "." + Spliter[1]
		var backup = FileAccess.open(Backup_Location,FileAccess.WRITE)
		backup.store_var(data)
		file.close()
		backup.close()

func SendError(From, Error = "Error"):
	push_error('"' + Error + '" From "' + From + '"')

func SendWarning(From, Warning = "Warning"):
	push_warning('"' + Warning + '" From "' + From + '"')

func SendAlert(Alert, Title = "Alert!"):
	OS.alert(Alert, Title)

func SaveLog(Log):
	SaveFile(Log_FileLcation, Log)

func Open(URI):
	OS.shell_open(URI)

func FullPath(Path):
	return ProjectSettings.globalize_path(Path)
