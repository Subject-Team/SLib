class_name SLibSetting
extends EditorPlugin
# Press F1 and search for SLibSetting to see documentation

## SLib settings and parametrs
##
## Access and edit SLib user side settings and parameters

## @experimental
## Descendants parameter for [method SLib.FindChildOfClass]
const Default_Descendants: bool = false
## Title parameter for [method SLib.SendAlert]
const Default_AlertTitle: String = "Alert!"
## Error parameter for [method SLib.SendError]
const Default_Error: String = "Error"
## Wrarning parameter for [method SLib.SendWarning]
const Default_Warning: String = "Warning"
## Suffix parameter for [method SLib.BackupFile]
const Default_BackupSuffix: String = "Backup"
## Folder parameter for [method SLib.GoToScene]
const Default_ScenesFolder: String = "Scene"
## Log file location for save logs, [code]user://...[/code] is recommended
const FileLcation_Log: String = "user://Log.ject"
