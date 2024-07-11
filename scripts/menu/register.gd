extends Control

var http_request: HTTPRequest
var endpoint="/register"
@onready var email=$CanvasLayer/Control/Panel/LineEdit
@onready var password=$CanvasLayer/Control/Panel/LineEdit2
@onready var confirm_password=$CanvasLayer/Control/Panel/LineEdit3
@onready var error_label=$CanvasLayer/Control/Panel/ErrorLabel
@onready var register_link=$CanvasLayer/Control/Panel/LinkButton
@onready var animation=$CanvasLayer/Control/Panel/AnimatedSprite2D

var mail_screen=preload("res://scenes/menu/pages/mail_send.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	http_request = HTTPRequest.new()
	if RequestManager.api_is_up:
		add_child(http_request)
		http_request.request_completed.connect(_on_request_completed)
		
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_request_completed(result, response_code, headers, body):
	unblock_input()
	if response_code==400:
		error_label.text="Ya existe una cuenta con este correo"
		return
	if response_code==422:
		error_label.text="datos inválidos"
		return
	if response_code==200:
		MenuManager.load_packed_scene(mail_screen)
		return

func _on_button_pressed():
	if not email_validate(email.text):
		error_label.text="Ingrese un correo válido"
		return
	var validate_message=validate_password(password.text)
	
	if password.text != confirm_password.text:
		error_label.text="Las contraseñas no coinciden"
		return
	
	if validate_message != "":
		error_label.text=validate_message
		return
	
	var body={
		"email":email.text,
		"password":password.text
	}
	block_input()
	if http_request:
		var route=RequestManager.api_route+endpoint
		var body_string=JSON.new().stringify(body)
		http_request.request(route,[],HTTPClient.METHOD_POST,body_string)

func email_validate(email:String) -> bool:
	var email_regex := RegEx.new()  
	var domain_name_regex_str := "[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?"
	var domain_regex_str := domain_name_regex_str + "(?:\\." + domain_name_regex_str + ")*"
	email_regex.compile("^[a-zA-Z0-9.!#$%&'*+/=?^_\u0060{|}~-]+@" + domain_regex_str + "$")
	return email_regex.search(email) != null

func validate_password(password: String) -> String:
	var password_regex_upper = RegEx.new()
	var password_regex_lower = RegEx.new()
	var password_regex_digit = RegEx.new()
	var password_regex_special = RegEx.new()

	# Definir expresiones regulares
	password_regex_upper.compile("[A-Z]")
	password_regex_lower.compile("[a-z]")
	password_regex_digit.compile("\\d")
	password_regex_special.compile("[!@#$%^&*(),.?\":{}|<>]")

	# Verificar cada condición
	if password.length() < 8:
		return "La contraseña debe tener al menos 8 caracteres."
	if password.length() > 128:
		return "La contraseña no puede tener más de 128 caracteres."
	if not password_regex_upper.search(password):
		return "La contraseña debe tener al menos una letra mayúscula."
	if not password_regex_lower.search(password):
		return "La contraseña debe tener al menos una letra minúscula."
	if not password_regex_digit.search(password):
		return "La contraseña debe tener al menos un número."
	if not password_regex_special.search(password):
		return "La contraseña debe tener al menos un carácter especial."

	return ""  # La contraseña es válida

func block_input():
	email.editable=false
	password.editable=false
	confirm_password.editable=false
	register_link.disabled=true
	error_label.text=""
	animation.visible=true

func unblock_input():
	email.editable=true
	password.editable=true
	confirm_password.editable=true
	register_link.disabled=false
	animation.visible=false



func _on_show_password_toggled(toggled_on):
	password.secret=not toggled_on


func _on_confirmation_dialog_option_selected(option):
	if option:
		get_tree().quit()
	else:
		$ConfirmationDialog.visible=false
