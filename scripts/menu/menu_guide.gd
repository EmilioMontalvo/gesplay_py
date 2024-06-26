extends Control

@onready var text_guide: Label = $PanelContainer/CenterContainer/MarginContainer/VBoxContainer/TextGuide
@onready var panel_container: PanelContainer = $PanelContainer

func set_data(text: String):
	text_guide.text = text
	
func on_show():
	visible = true
	get_tree().paused = true

func _on_close_button_pressed():
	visible = false
	get_tree().paused = false

func get_size_panel() -> Vector2:
	return panel_container.size
