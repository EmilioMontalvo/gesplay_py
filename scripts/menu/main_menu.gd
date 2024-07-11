extends Control

@onready var button_select_profile:Button=$MenuButtons/BtnSelectProfile

func _ready():
	button_select_profile.call_deferred("grab_focus")
	if GlobalConf.invite_mode:
		$MenuButtons/BtnReport.disabled=true

func _on_btn_select_webcam_pressed():
	$ListWebcam.visible=true
	

func _on_list_webcam_finalized():
	pass # Replace with function body.
				


func _on_confirmation_dialog_option_selected(option):
	if option:
		get_tree().quit()
	else:
		$ConfirmationDialog.visible=false


func _on_btn_report_pressed():
	$ConfirmationDialog2.visible=true


func _on_confirmation_dialog_2_option_selected(option):
	if option:
		OS.shell_open("https://gestplay-reports.vercel.app")
		$ConfirmationDialog2.visible=false
	else:
		$ConfirmationDialog2.visible=false
