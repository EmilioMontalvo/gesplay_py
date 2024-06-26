extends Node2D

@onready var user_input = $CanvasLayer/Control/User
@onready var password_input = $CanvasLayer/Control/Password
@onready var login_button = $CanvasLayer/Control/Login
@onready var register_link = $CanvasLayer/Control/Register
@onready var login_guest_button = $CanvasLayer/Control/LoginGuest
@onready var no_internet_message = $CanvasLayer/Control/NoInternetMessage

var http_request: HTTPRequest

func _ready():
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)
	http_request.request("https://example.com/")

func _on_request_completed(result, response_code, headers, body):
	if response_code != 200:
		set_invite_mode()

func _on_button_pressed():
	var last_profile_id: String = DataSaver.load_last_profile_id()
	print(last_profile_id)
	if last_profile_id.is_empty():
		if not CurrentProfile.is_profile_selected:
			MenuManager.load_menu(3)
	else:
		var last_profile = DataSaver.load_profile_by_id(last_profile_id)
		CurrentProfile.set_data_from_dic(last_profile)
		CurrentProfile.is_profile_selected = true
		SavedSettingsLoader.load_saved_settings()
		MenuManager.load_menu(1)

func set_invite_mode():
	user_input.editable = false
	password_input.editable = false
	register_link.queue_free()
	login_button.queue_free()
	login_guest_button.visible = true
	no_internet_message.visible = true
	#var invite_button = Button.new()
	#invite_button.text = "Ingresa como invitado"
	#invite_button.global_position = login_button.global_position
	#invite_button.pressed.connect(_on_button_pressed)
	#add_child(invite_button)

