extends Control

class_name ConfirmDialog

@export var dialog_text: String
@export var accept_text: String
@export var cancel_text: String

@onready var dialog_label: Label = $PanelContainer/CenterContainer/MarginContainer/VBoxContainer/HBoxContainer/Label
@onready var accept_button: Button = $PanelContainer/CenterContainer/MarginContainer/VBoxContainer/HBoxContainer2/AcceptButton
@onready var cancel_button: Button = $PanelContainer/CenterContainer/MarginContainer/VBoxContainer/HBoxContainer2/CancelButton

var option: bool

signal option_selected

func _ready():
	dialog_label.text = dialog_text
	accept_button.text = "Aceptar" if accept_text.is_empty() else accept_text
	cancel_button.text = "Cancelar" if cancel_text.is_empty() else cancel_text
	set_global_position(get_viewport_rect().size / 2)

func on_show() -> bool:
	visible = true
	get_tree().paused = true
	await option_selected
	visible = false
	get_tree().paused = false
	return option

func _on_accept_button_pressed():
	option = true
	option_selected.emit(option)

func _on_cancel_button_pressed():
	option = false
	option_selected.emit(option)

func set_dialog_text(dialog_new_text):
	dialog_text=dialog_new_text
	dialog_label.text = dialog_new_text


func _on_visibility_changed():
	if visible:
		$PanelContainer/CenterContainer/MarginContainer/VBoxContainer/HBoxContainer2/CancelButton.grab_focus()
