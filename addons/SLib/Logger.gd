class_name SLibLoggerDocs
extends Node
# Press F1 and search for SLib to see documentation

# TODO
# ---

# NOTE
# ---

# WARNING
# ---

# TEST
# ---

# ALERT
# ---

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

var error_messages := {
	"UNLNOWN": "An unknown problem occurred!",
	"AWAKE_NOW": "Waking the system was not successful, it is still awake!",
	"SYNTAX": "There is an error in calling the logger or in the settings!"
}

enum {
	PART_GAME,
	PART_MAX,
}

var awake := false
var default_part: int = PART_GAME:
	set(value):
		if value >= PART_MAX:
			value = PART_MAX - 1
		if value < 0:
			value = 0

func wake_up(set_default_part_to: int = PART_GAME) -> void:
	if awake:
		handle_error("AWAKE_NOW", "Log.wake_up")
		return
	awake = true
	default_part = set_default_part_to

func write(what: Variant, format: Dictionary = {}, part: int = default_part) -> void:
	pass

func handle_error(err_string: String, from: String = "Log") -> void:
	var order = error[err_string]
	var message = error_messages[err_string]
	match order:
		0:
			return
		1:
			SLib.send_error(err_string + " - " + message, from)
		2:
			SLib.send_warning(err_string + " - " + message, from)
		3:
			printerr("Logger > {from}: {err} - {message}".format({"from": from, "err": err_string, "message": message}))
		_:
			handle_error("SYNTAX")

