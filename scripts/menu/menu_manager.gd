extends Node

var base_instance=null

enum MENU_LEVEL {
		NONE,
		MAIN,
		NEW_PROFILE,
		PROFILES,
		SETTINGS,
		CURSOR_CONFIGURATION,
		GAMES_MENU,
		LOANDING,
		CURSOR_GAME,
		CLICK_CONFIGURATION,
		CURSOR_LEVELS,
		LOGIN,
		CURSOR_LEVEL1,
		CLICK_LEVELS,
		REGISTER,
		GENERAL_SETTINGS
	}
var menus = {
	MENU_LEVEL.MAIN : preload("res://scenes/menu/pages/main_menu.tscn"), 
	MENU_LEVEL.NEW_PROFILE : preload("res://scenes/menu/pages/new_profile2.tscn"),
	MENU_LEVEL.PROFILES : preload("res://scenes/menu/pages/profiles.tscn"),
	MENU_LEVEL.SETTINGS : preload("res://scenes/menu/pages/settings_menu.tscn"),
	MENU_LEVEL.CURSOR_CONFIGURATION : preload("res://scenes/menu/pages/cursor_configuration.tscn"),
	MENU_LEVEL.GAMES_MENU : preload("res://scenes/menu/pages/games_menu.tscn"),
	MENU_LEVEL.LOANDING : preload("res://scenes/menu/pages/loanding.tscn"),
	MENU_LEVEL.CURSOR_GAME : preload("res://scenes/menu/pages/cursor/cursor_game.tscn"),
	MENU_LEVEL.CLICK_CONFIGURATION : preload("res://scenes/menu/pages/click_configuration.tscn"),
	MENU_LEVEL.CURSOR_LEVELS : preload("res://scenes/menu/pages/cursor/cursor_levels.tscn"),
	MENU_LEVEL.LOGIN : preload("res://scenes/menu/pages/login.tscn"),
	MENU_LEVEL.CURSOR_LEVEL1 : preload("res://scenes/menu/pages/cursor/levels/level_1.tscn"),
	MENU_LEVEL.CLICK_LEVELS: preload("res://scenes/menu/pages/click/click_levels.tscn"),
	MENU_LEVEL.REGISTER: preload("res://scenes/menu/pages/register.tscn"),
	MENU_LEVEL.GENERAL_SETTINGS: preload("res://scenes/menu/pages/general_settings.tscn")
}

var current_scene:Node
var current_menu:Node

var menu_container=preload("res://scenes/menu/menu_container.tscn")

func _ready():
	pass

func load_menu(menulevel):
	call_deferred("_deferred_load_menu", menulevel)
	

func _deferred_load_menu(menulevel):
	
	if base_instance:
		get_tree().root.remove_child(base_instance)
		base_instance=null
	get_tree().change_scene_to_packed(menus[menulevel])

func load_instace_menu(instance:Node):
	var root_scene = get_tree().root
	var last_child_index=root_scene.get_child_count()
	root_scene.remove_child(root_scene.get_children()[last_child_index-1])
	root_scene.add_child(instance)
	base_instance=instance
	

	
	
func set_current_scene(node):
	current_scene=node

