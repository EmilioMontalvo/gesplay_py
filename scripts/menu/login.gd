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
@onready var panel = $CanvasLayer/Panel
@onready var error_lbl = $CanvasLayer/Control/ErrorLabel

var http_request: HTTPRequest
var http_request_login: HTTPRequest
var http_request_load_last_profile: HTTPRequest
var endpoint="/token"
var http_client = HTTPClient.new()

signal data_loaded

func _ready():
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)
	http_request.request("https://example.com/")
	http_request_load_last_profile = HTTPRequest.new()
	add_child(http_request_load_last_profile)
	http_request_load_last_profile.request_completed.connect(_on_last_profile_request_completed)
	user_input.grab_focus()
	
	if not RequestManager.api_is_up:
		set_invite_mode()
	else:
		#login request
		http_request_login = HTTPRequest.new()
		add_child(http_request_login)
		http_request_login.request_completed.connect(_on_login_request_completed)


func _on_request_completed(result, response_code, headers, body):
	if response_code != 200:
		set_invite_mode()

func _on_login_pressed():
	
	if GlobalConf.invite_mode:
		set_invite_mode()
		SoundControllerMenu.play_music()

	if password_input.text=="" or user_input.text =="":
		error_lbl.text="Ingrese su correo y contraseña"
		return
	
	if not email_validate(user_input.text):
		error_lbl.text="Ingrese un correo válido"
		return
	
	var body={
		"grant_type":"",		
		"username":user_input.text,
		"password":password_input.text,
		"scope":"",
		"client_id":"",
		"client_secret":""
	}
	
	var route=RequestManager.api_route+endpoint
	var query_string = http_client.query_string_from_dict(body)
	var headers=["accept: application/json","Content-Type: application/x-www-form-urlencoded"]
	http_request_login.request(route,headers,HTTPClient.METHOD_POST,query_string)
	
	block_input()

func _on_login_request_completed(result, response_code, headers, body):
	enable_input()
	SoundControllerMenu.play_music()
	var json = JSON.parse_string(body.get_string_from_utf8())
	if response_code==200:
		RequestManager.token=json["access_token"]
		$CanvasLayer/AnimatedSprite2D.visible=true
		$CanvasLayer/loanding.visible=true
		$CanvasLayer/Control.visible=false
		error_lbl.text=""
		load_login_data()
		return
	if response_code==401:
		if json["detail"] == "Incorrect username or password":
			error_lbl.text="Correo o contraseña incorrectos"
		else:
			error_lbl.text="La cuenta no está verificada, revisa tu correo"
		return
	if response_code==422:
		error_lbl.text="Correo o contraseña incorrectos"
		return

func _on_last_profile_request_completed(result, response_code, headers, body):
		if response_code == 404 and not CurrentProfile.is_profile_selected:
			MenuManager.load_menu(3)
		if response_code == 200:
			var profile_data: Dictionary = JSON.parse_string(body.get_string_from_utf8())
			profile_data["id"] = str(profile_data.get("id"))
			CurrentProfile.set_data_from_dic(profile_data)
			CurrentProfile.is_profile_selected = true
			#SavedSettingsLoader.load_saved_settings()
			MenuManager.load_menu(1)
	
func load_login_data():
	#TODO: set current profile
	http_request_load_last_profile.request(
		RequestManager.get_endpoint_path(ApiDataSaver.LAST_PROFILE_ENDPOINT),
		RequestManager.get_auth_headers(),
		HTTPClient.METHOD_GET
	)
	await http_request_load_last_profile.request_completed

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
	GlobalConf.invite_mode=true
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
	login_guest_button.grab_focus()

func email_validate(email:String) -> bool:
	var email_regex := RegEx.new()  
	var domain_name_regex_str := "[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?"
	var domain_regex_str := domain_name_regex_str + "(?:\\." + domain_name_regex_str + ")*"
	email_regex.compile("^[a-zA-Z0-9.!#$%&'*+/=?^_\u0060{|}~-]+@" + domain_regex_str + "$")
	return email_regex.search(email) != null

func block_input():
	user_input.editable=false
	password_input.editable=false
	login_button.disabled=true
	register_link.disabled=true

func enable_input():
	user_input.editable=true
	password_input.editable=true
	login_button.disabled=false
	register_link.disabled=false




func _on_show_password_toggled(toggled_on):
	password_input.secret=not toggled_on
