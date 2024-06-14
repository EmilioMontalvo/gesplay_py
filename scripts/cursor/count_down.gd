extends Control

@export var time=10
@onready var label = $Label

var timer = Timer.new()

signal time_up
# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = str(time)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Function to start the countdown
func _start_countdown():
	timer.wait_time = 1.0  # 1 second intervals
	timer.connect("timeout", _on_timer_timeout)
	add_child(timer)
	timer.start()

# Function to handle the timer timeout signal
func _on_timer_timeout():
	if time > 0:
		time -= 1
		label.text = str(time)
	else:
		timer.stop()
		time_up.emit()
