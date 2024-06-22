extends AspectRatioContainer

@export var time: int = 15

@onready var time_left_lbl: Label =  $HBoxContainer/TimeLeft
@onready var timer: Timer = $Timer

signal timeout_level

func _ready():
	timer.wait_time = time
	timer.timeout.connect(_on_timer_timeout)
	timer.autostart = true
	timer.start(time)

func _process(delta):
	time_left_lbl.text = str(int(timer.time_left))
	
func _on_timer_timeout():
	timeout_level.emit()
	print('timeout')
