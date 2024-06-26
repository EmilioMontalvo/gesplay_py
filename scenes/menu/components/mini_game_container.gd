extends SubViewportContainer

@onready var sub_viewport=$SubViewport
# Called when the node enters the scene tree for the first time.
func _input(_event):
	sub_viewport.handle_input_locally = true
	sub_viewport.physics_object_picking = true
	sub_viewport.audio_listener_enable_2d = true
	sub_viewport.push_input(_event)
	sub_viewport.push_unhandled_input(_event)
	

func _unhandled_input(event):
	sub_viewport.push_unhandled_input(event)
