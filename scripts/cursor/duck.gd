extends Node2D

@onready var sprite=$AnimatedSprite2D
@onready var body=$ObjectiveBody2D

@export var animated_sprite:String=""
@export var objectivePoints=200

@onready var penguin=preload("res://scenes/menu/pages/cursor/elements/penguin.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	if animated_sprite == "penguin":
		var penguin_intance=penguin.instantiate()
		sprite.sprite_frames=penguin_intance.sprite_frames



func get_value():
	return objectivePoints

func explode():
	sprite.animation="happy"
	body.queue_free()
	$WinAudio.play()
	$Quack.play()
