extends StaticBody2D

@export var type: String
@export var icon: Texture
@export var h_frames: int = 1
@export var color_hex: String = '000000'

@onready var sprite: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.texture = icon
	sprite.hframes = h_frames
	#modulate = Color('#F6EEDE',0.7)
	modulate = Color('#'+color_hex,1.0)

func get_type() -> String:
	return type
