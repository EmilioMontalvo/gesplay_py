extends Control

@onready var lbl_profile_name:Label = $HBoxContainer/CurrentProfile/ProfileName
@onready var profile_image_texture: TextureRect = $HBoxContainer/CurrentProfile/ProfileImage

var current_profile_data: Dictionary
var http_request_profile_image: HTTPRequest

func _ready():
	current_profile_data = CurrentProfile.get_profile_data()
	lbl_profile_name.text = current_profile_data.get("first_name") + " " + current_profile_data.get("last_name")
	if GlobalConf.invite_mode:
		set_profile_image(current_profile_data.get("image_path"))
	else:
		set_profile_image_api(current_profile_data.get("image_path"))
	$HBoxContainer/Configs/BtnGeneralSettings.grab_focus()
	
func set_profile_image(path: String):
	var profile_image = Image.load_from_file(path)
	var texture = ImageTexture.create_from_image(profile_image)
	texture.set_size_override(Vector2i(300,300))
	profile_image_texture.texture = texture

func set_profile_image_api(image_url: String):
	http_request_profile_image =  HTTPRequest.new()
	add_child(http_request_profile_image)
	http_request_profile_image.request_completed.connect(_on_profile_image_request_complete)

func _on_profile_image_request_complete(result, response_code, headers, body):
	var profile_image = Image.new()
	profile_image.load_png_from_buffer(body)
	var texture_image = ImageTexture.create_from_image(profile_image)
	texture_image.set_size_override(Vector2i(300,300))
	profile_image_texture.texture = texture_image

func _on_btn_edit_profile_pressed():
	var new_profile_instance = preload("res://scenes/menu/pages/new_profile2.tscn").instantiate()
	new_profile_instance.profile_data = current_profile_data
	new_profile_instance.is_editing = true
	
	MenuManager.load_instace_menu(new_profile_instance)
	
