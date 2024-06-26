extends Control

@onready var image: TextureRect = $PanelContainer/CenterContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Image
@onready var text: Label = $PanelContainer/CenterContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Text
@onready var page_number: Label = $PanelContainer/CenterContainer/MarginContainer/VBoxContainer/PageNumber
@onready var button_back: TextureButton = $PanelContainer/CenterContainer/MarginContainer/VBoxContainer/HBoxContainer/ButtonBack
@onready var button_next: Button = $PanelContainer/CenterContainer/MarginContainer/VBoxContainer/HBoxContainer/ButtonNext

var data: Array
var total_pages: int
var actual_page: int = 1

func _ready():
	set_actual_page_number(actual_page)
	button_back.disabled = true

func set_actual_page_number(page: int):
	page_number.text = str(page) + " / " + str(total_pages)

func set_page_data(page: int):
	image.texture = data[page - 1].image
	text.text = data[page - 1].text

func _on_button_back_pressed():
	if actual_page > 1:
		actual_page -= 1
		set_actual_page_number(actual_page)
		set_page_data(actual_page)
		button_next.disabled = false
		if actual_page == 1:
			button_back.disabled = true

func _on_button_next_pressed():
	if actual_page < total_pages:
		actual_page += 1
		set_actual_page_number(actual_page)
		set_page_data(actual_page)
		button_back.disabled = false
		if actual_page == total_pages:
			button_next.disabled = true

func on_show():
	visible = true
	set_page_data(actual_page)
	#set_global_position(get_viewport_rect().size / 2)
	set_global_position(Vector2((get_viewport_rect().size.x / 2) - size.x / 2, (get_viewport_rect().size.y / 2) - size.y / 2))
	get_tree().paused = true

func _on_close_button_pressed():
	visible = false
	get_tree().paused = false

func set_data(guide_data: Array):
	data = guide_data
	total_pages = data.size()
	set_actual_page_number(actual_page)
