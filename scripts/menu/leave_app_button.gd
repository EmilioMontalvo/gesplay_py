extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_pressed():
	$"../ConfirmationDialog".visible=true
	


func _on_focus_entered():
	modulate=Color(0.5,0.5,0.5,0.5)


func _on_focus_exited():
	modulate=Color(1,1,1,1)
