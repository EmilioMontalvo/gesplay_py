extends Node

@onready var spinBox=$SpinBox
@onready var slider=$HSlider3

@export var help_text="Insert help text"
@export var value=16

signal value_changed
# Called when the node enters the scene tree for the first time.
func _ready():
	spinBox.update_on_text_changed = true
	spinBox.value=value
	slider.value=value
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_value(new_value):
	value=new_value
	spinBox.value=value
	slider.value=value

func _on_h_slider_3_value_changed(value):
	spinBox.value=value
	value_changed.emit(value)


func _on_spin_box_value_changed(value):
	slider.value=value
	value_changed.emit(value)


func _on_help_button_help_request():
	print(help_text)
