extends Window


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_control_computer_configuration_drag():
	pass # Replace with function body.


func _on_control_computer_configuration_cancel():
	visible=false

func update_son():
	$Camera2D/ControlComputerConfiguration/PopUpDragPanel.update_window_id()
