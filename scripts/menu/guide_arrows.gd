extends Marker2D

@onready var line=$"../Line2D"
# Called when the node enters the scene tree for the first time.
func _ready():
	line.set_point_position(0,position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(global_position)
	line.set_point_position(1,get_local_mouse_position()/line.scale)

func set_target(point:Vector2):
	line.set_point_position(0,point/line.scale)
