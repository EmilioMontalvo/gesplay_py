extends Panel

var window=null
var following=false
var dragPoint = Vector2()
var window_id=2
# Called when the node enters the scene tree for the first time.
func _ready():
	window=get_parent().get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if following and window_id != 0 and visible and DisplayServer.get_window_list().has(window_id):
		DisplayServer.window_set_position(Vector2(
			DisplayServer.window_get_position(window_id)) + get_global_mouse_position() - dragPoint,
			window_id)


func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index==MOUSE_BUTTON_LEFT:
			following=not following
			dragPoint=get_local_mouse_position() * window.scale

func update_window_id():
	window_id=DisplayServer.get_window_list()[DisplayServer.get_window_list().size()-1]
