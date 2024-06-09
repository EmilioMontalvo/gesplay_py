extends Line2D

@export var drawTrail=false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if drawTrail:
		add_point(get_global_mouse_position())
		if points.size()>10:
			remove_point(0)


func _on_panel_mouse_entered():
	drawTrail=true


func _on_panel_mouse_exited():
	drawTrail=false
	points=[]
