extends StaticBody2D

@export var type: String
@export var icon: Texture
@export var h_frames: int = 1

@onready var sprite: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.texture = icon
	sprite.hframes = h_frames
	#modulate = Color('#F6EEDE',0.7)
	modulate = Color('#000000',1.0)


func get_type() -> String:
	return type
