extends Control

@export var number=0
# Called when the node enters the scene tree for the first time.
func _ready():
	set_stars(number)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_stars(starNumber):
	number=starNumber
	if number==1:
		$star.visible=true
	elif number==2:
		$star2.visible=true
	elif number==3:
		$star3.visible=true
