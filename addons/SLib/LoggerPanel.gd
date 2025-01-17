@tool
extends Control

const SETTINGS_FILE = "res://addons/SLib/LoggerSettings.cfg"
const ERRORS_FILE = "res://addons/SLib/LoggerErrSettings.cfg"

@onready var n_disable_errors: CheckBox = $"Scroll/Margin/Tab/Debugging/Disable Errors"
@onready var n_disable_warnings: CheckBox = $"Scroll/Margin/Tab/Debugging/Disable Warnings"
@onready var n_limit_mode: OptionButton = $"Scroll/Margin/Tab/Limitation/Grid/Limit Mode"
@onready var n_limit_value: SpinBox = $"Scroll/Margin/Tab/Limitation/Grid2/Limit Value"
@onready var n_print_wake_messages: CheckBox = $"Scroll/Margin/Tab/Outputs/Print Wake Messages"
@onready var n_debugging: GridContainer = $"Scroll/Margin/Tab/Debugging"
@onready var n_error: OptionButton
@onready var n_tab: TabContainer = $Scroll/Margin/Tab
@onready var n_log: Label = $Scroll/Margin/Tab/Log

var settings := {
	"disable-errors" : false,
	"disable-warnings" : false,
	"limit-mode" : 0,
	"limit-value": 0,
	"print-wake-messages": false,
}

var error := {
	"UNKNOWN": 3,
	"AWAKE_NOW": 1,
	"SYNTAX": 2,
}

func _ready():
	_load_settings()
	n_disable_errors.button_pressed = settings["disable-errors"]
	n_disable_warnings.button_pressed = settings["disable-warnings"]
	n_limit_mode.selected = settings["limit-mode"]
	n_limit_value.value = settings["limit-value"]
	n_print_wake_messages.button_pressed = settings["print-wake-messages"]
	var i = 0
	for err in error.keys():
		n_error = n_debugging.get_child(3 + (i * 2))
		n_error.selected = error[err]
		i += 1

func _load_settings():
	if FileAccess.file_exists(SETTINGS_FILE):
		var file = FileAccess.open(SETTINGS_FILE,FileAccess.READ)
		settings = file.get_var()
		file.close()
	else:
		var file = FileAccess.open(SETTINGS_FILE,FileAccess.WRITE)
		file.store_var(settings)
		file.close()
	if FileAccess.file_exists(ERRORS_FILE):
		var file = FileAccess.open(ERRORS_FILE,FileAccess.READ)
		error = file.get_var()
		file.close()
	else:
		var file = FileAccess.open(ERRORS_FILE,FileAccess.WRITE)
		file.store_var(error)
		file.close()


func _save_changes():
	settings = {
		"disable-errors" : n_disable_errors.button_pressed,
		"disable-warnings" : n_disable_warnings.button_pressed,
		"limit-mode" : n_limit_mode.selected,
		"limit-value" : n_limit_value.value,
		"print-wake-messages" : n_print_wake_messages.button_pressed,
	}
	n_limit_value.editable = settings["limit-mode"] != 0
	var i = 0
	for err in error.keys():
		n_error = n_debugging.get_child(3 + (i * 2))
		error[err] = n_error.selected
		i += 1
	var file = FileAccess.open(SETTINGS_FILE,FileAccess.WRITE)
	file.store_var(settings)
	file.close()
	var err_file = FileAccess.open(ERRORS_FILE,FileAccess.WRITE)
	err_file.store_var(error)
	err_file.close()
	if n_log.text == "":
		n_log.text = "Changes was saved"
	else:
		n_log.text = n_log.text + "
Changes was saved"


func _save_options(index):
	_save_changes()


func _save_spins(value):
	_save_changes()
