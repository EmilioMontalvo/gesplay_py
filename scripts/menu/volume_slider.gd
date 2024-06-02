extends HBoxContainer

@export var bus_name: String

@onready var volume_slider: HSlider = $VolumeSlider
@onready var mute_button: Button = $Button
@onready var volume_label: Label = $Label
@onready var volume_up_icon = preload("res://assets/buttons/icons/volume_up_48.png")
@onready var volume_mute_icon = preload("res://assets/buttons/icons/volume_mute_48.png")

var bus_index: int
var last_volume_linear: float

func _ready():
	mute_button.size = Vector2(0.5,0.5)
	bus_index = AudioServer.get_bus_index(bus_name)
	volume_slider.value_changed.connect(_on_value_changed)
	volume_slider.value = get_current_volume_linear()
	set_volume_icon()

func _on_value_changed(value: float):
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	volume_label.text = str(get_volume_string(value))
	set_volume_icon()

func _on_button_pressed():
	if(get_current_volume_linear() > 0):
		last_volume_linear = get_current_volume_linear()
		set_volume_icon_slider(0)
	else:
		set_volume_icon_slider(last_volume_linear)

func get_volume_string(value: float) -> String:
	return str(int(value * 100))

func set_volume_icon():
	if(get_current_volume_linear() <= 0):
		mute_button.icon = volume_mute_icon
	else:
		mute_button.icon = volume_up_icon

func get_current_volume_linear() -> float:
	return db_to_linear(AudioServer.get_bus_volume_db(bus_index))

func set_volume_icon_slider(value: float):
	AudioServer.set_bus_volume_db(bus_index, value)
	set_volume_icon()
	volume_slider.value = value
