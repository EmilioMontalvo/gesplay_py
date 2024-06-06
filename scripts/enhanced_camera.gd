extends Control

var paused=false
var dragPoint = Vector2()
var following=false
var window=true


var window_id=1

signal go_back
signal drag

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().set_transparent_background(true)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if following and visible and window and DisplayServer.get_window_list().has(window_id):
		DisplayServer.window_set_position(Vector2(
			DisplayServer.window_get_position(window_id)) + get_global_mouse_position() - dragPoint,
			window_id)
		print(window_id,DisplayServer.window_get_position(window_id))

func _on_go_back_pressed():
	go_back.emit()


func _on_pause_pressed():
	$Pause/TextureRect2.visible=not paused
	$Pause/TextureRect.visible=paused
	paused=not paused


func _on_close_pressed():
	$ConfirmationDialog.visible=true


func _on_drag_panel_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index==MOUSE_BUTTON_LEFT:
			following=not following
			dragPoint=get_local_mouse_position()

func set_window_id(id):
	window_id=id
			
