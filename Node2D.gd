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
	var json_message=CursorConf.get_as_message("update_cursor_config")._to_string()
	UdPServer.send_string(json_message)
	#ConfigManager.load_config("default")
	#print(CursorConf.get_as_json())
	
