extends Node2D

@onready var sprite=$AnimatedSprite2D
@onready var body=$ObjectiveBody2D


@export var objectivePoints=200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_value():
	return objectivePoints

func explode():
	sprite.animation="happy"
	body.queue_free()
	$WinAudio.play()
	$Quack.play()
