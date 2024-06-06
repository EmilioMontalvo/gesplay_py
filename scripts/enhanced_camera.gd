extends Control

var paused=false
var dragPointLocal = Vector2()
var followingLocal=false
var window=true


var window_id=1

signal go_back
signal drag

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().set_transparent_background(true)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if followingLocal and visible and window and DisplayServer.get_window_list().has(window_id):
		print("window",DisplayServer.window_get_position(window_id))
		print("mouse",get_global_mouse_position())
		print("local mouse",dragPointLocal)
		DisplayServer.window_set_position(Vector2(
			DisplayServer.window_get_position(window_id)) + get_global_mouse_position() - dragPointLocal,
			window_id)
		

func _on_go_back_pressed():
	go_back.emit()


func _on_pause_pressed():
	$Pause/TextureRect2.visible=not paused
	$Pause/TextureRect.visible=paused
	paused=not paused


func _on_close_pressed():
	$ConfirmationDialog.visible=true

func set_window_id(id):
	window_id=id
			


func _on_drag_panel_dragged_panel(following,dragPoint):
	followingLocal=following
	dragPointLocal=dragPoint * scale
