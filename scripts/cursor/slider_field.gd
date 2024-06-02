extends Node

@onready var spinBox=$SpinBox
@onready var slider=$HSlider3

signal value_changed
# Called when the node enters the scene tree for the first time.
func _ready():
	spinBox.update_on_text_changed = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_h_slider_3_value_changed(value):
	spinBox.value=value
	value_changed.emit()


func _on_spin_box_value_changed(value):
	slider.value=value
	value_changed.emit()
