extends Node

@onready var timeLabel=$Label

var running = true;
var elapsed = 0;


func _ready():
	pass # Replace with function body.

func _process(delta):
	if (running):
		elapsed += delta;
	timeLabel.text = "%0.2f" % elapsed

func get_time():
	return "%0.2f" % elapsed

func stop():
	running=false
