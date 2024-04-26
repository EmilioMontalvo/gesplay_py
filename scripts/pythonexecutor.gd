extends Node2D


var DIR = OS.get_executable_path().get_base_dir()
var interpreter_path = DIR.path_join(".WebcamMouse/env/Scripts/python.exe")
var script_path = DIR.path_join(".WebcamMouse/main.py")

func _ready():
	if !OS.has_feature("standalone"): # if NOT exported version
		interpreter_path = ProjectSettings.globalize_path("res://.WebcamMouse/env/Scripts/python.exe")
		script_path = ProjectSettings.globalize_path("res://.WebcamMouse/main.py")

func activate():
	var err = OS.execute(interpreter_path, [script_path])
	print(err)
