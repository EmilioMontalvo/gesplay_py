extends Control

@onready var button_select_profile:Button=$MenuButtons/BtnSelectProfile

func _ready():
	button_select_profile.call_deferred("grab_focus")

func _on_btn_select_webcam_pressed():
	$ListWebcam.visible=true
	

func _on_list_webcam_finalized():
	pass # Replace with function body.
				
