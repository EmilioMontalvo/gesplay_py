extends Node2D


var DIR = OS.get_executable_path().get_base_dir()
var interpreter_path = DIR.path_join(".WebcamMouse/env/Scripts/python.exe")
var script_path = DIR.path_join(".WebcamMouse/main.py")
var exe_path=DIR.path_join("executables/run_app.exe")
var thread: Thread

func _ready():
	print(exe_path)
	thread = Thread.new()
	if !OS.has_feature("template"): # if NOT exported version
		print("not exported")
		interpreter_path = ProjectSettings.globalize_path("res://.WebcamMouse/env/Scripts/python.exe")
		script_path = ProjectSettings.globalize_path("res://.WebcamMouse/main.py")
		thread.start(activate)
	else:
		print("exported",exe_path)
		thread.start(activate_deploy)
	

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		disconect() # default behavior

func activate():
	var output=[]
	var err = OS.execute(interpreter_path, [script_path], output, false,true)
	print(err)

func activate_deploy():
	var output = []
	if !OS.has_feature("template"):
		exe_path = ProjectSettings.globalize_path("res://executables/run_app.exe")
	var exit_code = OS.execute(exe_path, [], output)


func _exit_tree():
	#TODO: send a message to webcam mouse to finish the process
	var terminate_message=Message.new("exit",{"info": "program terminated"})
	UdPServer.send_message(terminate_message)
	thread.wait_to_finish()

func disconect():
	var terminate_message=Message.new("exit",{"info": "program terminated"})
	UdPServer.send_message(terminate_message)
	thread.wait_to_finish()
	get_tree().quit()
