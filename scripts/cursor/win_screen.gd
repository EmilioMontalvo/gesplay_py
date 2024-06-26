extends Control

@export var next_level=2
@export var last=false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_points(points):
	$points.text=str(points)
	if points >= 650:
		$"3Stars".visible=true
	elif points >= 300:
		$"2Stars".visible=true
	else:
		$"1Star".visible=true

func set_time(time):
	$Time.text=str(time)


func _on_visibility_changed():
	$CountDown._start_countdown()
	if CurrentProfile.max_cursor_level < next_level:
		CurrentProfile.max_cursor_level=next_level
		print(CurrentProfile.max_cursor_level)
		CurrentProfile.save_profile_progress()


func _on_forward_button_pressed():
	if not last:
		var next_level_path="res://scenes/menu/pages/cursor/levels/level_"+str(next_level)+".tscn"
		MenuManager.change_to_file(next_level_path)		
	else:
		var next_level_path="res://scenes/menu/pages/cursor/levels/level_1.tscn"
		MenuManager.change_to_file(next_level_path)
