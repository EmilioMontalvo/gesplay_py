extends Button

@export var text_guide: String = "Texto de prueba para la guia de menus"

@onready var guide = $MenuGuide

func _ready():
	guide.global_position = Vector2(global_position.x - guide.get_size_panel().x/2, global_position.y + 75)
	guide.set_data(text_guide)

func _on_pressed():
	guide.on_show()
