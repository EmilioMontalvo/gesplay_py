extends Control

@export var scene_go_back: int
@export var scene_home: int
@export var dialog_text: String = "¿Estas seguro de abandonar el nivel?"

@onready var go_back_button: Button = $ColorRect/GoBack
@onready var home_button: Button = $ColorRect/Home
@onready var confirm_dialog_back: ConfirmDialog = $ConfirmationGoBack
@onready var confirm_dialog_home: ConfirmDialog = $ConfirmationHome
@onready var current_level_label: Label = $ColorRect/CurrentLevel
@onready var button_profile = $ColorRect/ButtonProfile

func _ready():
	confirm_dialog_back.set_dialog_text(dialog_text)
	confirm_dialog_home.set_dialog_text(dialog_text)
	button_profile.dialog_message = true

func _on_go_back_pressed():
	if await confirm_dialog_back.on_show():
		SoundControllerMenu.continue_music()
		MenuManager.load_menu(scene_go_back)

func _on_home_pressed():
	if await confirm_dialog_home.on_show():
		SoundControllerMenu.continue_music()
		MenuManager.load_menu(scene_home)
		
func set_current_level(level: int):
	current_level_label.text = "Nivel: " + str(level)
