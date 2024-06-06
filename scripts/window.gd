extends Window


# Called when the node enters the scene tree for the first time.
func _ready():
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT, true, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


