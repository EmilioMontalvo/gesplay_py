extends Control

@onready var catch_button: CheckButton = $RadioButtons/CheckButton
@onready var nip_button: CheckButton = $RadioButtons/CheckButton2

var temporal_click_config: ClickConfig = ClickConfig.new()
var button_group: ButtonGroup = ButtonGroup.new()
var buttons_list: Array

func _ready():
	temporal_click_config.set_from_json(ClickConf.get_as_json())
	catch_button.button_group = button_group
	nip_button.button_group = button_group
	buttons_list = button_group.get_buttons()
	for button in buttons_list:
		button.pressed.connect(_on_change)
	buttons_list[temporal_click_config.gesture_index].button_pressed = true
	$HelpButtonMenu.grab_focus()

func _on_change():
	print(button_group.get_pressed_button().text)
	temporal_click_config.gesture_index = buttons_list.find(button_group.get_pressed_button())
	
func send_new_config(config:ClickConfig):
	UdPServer.send_message(config.get_as_message("update_click_config"))

func _on_acept_pressed():
	ClickConf.set_from_json(temporal_click_config.get_as_json())
	ClickConf.save_config()
	send_new_config(ClickConf)
	MenuManager.load_menu(MenuManager.MENU_LEVEL.SETTINGS)

func _on_cancel_pressed():
	send_new_config(ClickConf)
	MenuManager.load_menu(MenuManager.MENU_LEVEL.SETTINGS)
