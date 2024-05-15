extends StaticBody2D

@export var type: String
@export var icon: Texture

@onready var sprite: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.texture = icon
	modulate = Color('#F6EEDE',0.7)


func get_type() -> String:
	return type
