extends Node
class_name SLibDocs
# NOTE: Press F1 and search for SLib to see documentation & informations!


## [center][img width=400]res://addons/SLib/SLib.png[/img][br]
## SLib (Subject Library) is a Godot library that provides Godot capabilities in a simpler way.[br][br]
## See [url=https://subject-team.github.io/SLib]project web page[/url] for more information or [url=https://github.com/Subject-Team/SLib]this Github repo[/url] for the main repository[/center]
##
## SLib is a set of ready and standard code that makes you unnecessary to write many long and frequently used codes.[br][br]
## Available ability in this library now:[br]
## ● Tween management & Animations: [method play_animation][br]
## ● File management: [method save_file], [method load_file], [method backup_file], [method get_file_path], [method set_file_path], [method globalize_path], [method localize_path][br]
## ● Ray casting: [method cast_ray_between_points][br]
## ● Pause management: [method change_pause][br]
## ● Game scenes management: [method change_scene], [method exit], [method reload][br]
## ● Time based smooth interpolation: [method exp_decay][br]
## ● Node management: [method find_child_pf_class], [method free_all_children][br]
## ● IP tools: [method get_local_ip][br]
## ● Debugging system: [method save_log], [method get_log], [method send_error], [method send_warning][br]
## ● Project Setting management: [method get_project_setting], [method set_project_setting][br]
## ● Bad word filter: [method is_word_ok][br]
## ● Array tools: [method merge_unique], [method patterned_sort], [method stringify_array][br]
## ● Dictionary tools: [method reverse_dict][br]
## ● OS tools: [method os_open], [method send_alert][br]
## ● Timer tools: [method wait][br]
## [br]
## [b]Note:[/b] Use [code]Project > Project Settings > SLib[/code] for change defaults and file locations.[br][br]
## [b][color=Orange]Important Changes & Update Notes: [/color] 1.1.0[/b][br]
## ● [b] Automatic modify local path:[/b] Now [method os_open] [param uri] can be localized path.[br]
## ● [b] Documentation update:[/b] After this version docs have SLib icon and modified format.[br]
## ● [b] More type hint:[/b] Type hint for [method appear] [param object], [method disappear] [param object] and more...[br]
## ● [b] Error and warning formation:[/b] New format for [method send_error] and [method send_alert].[br]
## ● [b] File management update:[/b] Set save & load format by file extension and use [enum Variant.Type] for [FileAccess] files.[br]
## ● [b] Animation system:[/b] Play animations by name instead of use [code]appear()[/code] and [code]disappear()[/code].

#region ERRORS
const Errors: Dictionary = {
	"invalid-file-path":"Can't find \"%s\" key in file locations!",
	"invalid-section-or-key":"Use config files need section & key, can't open \'{file}\'!",
	"save-error-config":"An error happened while saving data in \'{file}\' > \'{section}/{key}\': \'{error}\'!",
	"save-error":"An error happened while saving data in \'{file}\': \'{error}\'!",
	"load-nonexistent-dir":"Can't load data from file, target directory isn't exists!",
	"load-nonexistent":"Can't load data from file, target file isn't exists!",
	"load-error-config":"An error happened while loading data from \'{file}\' > \'{section}/{key}\': \'{error}\'!",
	"load-error":"An error happened while loading data from \'{file}\'!",
	"json-pars-error":"JSON Parse Error: {message} in {string} at line {line}!",
	"dual-animation-mistyped":"You should have \"to\" or \"by\" key in dual mode animation setting dictionary!",
	"invalid-pause-state":"Tree pause state should be boolean!",
}
#endregion

#region CONFIG
# Default values for functions, Use project settings to change.
var _defaults := {
	"Descendants": false,
	"AlertTitle": "Alert!",
	"Error": "Error",
	"Warning": "Warning",
	"BackupSuffix": "Backup",
	"ScenesFolder": "Scene",
}

# File locations for GFL, Use project settings to change.
var _file_locations := {}
#endregion

#region PRIVATE VARIABLES
const _PROFANITY_LIST := ['2g1c','2 girls 1 cup','acrotomophilia','anal','anilingus','anus','arsehole',
	'ass','asshole','assmunch','auto erotic','autoerotic','babeland','baby batter','ball gag',
	'ball gravy','ball kicking','ball licking','ball sack','ball sucking','bangbros','bareback',
	'barely legal','barenaked','bastardo','bastinado','bbw','bdsm','beaver cleaver','beaver lips',
	'bestiality','bi curious','big black','big breasts','big knockers','big tits','bimbos',
	'birdlock','bitch','black cock','blonde action','blonde on blonde action','blow j',
	'blow your l','blue waffle','blumpkin','bollocks','bondage','boner','boob','boobs','booty call',
	'brown showers','brunette action','bukkake','bulldyke','bullet vibe','bung hole','bunghole',
	'busty','butt','buttcheeks','butthole','camel toe','camgirl','camslut','camwhore',
	'carpet muncher','carpetmuncher','chocolate rosebuds','circlejerk','cleveland steamer','clit',
	'clitoris','clover clamps','clusterfuck','cock','cocks','coprolagnia','coprophilia','cornhole',
	'cum','cumming','cunnilingus','cunt','darkie','date rape','daterape','deep throat','deepthroat',
	'dick','dildo','dirty pillows','dirty sanchez','dog style','doggie style','doggiestyle',
	'doggy style','doggystyle','dolcett','domination','dominatrix','dommes','donkey punch',
	'double dong','double penetration','dp action','eat my ass','ecchi','ejaculation','erotic',
	'erotism','escort','ethical slut','eunuch','faggot','fecal','felch','fellatio','feltch',
	'female squirting','femdom','figging','fingering','fisting','foot fetish','footjob','frotting',
	'fuck','fucking','fuck buttons','fudge packer','fudgepacker','futanari','g-spot','gang bang',
	'gay sex','genitals','giant cock','girl on','girl on top','girls gone wild','goatcx','goatse',
	'gokkun','golden shower','goo girl','goodpoop','goregasm','grope','group sex','guro','hand job',
	'handjob','hard core','hardcore','hentai','homoerotic','honkey','hooker','hot chick',
	'how to kill','how to murder','huge fat','humping','incest','intercourse','jack off',
	'jail bait','jailbait','jerk off','jigaboo','jiggaboo','jiggerboo','jizz','juggs','kike',
	'kinbaku','kinkster','kinky','knobbing','leather restraint','leather straight jacket',
	'lemon party','lolita','lovemaking','make me come','male squirting','masturbate',
	'menage a trois','milf','missionary position','motherfucker','mound of venus','mr hands',
	'muff diver','muffdiving','nambla','nawashi','negro','neonazi','nig nog','nigga','nigger',
	'nimphomania','nipple','nipples','nsfw images','nude','nudity','nympho','nymphomania',
	'octopussy','omorashi','one cup two girls','one guy one jar','orgasm','orgy','paedophile',
	'panties','panty','pedobear','pedophile','pegging','penis','phone sex','piece of shit',
	'piss pig','pissing','pisspig','playboy','pleasure chest','pole smoker','ponyplay','poof',
	'poop chute','poopchute','porn','porno','pornography','prince albert piercing','pthc','pubes',
	'pussy','queaf','raghead','raging boner','rape','raping','rapist','rectum','reverse cowgirl',
	'rimjob','rimming','rosy palm','rosy palm and her 5 sisters','rusty trombone','s&m','sadism',
	'scat','schlong','scissoring','semen','sex','sexo','sexy','shaved beaver','shaved pussy',
	'shemale','shibari','shit','shota','shrimping','slanteye','slut','smut','snatch','snowballing',
	'sodomize','sodomy','spic','spooge','spread legs','strap on','strapon','strappado','strip club',
	'style doggy','suck','sucks','suicide girls','sultry women','swastika','swinger','tainted love',
	'taste my','tea bagging','threesome','throating','tied up','tight white','tit','tits','titties',
	'titty','tongue in a','topless','tosser','towelhead','tranny','tribadism','tub girl','tubgirl',
	'tushy','twat','twink','twinkie','two girls one cup','undressing','upskirt','urethra play',
	'urophilia','vagina','venus mound','vibrator','violet blue','violet wand','vorarephilia',
	'voyeur','vulva','wank','wet dream','wetback','white power','women rapping','wrapping men',
	'wrinkled starfish','xx','xxx','yaoi','yellow showers','yiffy','zoophilia',
]
#endregion

#region INITALIZING
func _enter_tree():
	_defaults = ProjectSettings.get_setting("SLib/Defaults", _defaults)
#endregion

#-----FUNCTIONS-----

#region FILE MANAGE

#region GFL
## Return global file locations with [param key], If the [param key] does not exist in the location of the files,
## it sends an error to the debugger and returns [code]""[/code].
func get_file_path(key: String) -> String:
	_file_locations = ProjectSettings.get_setting("SLib/FileLocations", _file_locations)
	if _file_locations.has(key):
		return _file_locations[key]
	else:
		send_error(Errors["invalid-file-path"] % key, "SLib.get_file_path")
		return ""

## Set a file location with [param key] name & [param path] path, If the [param key] already exists, it changes its value with [param  path], otherwise it creates it.
func set_file_path(key: String, path: String) -> void:
	_file_locations[key] = path
	ProjectSettings.set_setting("SLib/FileLocations", _file_locations)
#endregion

#region PATH CONVERTER
## Returns the absolute, native OS path corresponding to the localized path (starting with [code]res://[/code] or [code]user://[/code]).
## The returned path will vary depending on the operating system and user preferences.[br]
## If it receives a file in [code]"res://"[/code] in the exported project, unlike [code]ProjectSettings.globalize_path()[/code] it returns its path in the exportded accompanying files.[br][br]
## [b]Engine Docs:[/b] See [url=https://docs.godotengine.org/en/stable/tutorials/io/data_paths.html]File paths in Godot projects[/url] to see what those paths convert to.[br]
## [b]See also:[/b] [method localize_path].
func globalize_path(path: String) -> String:
	if path[0] == "u":
		return ProjectSettings.globalize_path(path)
	else:
		if OS.has_feature("editor"):
			path = ProjectSettings.globalize_path(path)
		else:
			path = path.erase(0,6)
			path = OS.get_executable_path().get_base_dir().path_join(path)
		return path


## Returns the localized path (starting with [code]res://[/code]) corresponding to the absolute, native OS [param path]. See also [method globalize_path].
func localize_path(path: String) -> String:
	return ProjectSettings.localize_path(path)
#endregion

#region SAVE LOAD BACKUP
## This function will save a file with a customized path, this is very useful because the file saving process will be readable and fast. It supports four methods: [FileAccess], [ConfigFile], [JSON], [ResourceSaver][br]
## It can find correct method by file extesion:[br]● [code].ini[/code] for config files[br]● [code].json[/code] for json files[br]● [code].tres, .tscn, .res, .scn[/code] for resource files[br]● other extension for file access custom mode.[br]
## For [FileAccess] method, this function automaticly use correct function in [FileAccess] functions for save data.[br][br]
## [b]Note:[/b] [param cofig] just for config files ([code]*.ini[/code]), use [code]"%section%/%key%"[/code] pattern for this parameter.[br]
## [b]Note:[/b] You can save bytes with [PackedByteArray], this function use [method FileAccess.store_buffer] for this type.[br]
## [b]Note:[/b] After update in [code]version 1.1.0 - Beta1[/code], if [param location] base directory isn't exists this function automaticly create it.[br]
## [b]Important:[/b] Use [code]res://[/code] path for save game (or app) data not recommended, this directory is [b]Readonly[/b] in many platforms. (See [url=https://docs.godotengine.org/en/stable/tutorials/io/data_paths.html#file-paths-in-godot-projects]File paths in godot projects[/url] for more informatio)[br]
## [b]See also:[/b] [method load_file], [method backup_file], [FileAccess], [method ConfigFile.set_value], [method JSON.stringify], [ResourceSaver].[br]
## [b]Examples:[/b]
## [codeblock]
## # ConfigFile (.ini), save "Jack" in key "name" in section "main" in "user://player.ini":
## SLib.save_file("user://player.ini", "Jack", "main/name")
## # JSON (.json), save enemy_data_dict in "user://Data.json" with JSON formatting:
## SLib.save_file("user://Data.json", enemy_data_dict)
## # ResourceSave (.tres, .tscn , .res, .scn), save panel style in "res://theme/custom_panel.tres":
## SLib.save_file("res://theme/custom_panel.tres", $Panel.theme_override_styles/panel)
## # FileAccess (other extension), save player_data in "res://restore_point.save":
## SLib.save_file("res://restore_point.save", player_data) 
## [/codeblock]
func save_file(location: String, value = null, config: String = "") -> Error:
	var type = location.get_extension()
	if not DirAccess.dir_exists_absolute(globalize_path(location).get_base_dir()):
		DirAccess.make_dir_recursive_absolute(globalize_path(location).get_base_dir())
	match type:
		"ini":
			if config.split("/", false).size() != 2:
				send_error(Errors["invalid-section-or-key"].format({"file": location}), "SLib.save_file")
				return ERR_INVALID_PARAMETER
			var section = config.split("/", false)[0]
			var key = config.split("/", false)[1]
			var config_file := ConfigFile.new()
			var error := config_file.load(location)
			config_file.set_value(section, key, value)
			error = config_file.save(location)
			if error:
				send_error(Errors["save-error-config"].format({"file": location, "section": section, "key": key, "error": str(error)}), "SLib.save_file")
			return error
		"json":
			var json_string := JSON.stringify(value)
			var file_access := FileAccess.open(location, FileAccess.WRITE)
			if not file_access:
				send_error(Errors["save-error"].format({"file": location, "error": FileAccess.get_open_error()}), "SLib.save_file")
				return file_access.get_open_error()
			file_access.store_var(json_string)
			file_access.close()
			return file_access.get_open_error()
		"tres", "res", "tscn", "scn":
			var error := ResourceSaver.save(value, location)
			if error:
				send_error(Errors["save-error"].format({"file": location, "error": error}), "SLib.save_file")
			return error
		"csv":
			var file = FileAccess.open(location, FileAccess.WRITE)
			if value is PackedByteArray:
				file.store_csv_line(value)
			else:
				file.store_string(value)
			file.close()
			return FileAccess.get_open_error()
		_:
			var file = FileAccess.open(location, FileAccess.WRITE)
			match typeof(value):
				TYPE_INT:
					file.store_64(value)
				TYPE_FLOAT:
					file.store_float(value)
				TYPE_STRING:
					file.store_string(value)
				TYPE_OBJECT:
					file.store_var(value, true)
				TYPE_PACKED_BYTE_ARRAY:
					file.store_buffer(value)
				_:
					file.store_var(value)
			file.close()
			return FileAccess.get_open_error()


## This function returns the content stored in the file. It supports four methods: [FileAccess], [ConfigFile], [JSON], [ResourceSaver][br]
## It can find correct method by file extesion:[br]● [code].ini[/code] for config files[br]● [code].json[/code] for json files[br]● [code].tres, .tscn, .res, .scn[/code] for resource files[br]● other extension for file access custom mode.[br]
## For [FileAccess] method, this function need [param type] from [enum Variant.Type] to use correct function in [FileAccess] functions for store data from file.[br][br]
## [b]Note:[/b] [param cofig] just for config files ([code]*.ini[/code]), use [code]"%section%/%key%"[/code] pattern for this parameter.[br]
## [b]Note:[/b] You can save bytes with [PackedByteArray], this function use [method FileAccess.store_buffer] for this type.[br]
## [b]Note:[/b] After update in [code]version 1.1.0 - Beta1[/code], if [param location] base directory isn't exists this function automaticly create it.[br]
## [b]Note:[/b] If the file doesn't exist, it will send an error to the console and return [param default_value].
## [b]See also:[/b] [method save_file], [method backup_file], [FileAccess], [method ConfigFile.get_value], [method JSON.parse], [method @GDScript.load].[br]
func load_file(location: String, type: Variant.Type = TYPE_NIL, default_value: Variant = null, config: String = ""):
	var extension = location.get_extension()
	if not DirAccess.dir_exists_absolute(globalize_path(location).get_base_dir()):
		send_error(Errors["load-nonexistent-dir"], "SLib.load_file")
		return default_value
	if not FileAccess.file_exists(location):
		send_error(Errors["load-nonexistent"], "SLib.load_file")
		return default_value
	match extension:
		"ini":
			if config.split("/", false).size() != 2:
				send_error(Errors["invalid-section-or-key"].format({"file": location}), "SLib.load_file")
				return
			var section = config.split("/", false)[0]
			var key = config.split("/", false)[1]
			var config_file := ConfigFile.new()
			var error := config_file.load(location)
			if error:
				send_error(Errors["load-error-config"].format({"file": location, "section": section, "key": key, "error": str(error)}), "SLib.load_file")
				return default_value
			return config_file.get_value(section, key, default_value)
		"json":
			var file_access := FileAccess.open(location, FileAccess.READ)
			var json_string := file_access.get_line()
			file_access.close()
			var json := JSON.new()
			var error := json.parse(json_string)
			if error:
				send_error(Errors["json-pars-error"].format({"message": str(json.get_error_message()), "string": json_string, "line": json.get_error_line()}), "SLib.load_file")
				return default_value
			return json.data
		"tres", "res", "tscn", "scn":
			return load(location)
		_:
			var file = FileAccess.open(location,FileAccess.READ)
			if file == null:
				send_error(Errors["load-error"].format({"file": location}))
				return default_value
			var data
			match type:
				TYPE_INT:
					data = file.get_64()
				TYPE_STRING:
					data = file.get_as_text()
				TYPE_PACKED_BYTE_ARRAY:
					data = file.get_buffer(file.get_length())
				TYPE_FLOAT:
					data = file.get_float()
				TYPE_OBJECT:
					data = file.get_var(true)
				_:
					data = file.get_var()
			file.close()
			if typeof(data) != type: return default_value
			return data
	return default_value


## Backup function create a new file with [code]%main_file_name%-%suffix%[/code] name in main file location.[br]
## if you doesn't select a custom [param suffix], [code]Project Settings > SLib > Defaults[BackupSuffix][/code] will append to file name. [br][br]
## [b]Tip:[/b] This function use [method load_file] and [method save_file] for more stability, please see documentations about these functions.[br]
## [b]See also:[/b] [method save_file] and [method load_file].
func backup_file(location: String, type: Variant.Type = TYPE_NIL, suffix: String = _defaults["BackupSuffix"], config: String = "") -> Error:
	var load = load_file(location, type, null, config)
	return save_file("{location}-{suffix}.{extension}".format({"location": location.get_basename(), "suffix": suffix, "extension": location.get_extension()}), load, config)
#endregion

#endregion

#region ANIMATIONS
## Valid animations for [method play_animation][br]
## [b]Note:[/b] Some animations have two modes: [code]to[/code] & [code]by[/code], this animations have [color=green]Dual Mode[/color] badge. 
## To use this animations you should have [code]to[/code] or [code]by[/code] key in [param setting] dictionary, for more information, see also [PropertyTweener] ( and as_relative method).
enum Animations {
	## Shows an [param object] and creates an animation to change its [code]modulate[/code].[br][b]Settings:[/b]
	## [codeblock]
	## {
	## 	"duration": float,
	## }
	## [/codeblock]
	FADE_IN,
	## Makes an [param object] disappear by changing its [code]modulate[/code] to transparent.[br][b]Settings:[/b]
	## [codeblock]
	## {
	## 	"duration": float,
	## }
	## [/codeblock]
	FADE_OUT,
	## [color=green]Dual Mode[/color][br]
	## For scale an [param object] using object [code]scale[/code] property.[br][b]Settings:[/b]
	## [codeblock]
	## {
	## 	"duration": float,
	## 	"to/by": Vector2/Vector3,
	## }
	## [/codeblock]
	SCALE,
	## [color=green]Dual Mode[/color][br]
	## For rotate an [param object] using object [code]rotation[/code] property.[br][b]Settings:[/b]
	## [codeblock]
	## {
	## 	"duration": float,
	## 	"to/by": float/Vector3,
	## }
	## [/codeblock]
	ROTATE,
	## [color=green]Dual Mode[/color][br]
	## For move an [param object] using object [code]position[/code] property.[br][b]Settings:[/b]
	## [codeblock]
	## {
	## 	"duration": float,
	## 	"to/by": Vector2/Vector3,
	## }
	## [/codeblock]
	MOVE,
	## [color=green]Dual Mode[/color][br]
	## For change [param object] opacity ([code]modulate.a[/code] or [code]modulate.a8[/code] property). True value for parameter [code]in8[/code] will wrap target value in range 0 to 255, instead of 0 to 1.[br][b]Settings:[/b]
	## [codeblock]
	## {
	## 	"duration": float,
	## 	"to/by": float,
	## 	"in8": bool,
	## }
	## [/codeblock]
	CHANGE_OPACITY,
}


## This function provides multiple animations with tweens.[br]You can see valid [param animation] and [param setting] values in [enum Animations].
## [br][br][b]Example usage:[/b]
## [codeblock]
## # Automaticly play fade in animations for loot_box object in 3.0 seconds
## SLib.play_animation(SLib.Animations.FADE_IN, loot_box, {"duration": 3.0})
## [/codeblock]
func play_animation(animation: Animations, object: Node, setting: Dictionary = {}) -> Tween:
	var tween = object.create_tween()
	match animation:
		Animations.FADE_IN:
			object.modulate = Color.TRANSPARENT
			object.show()
			tween.tween_property(object, "modulate", Color.WHITE, setting.get("duration", 1.0))
		Animations.FADE_OUT:
			tween.tween_property(object, "modulate", Color.TRANSPARENT, setting.get("duration", 1.0))
			tween.finished.connect(func(): object.hide())
		Animations.SCALE:
			if setting.has("to"):
				tween.tween_property(object, "scale", setting.get("to"), setting.get("duration", 1.0))
			elif setting.has("by"):
				tween.tween_property(object, "scale", setting.get("by"), setting.get("duration", 1.0)).as_relative()
			else:
				send_error(Errors["dual-animation-mistyped"], "SLib.play_animation")
		Animations.ROTATE:
			if setting.has("to"):
				tween.tween_property(object, "rotation", setting.get("to"), setting.get("duration", 1.0))
			elif setting.has("by"):
				tween.tween_property(object, "rotation", setting.get("by"), setting.get("duration", 1.0)).as_relative()
			else:
				send_error(Errors["dual-animation-mistyped"], "SLib.play_animation")
		Animations.MOVE:
			if setting.has("to"):
				tween.tween_property(object, "position", setting.get("to"), setting.get("duration", 1.0))
			elif setting.has("by"):
				tween.tween_property(object, "position", setting.get("by"), setting.get("duration", 1.0)).as_relative()
			else:
				send_error(Errors["dual-animation-mistyped"], "SLib.play_animation")
		Animations.CHANGE_OPACITY:
			if setting.has("to"):
				if setting.get("in8", false): setting["to"] = setting["to"] / 255.0
				tween.tween_property(object, "modulate", Color(object.modulate, setting.get("to")), setting.get("duration", 1.0))
			elif setting.has("by"):
				if setting.get("in8", false): setting["by"] = setting["by"] / 255.0
				tween.tween_property(object, "modulate", Color(0, 0, 0, setting.get("by")), setting.get("duration", 1.0)).as_relative()
			else:
				send_error(Errors["dual-animation-mistyped"], "SLib.play_animation")
	return tween
#endregion

#region ARRAY TOOLS
## Sorts the array based on the [param pattern] array, eg:
## [codeblock]
## var scrambled = ["5", "A", "10", "K", "J", "Q", "3"]
## var pattern = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
##
## var sorted = SLib.patterned_sort(scrambled, pattern) # sorted: ["A", "3", "5", "10", "J", "Q", "K"] 
## [/codeblock]
func patterned_sort(scrambled_array : Array, pattern: Array) -> Array:
	scrambled_array.sort_custom(func(a, b): return pattern.find(a) < pattern.find(b))
	return scrambled_array


## It combines two arrays and only adds items from the second array to the first array if the first array does not already contain them.[br]
## For make unique an array, merge it with [code][][/code].
## [br][br]
## Example:
## [codeblock]
## var myarray1: Array = [1,2,3,4]
## var myarray2: Array = [3,4,5,6]
## var merged_array: Array = SLib.merge_unique(myarray1,myarray2)
## print(merged_array) # prints [1,2,3,4,5,6]
## [/codeblock]
func merge_unique(array1: Array, array2: Array) -> Array:
	var merged_array = []
	for i in array1:
		if not merged_array.has(i):
			merged_array.append(i)
	for j in array2:
		if not merged_array.has(j):
			merged_array.append(j)
	return merged_array
#endregion

#region DICTIONARY TOOLS
## Reverses the key-value pairs in a given dictionary.
func reverse_dict(dict: Dictionary) -> Dictionary:
	var reverse := {}
	for key in dict.keys():
		reverse[dict[key]] = key
	return reverse
#endregion

#region STRING TOOLS
## Converts [Array] to [String] with [param seperator] between array arguments
func stringify_array(arguments: Array, seperator: String = "") -> String:
	var string = ""
	for i in arguments.size():
		string = string + str(arguments[i])
		if i < arguments.size():
			string = string + seperator
	return string


## Filtering bad words, If word in profanity list return [code]false[/code].[br][br]
## [b]Note:[/b] Visit [url=https://github.com/subject-team/slib]library repository[/url] to see the list.
func is_word_ok(word: String) -> bool:
	for d in [' ', '_', '-']:
		for s in word.split(d):
			if _PROFANITY_LIST.has(s):
				return false
	return true
#endregion

#region SCENE MANAGE
## You can use this function to transition between scenes, this increases code readability and helps you understand which scene in the target.
## [br][br]
## [b]1- Standard format (Recommended):[/b]
## [br]
## If you save your [code].tscn[/code] files in the [code]res://Scene/[/code] path, just put the target file name in [param scene_name]:
## [codeblock]
## SLib.change_scene("Game") # works exacly like: get_tree.change_scene_to_file("res://Scene/Game.tscn")
## [/codeblock]
## [b]Tip:[/b] [code]res://Scene/[/code] is the same as the one specified in the [code]Project Settings > SLib > Defaults[ScenesFolder][/code], if you change it you can use this method; example:
## [codeblock]
## # Project Settings > SLib > Defaults[ScenesFolder] seted to "My Scenes"
## SLib.change_scene("Best Score") # change scene to "res://My Scenes/Best Score.tscn"
## [/codeblock]
## [b]2- Root folder:[/b]
## [br]
## If you save [code].tscn[/code] files in [code]res://[/code], use the [param folder] parameter and set it to [code]/root[/code]:
## [codeblock]
## SLib.change_scene("Game", "/root") # works exacly like: get_tree.change_scene_to_file("res://Game.tscn")
## [/codeblock]
## [b]3- Custom folder:[/b]
## [br]
## You can also choose the [param folder] where you saved your scene:
## [codeblock]
## SLib.change_scene("Game", "My Scenes") # works exacly like: get_tree.change_scene_to_file("res://My Scenes/Game.tscn")
## [/codeblock]
## [b]Tip:[/b] You can also call nested folders, for example:
## [codeblock]
## SLib.change_scene("Main Menu", "Scenes/Old Files") # path to "res://Scenes/Old Files/Main Menu.tscn"
## [/codeblock]
func change_scene(scene_name: String, folder: String = _defaults["ScenesFolder"]) -> void:
	if folder == "/root":
		get_tree().change_scene_to_file("res://{scene}.tscn".format({"scene": scene_name}))
	else:
		get_tree().change_scene_to_file("res://{folder}/{scene}.tscn".format({"folder": folder, "scene": scene_name}))


## This function reloads the current scene, this is just a shortcut to increase code readability.
func reload() -> void:
	get_tree().reload_current_scene()


## This function closes the program and also uses the optional [param exit_code], added for code readability.[br][br]
## [b]Important:[/b] On IOS this method doesn't work![br]
## [b]See also:[/b] [method SceneTree.quit]
func exit(exit_code: int = 0) -> void:
	get_tree().quit(exit_code)
#endregion

#region NODE MANAGE
## Finds the first child of a given [param target_class] in [param target_node].[br][br]
## [b]Important:[/b] does not find [code]class_name[/code] declarations!
func find_child_of_class(target_node: Node, target_class: StringName, descendants: bool = _defaults["Descendants"]) -> Node:
	for child in target_node.get_children():
		if child.is_class(target_class):
			return child
		elif descendants:
			var found: Node = find_child_of_class(child, target_class, descendants)
			if found:
				return found
	return null


## Clear all children of [param node] with [method Node.queue_free].
func free_all_children(node: Node) -> void:
	for child in node.get_children():
		child.queue_free()
#endregion

#region PROJECT SETTING
## This function changes the project settings, for this it needs two parameters:
## [br]
## ● [param path]: can use [kbd]Ctrl+Shift+C[/kbd] on any property of project settings window to copy that path
## [br]
## ● [param value]: this parameter set to selected property
func set_project_setting(path: String, value) -> void:
	ProjectSettings.set_setting(path, value)


## This function returns the variable stored in the desired property, its use is as follows:
## [codeblock]
## native_icon = SLib.get_prject_setting("application/config/windows_native_icon")
## [/codeblock]
## [b]Note:[/b] For settings that are not present in the engine and are created manually,
## [code]null[/code] will be returned if the value is the same as the initial value, so use [param default_value] to avoid possible bugs.
func get_project_setting(path: String, default_value: Variant = null):
	return ProjectSettings.get_setting(path, default_value)
#endregion

#region OS COMMUNICATION
## Requests the OS to open a resource with the most appropriate program. For example:
## [br][br]
## ● [code]"C:\Users\name\Downloads"[/code] on Windows opens the file explorer at the user's Downloads folder.
## [br][br]
## ● [code]"https://godotengine.org"[/code] opens the default web browser on the official Godot website.
## [br][br]
## ● [code]"mailto:example@example.com"[/code] opens the default email client with the "To" field set to example@example.com.
## [br][br]
## NOTE:
## Use [code]String.uri_encode()[/code] to encode characters within URLs in a URL-safe, portable way. This is especially required for line breaks. Otherwise, function may not work correctly in a project exported to the Web platform.
## [br][br]
## NOTE:
## This method is implemented on Android, iOS, Web, Linux, macOS and Windows.
func os_open(uri: String) -> void:
	if uri.begins_with("res://") or uri.begins_with("user://"):
		uri = globalize_path(uri)
	OS.shell_open(uri)


## Returns the local IP address of the operating system[br][br]
## [b]Note:[/b] Works for Windows, Mac and Linux, returns [code]""[/code] for all other operating systems.
func get_local_ip() -> String:
	if OS.has_feature("windows"):
		if OS.has_environment("COMPUTERNAME"):
			return IP.resolve_hostname(str(OS.get_environment("COMPUTERNAME")),1)
	elif OS.has_feature("x11"):
		if OS.has_environment("HOSTNAME"):
			return IP.resolve_hostname(str(OS.get_environment("HOSTNAME")),1)
	elif OS.has_feature("OSX"):
		if OS.has_environment("HOSTNAME"):
			return IP.resolve_hostname(str(OS.get_environment("HOSTNAME")),1)
	return ""


## Displays a modal dialog box using the host OS' facilities with [param alert] for text and [param title].
func send_alert(alert: String, title: String = _defaults["AlertTitle"]) -> void:
	OS.alert(alert, title)
#endregion

#region PAUSE MANAGE
## Auto change [code]get_tree().paused[/code], if this parameter is [code]true[/code], the [SceneTree] is paused.[br]
## [code]SLib.change_pause()[/code] check current state and change it, if [param pause] isn't [code]null[/code] game pause state set to this parameter.[br][br]
## [b]Note:[/b] If you set a not-boolean parameter, it will send an error to the console.
## [b]See also:[/b] [member SceneTree.paused].
func change_pause(pause = null) -> void:
	if pause == null:
		get_tree().paused = !get_tree().paused
	elif typeof(pause) == TYPE_BOOL:
		get_tree().paused = pause
	else:
		send_error(Errors["invalid-pause-state"], "SLib.change_pause")
#endregion

#region DEBUGGING
## Sends a custom error to the console that can be viewed in the engine debugger, error like this: 
## [code]SLib.gd:x @ send_error(): [/code][param from][code]: [/code][param error]
func send_error(error: String = _defaults["Error"], from: String = "Debugger") -> void:
	push_error(from + ": " + error)


## Sends a custom warning to the console that can be viewed in the engine debugger like this: [code]SLib.gd:x @ send_warning(): [/code][param from][code]: [/code][param warning]
func send_warning(warning: String = _defaults["Warning"], from: String = "Debugger") -> void:
	push_warning(from + ": " + warning)


## Save log parameter in log file (Overwrite older log), log file save in [code]user://App.log[/code] as default.
## [br][br]
## NOTE:
## You can see log data with [code]print(SLib.get_log())[/code].
func save_log(custom_log: String) -> Error:
	return save_file(_file_locations["Log"], custom_log)


## Return saved log.[br][br]
## [b]See also:[/b] [method save_log].
func get_log() -> String:
	return load_file(_file_locations["Log"], TYPE_STRING)
#endregion

#region 3D TOOLS
## Cast a ray between two points and return the result[br]
## Parameters:[br]
## - [param from]: The starting point of the ray. [Vector3][br]
## - [param to]: The ending point of the ray. [Vector3][br]
## - [param exclude_nodes]: An [Array] of nodes (or [RID]s) to exclude from the raycast[br]
## Returns: A [Dictionary] with the raycast result, or an empty dictionary if nothing is hit.[br]
## Example usage:
## [codeblock]
## var start_pos = player.global_transform.origin
## var end_pos = target.global_transform.origin
## var exclude = [self, player]
## var world = get_world_3d()
## var result = SLib.cast_ray_between_points(start_pos, end_pos, exclude, world)
## if result.size() != 0:
##     print("Ray hit: ", result.collider)
## else:
##     print("No collision detected.")
## [/codeblock]
## [b]See also:[/b] [PhysicsRayQueryParameters3D].
func cast_ray_between_points(from: Vector3, to: Vector3, exclude: Array, world: World3D) -> Dictionary:
	var query = PhysicsRayQueryParameters3D.new()
	query.from = from
	query.to = to
	query.exclude = exclude
	var space_state = world.direct_space_state
	return space_state.intersect_ray(query)
#endregion

#region OTHER
## This function creates a break in the program that puts a space between the code befor and after it. (on seconds)
## [br][br]
## NOTE:
## You must write [code]await[/code] at the beginning of this line for it to work!
func wait(wait_time: float) -> void:
	await get_tree().create_timer(wait_time).timeout


## Time based smooth interpolation, [b]not framedependant[/b] like [code]a = lerp(a, b, delta)[/code].[br][br]
## [b]Tip:[/b] Keep [param decay] in 1 to 25 range for a good range of values.
func exp_decay(a: float, b: float, decay: float, delta: float) -> float:
	return b + (a - b) * exp(-decay * delta)
#endregion
