extends StaticBody2D

@export var icon: Texture

@onready var sprite: Sprite2D = $Sprite2D

func _ready():
	sprite.texture = icon
