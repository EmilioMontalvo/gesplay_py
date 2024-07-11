extends Node

var list_of_cameras
var thread: Thread
var is_ready=false
var DIR = OS.get_executable_path().get_base_dir()
var exe_path=DIR.path_join("executables/list_webcams.exe")
# Called when the node enters the scene tree for the first time.
func _ready():
	execute_camera_script()
	thread = Thread.new()
	#thread.start(execute_camera_script)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func execute_camera_script():
	var output = []
	if !OS.has_feature("template"):
		exe_path = ProjectSettings.globalize_path("res://executables/list_webcams.exe")
	var exit_code = OS.execute(exe_path, [], output)
	list_of_cameras=JSON.parse_string(str(output[0]))
	is_ready=true
