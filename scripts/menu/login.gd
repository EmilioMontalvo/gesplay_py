extends Node2D

@onready var user_input = $CanvasLayer/Control/User
@onready var password_input = $CanvasLayer/Control/Password
@onready var login_button = $CanvasLayer/Control/Login
@onready var register_link = $CanvasLayer/Control/Register
@onready var login_guest_button = $CanvasLayer/Control/LoginGuest
@onready var no_internet_message = $CanvasLayer/Control/NoInternetMessage
@onready var no_internet_animation = $NoConnectionAnimation
@onready var user_lbl = $CanvasLayer/Control/UserLbl
@onready var password_lbl = $CanvasLayer/Control/PasswordLbl
@onready var panel = $CanvasLayer/Control/Panel

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
	SoundControllerMenu.play_music()
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
	user_input.queue_free()
	password_input.queue_free()
	register_link.queue_free()
	login_button.queue_free()
	user_lbl.queue_free()
	password_lbl.queue_free()
	panel.size.y = 179
	login_guest_button.visible = true
	no_internet_message.visible = true
	no_internet_animation.visible = true
