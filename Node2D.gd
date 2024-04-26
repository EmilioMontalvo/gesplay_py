extends Node2D

var array=[1,2,3,4,5]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	#UdPServer.send_array(array)
	#UdPServer.send_string("hello from Godot")
	#ConfigManager.load_config("default")
	#print(CursorConf.get_as_json())
	Pythonexecutor.activate()
	
