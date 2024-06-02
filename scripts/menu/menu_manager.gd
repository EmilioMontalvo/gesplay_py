extends Node



enum MENU_LEVEL {
		NONE,
		MAIN,
		NEW_PROFILE,
		PROFILES,
		GENERAL_SETTINGS,
		CURSOR_CONFIGURATION,
		GAMES_MENU,
		LOANDING,
		CURSOR_GAME,
		CLICK_CONFIGURATION,
		CURSOR_LEVELS,
		LOGIN,
		CURSOR_LEVEL1,
		CLICK_LEVELS,
		REGISTER
	}
var menus = {
	MENU_LEVEL.MAIN : preload("res://scenes/menu/pages/main_menu.tscn"), 
	MENU_LEVEL.NEW_PROFILE : preload("res://scenes/menu/pages/new_profile.tscn"),
	MENU_LEVEL.PROFILES : preload("res://scenes/menu/pages/profiles.tscn"),
	MENU_LEVEL.GENERAL_SETTINGS : preload("res://scenes/menu/pages/settings_menu.tscn"),
	MENU_LEVEL.CURSOR_CONFIGURATION : preload("res://scenes/menu/pages/cursor_configuration.tscn"),
	MENU_LEVEL.GAMES_MENU : preload("res://scenes/menu/pages/games_menu.tscn"),
	MENU_LEVEL.LOANDING : preload("res://scenes/menu/pages/loanding.tscn"),
	MENU_LEVEL.CURSOR_GAME : preload("res://scenes/menu/pages/cursor/cursor_game.tscn"),
	MENU_LEVEL.CLICK_CONFIGURATION : preload("res://scenes/menu/pages/click_configuration.tscn"),
	MENU_LEVEL.CURSOR_LEVELS : preload("res://scenes/menu/pages/cursor/cursor_levels.tscn"),
	MENU_LEVEL.LOGIN : preload("res://scenes/menu/pages/login.tscn"),
	MENU_LEVEL.CURSOR_LEVEL1 : preload("res://scenes/menu/pages/cursor/levels/level_1.tscn"),
	MENU_LEVEL.CLICK_LEVELS: preload("res://scenes/menu/pages/click/click_levels.tscn"),
	MENU_LEVEL.REGISTER: preload("res://scenes/menu/pages/register.tscn")
}

var current_scene:Node
var current_menu:Node



func _ready():
	pass

func load_menu(menulevel):
	call_deferred("_deferred_load_menu", menulevel)
	

func _deferred_load_menu(menulevel):
	#replace the current menus instance with the new ones
	current_menu = menus[menulevel].instantiate()

	var container = current_scene
	#clear the current menu item/s
	for location in container.get_children():
		container.remove_child(location)
	#add our selected menu
	container.add_child(current_menu)

func set_current_scene(node):
	current_scene=node

