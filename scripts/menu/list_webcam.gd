extends Node

var cameras_dic
@onready var option_button=$Panel/OptionButton
# Called when the node enters the scene tree for the first time.
func _ready():
	var output = []
	var executable = ProjectSettings.globalize_path("res://executables/list_webcams.exe")
	var exit_code = OS.execute(executable, [], output)
	cameras_dic=JSON.parse_string(str(output[0]))
	
	for x in cameras_dic.keys():
		option_button.add_item(cameras_dic[x])




func _on_accept_button_pressed():
	pass # Replace with function body.


func _on_cancel_button_pressed():
	pass # Replace with function body.
