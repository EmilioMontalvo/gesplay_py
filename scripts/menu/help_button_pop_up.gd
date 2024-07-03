extends Button

@onready var help_dialog:Popup=$HelpDialog
@export var help_text="Placeholder Text"
# Called when the node enters the scene tree for the first time.
func _ready():
	help_dialog.set_data(help_text)
	var pop_up_position=Vector2i(Vector2(global_position.x - help_dialog.get_size_panel().x/2, global_position.y + 75))
	help_dialog.position = pop_up_position
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	help_dialog.visible= not help_dialog.visible
	
	if help_dialog.visible:
		var pop_up_position=Vector2i(Vector2(global_position.x - help_dialog.get_size_panel().x/2, global_position.y + 75))
		help_dialog.position = pop_up_position
