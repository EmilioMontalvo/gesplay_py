extends AspectRatioContainer

@onready var time_lable = $HBoxContainer/Time

var running = true;
var elapsed = 0;

func _process(delta):
	if (running):
		elapsed += delta;
		time_lable.text = get_time()

func get_time():
	return "%0.2f" % elapsed

func stop():
	running = false
	
func set_time(time: String):
	time_lable.text = time
