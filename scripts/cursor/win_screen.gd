extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func set_points(points):
	$points.text=str(points)
	if points >= 300:
		$"3Stars".visible=true
	elif points >= 200:
		$"2Stars".visible=true
	else:
		$"1Star".visible=true

func set_time(time):
	$Time.text=str(time)


func _on_visibility_changed():
	$CountDown._start_countdown()
