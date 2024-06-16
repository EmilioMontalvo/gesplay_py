extends Control

@export var number=0
# Called when the node enters the scene tree for the first time.
func _ready():
	if number==1:
		$star.visible=true
	elif number==2:
		$star2.visible=true
	elif number==3:
		$star3.visible=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
