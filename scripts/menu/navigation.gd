extends Control

@export var scene:int = 1
@export var locked=false
@export var confirm_dialog=false
@export var confirm_dialog_text="Salir sin guardar"

@onready var confirm_control=$ConfirmDialogWindow


func _on_pressed():
	
	if confirm_dialog:
		confirm_control.visible=true
	else:
		if not locked:
			MenuManager.load_menu(scene)


func _on_acept_pressed():
	pass # Replace with function body.


func _on_focus_entered():
	modulate=Color(0.5,0.5,0.5,0.5)


func _on_focus_exited():
	modulate=Color(1,1,1,1)


func _on_confirm_dialog_window_acepted():
	if not locked:
			MenuManager.load_menu(scene)


func _on_confirm_dialog_window_canceled():
	confirm_control.visible=false
