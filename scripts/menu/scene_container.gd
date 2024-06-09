extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	MenuManager.set_current_scene(get_node("."))
	MenuManager.load_menu(MenuManager.MENU_LEVEL.LOGIN)



