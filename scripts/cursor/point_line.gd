extends Line2D

@export var type="dirt"

# Called when the node enters the scene tree for the first time.
func _ready():
	var pellet_scene=preload("res://scenes/menu/pages/cursor/elements/pellet.tscn")
	
	for x in points:
		var instance=pellet_scene.instantiate()
		instance.global_position=x
		instance.type=type
		add_child(instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func destroy_point():
	pass
