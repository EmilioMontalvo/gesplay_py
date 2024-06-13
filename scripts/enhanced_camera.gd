extends Control

var paused=GlobalConf.is_camera_mouse_paused
var dragPointLocal = Vector2()
var followingLocal=false
var window=true
var pauseTexture=load("res://assets/paused_camera.png")

var window_id=1

signal go_back
signal drag
signal config

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().set_transparent_background(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if followingLocal and visible and window and DisplayServer.get_window_list().has(window_id):
		DisplayServer.window_set_position(Vector2(
			DisplayServer.window_get_position(window_id)) + get_global_mouse_position() - dragPointLocal,
			window_id)
		

func _on_go_back_pressed():
	go_back.emit()


func _on_pause_pressed():
	$Pause/TextureRect2.visible=not GlobalConf.is_camera_mouse_paused
	$Pause/TextureRect.visible=GlobalConf.is_camera_mouse_paused
	
	if not paused:
		UdPServer.send_message(Message.new("pause_mouse",{"info": "mouse paused"}))
	else: 
		UdPServer.send_message(Message.new("resume_mouse",{"info": "mouse resumed"}))
	
	paused=not paused
	GlobalConf.is_camera_mouse_paused=paused
	


func _on_close_pressed():
	$"../../ConfirmDialogWindow".visible=true

func set_window_id(id):
	window_id=id
			


func _on_drag_panel_dragged_panel(following,dragPoint):
	followingLocal=following
	dragPointLocal=dragPoint * scale


func _on_control_camer_conf_btn_pressed():
	config.emit(window_id)
