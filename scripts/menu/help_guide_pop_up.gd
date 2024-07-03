extends Popup

@onready var game_guide:Control=$GameGuide/PanelContainer
# Called when the node enters the scene tree for the first time.
func _ready():
	set_size(Vector2i(game_guide.size))
	
	print(size,game_guide.size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_visibility_changed():
	if visible:
		set_size(Vector2i(game_guide.size))


func _on_game_guide_move_button_pressed():
	if visible:
		set_size(Vector2i(game_guide.size))
