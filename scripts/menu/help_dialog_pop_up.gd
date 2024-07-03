extends Popup

@onready var text_guide: Label = $MenuGuide/PanelContainer/CenterContainer/MarginContainer/VBoxContainer/TextGuide
@onready var panel_container: PanelContainer = $MenuGuide/PanelContainer
	
func _ready():
	transparent_bg=true

func set_data(text: String):
	text_guide.text = text
	set_size(Vector2i(540, 877))
	print(get_size(),panel_container.size)
	
func on_show():
	visible = true

func _on_close_button_pressed():
	visible = false

func get_size_panel() -> Vector2:
	return panel_container.size


func _on_close_button_visibility_changed():
	$MenuGuide/PanelContainer/CenterContainer/MarginContainer/VBoxContainer/CloseButton.grab_focus()
