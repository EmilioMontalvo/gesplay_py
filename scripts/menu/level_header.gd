extends Control

@export var scene_go_back: int
@export var scene_home: int
@export var dialog_text: String = "¿Estas seguro de abandonar el nivel?"

@onready var go_back_button: TextureButton = $ColorRect/GoBack
@onready var home_button: TextureButton = $ColorRect/Home
@onready var confirm_dialog_back: ConfirmDialog = $ConfirmationGoBack
@onready var confirm_dialog_home: ConfirmDialog = $ConfirmationHome

func _ready():
	confirm_dialog_back.set_dialog_text(dialog_text)
	confirm_dialog_home.set_dialog_text(dialog_text)

func _on_go_back_pressed():
	if await confirm_dialog_back.on_show():
		MenuManager.load_menu(scene_go_back)

func _on_home_pressed():
	if await confirm_dialog_home.on_show():
		MenuManager.load_menu(scene_home)
