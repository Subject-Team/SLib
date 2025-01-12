extends Node

# Demo Script For Test & Show SLib functions

func _ready():
	pass

func _backup_game():
	# This one line of code creates a backup of the player's data file with an optional
	# extension next to it, it has the ability to check all types of errors and manage them,
	# prevent syntax errors, repeating lines and code length.
	SLib.backup_json_file("user://main_data.json")

func _old_backup_game():
	# These 10 lines of code do the same thing as one line above, with the difference that
	# the file extension and path must be specified in several places each time. 
	# and creates variables that are no longer usable!
	var file_access := FileAccess.open("user://main_data.json", FileAccess.READ)
	var json_string := file_access.get_line()
	file_access.close()
	var json := JSON.new()
	json.parse(json_string)
	var data = json.data
	var backup_json_string := JSON.stringify(data)
	var backup_file_access := FileAccess.open("user://main_data.json".get_basename() + "-Backup." +"user://main_data.json".get_extension(), FileAccess.WRITE)
	backup_file_access.store_var(backup_json_string)
	backup_file_access.close()
