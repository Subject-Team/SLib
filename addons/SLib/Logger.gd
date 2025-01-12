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

enum parts {
	GAME,
}

var awake := false
var default_part: parts = parts.GAME

func wake_up(set_default_part_to: parts = parts.GAME) -> void:
	if awake:
		SLib.send_warning("Waking the system was not successful, it is still awake!", "Log.wake_up")
		return
	awake = true
	default_part = set_default_part_to

