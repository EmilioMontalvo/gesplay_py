extends Control

var cameras_dic
var camera_id=GlobalConf.camera_id
@onready var option_button=$Panel/OptionButton

signal finalized
# Called when the node enters the scene tree for the first time.
func _ready():
	cameras_dic=CameraList.list_of_cameras
	
	if not CameraList.is_ready:
		return
	
	for x in cameras_dic.keys():
		option_button.add_item(cameras_dic[x])
	
	if str(camera_id) in cameras_dic.keys():
		option_button.selected=camera_id


func _on_accept_button_pressed():
	GlobalConf.camera_id=camera_id
	GlobalConf.save_configs()
	visible=false


func _on_cancel_button_pressed():
	var message=Message.new("update_camera_config", {"camera_id":GlobalConf.camera_id})
	UdPServer.send_message(message)
	visible=false


func _on_option_button_item_selected(index):
	camera_id=index
	var message=Message.new("update_camera_config", {"camera_id":index})
	UdPServer.send_message(message)


func _on_visibility_changed():
	if visible:
		option_button.grab_focus()
