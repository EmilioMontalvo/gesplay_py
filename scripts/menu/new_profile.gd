extends Control

@onready var file_dialog: FileDialog = $FileDialog
@onready var file_upload_button: Button = $VBoxContainer/HBoxContainer3/ImagesList/VBoxContainer/HBoxContainer3/FileUpload
@onready var txt_firt_name: LineEdit = $VBoxContainer/HBoxContainer/FirstName/VBoxContainer/TxtFirstName
@onready var txt_last_name: LineEdit = $VBoxContainer/HBoxContainer/LastName/VBoxContainer/TxtSecondName
@onready var texture_image_profile: TextureRect = $VBoxContainer/HBoxContainer3/ImageUpload/VBoxContainer/Panel/TextureRect
@onready var panel_image: Panel = $VBoxContainer/HBoxContainer3/ImageUpload/VBoxContainer/Panel

var button_group_images: ButtonGroup = ButtonGroup.new()
var image_path: String
var profile_id: String
var dir_access: DirAccess
var custom_profile_image: Image
var current_profile_image: Image
var profile_data: Dictionary
var has_custom_image: bool = false
var first_attempt_name: bool = true
var first_attempt_image: bool = true
var is_editing: bool = false
var request_save_profile: HTTPRequest
var request_save_profile_signal: Signal

var CUSTOM_IMAGES_PATH = "user://custom_images/"

func _ready():
	if CurrentProfile.is_first_profile:
		$VBoxContainer/FirstProfileAlert.visible = true
		$Home.visible = false
		$GoBack.visible = false
		$AceptCancel/Cancel.queue_free()
	for button_image in get_tree().get_nodes_in_group('default_images'):
		button_image.button_group = button_group_images
		button_image.pressed.connect(_on_change_image_default)
	if is_editing:
		txt_firt_name.text = profile_data["first_name"]
		txt_last_name.text = profile_data["last_name"]
		image_path = profile_data["image_path"]
		if GlobalConf.invite_mode:
			set_profile_image_preview(image_path)
		else:
			set_init_profile_image_preview_api(image_path)
	if not GlobalConf.invite_mode:
		request_save_profile = HTTPRequest.new()
		add_child(request_save_profile)
		request_save_profile.request_completed.connect(_on_request_save_profile_completed)
		request_save_profile_signal = request_save_profile.request_completed                                                                                   
 
func _on_file_upload_pressed():
	file_dialog.visible = true

func get_data_as_json() -> Dictionary:
	var new_profile_data: Dictionary = {
		"id": profile_id,
		"first_name": txt_firt_name.text.strip_edges(),
		"last_name": txt_last_name.text.strip_edges(),
		"image_path": image_path,
		"max_click_level": 1,
		"max_cursor_level": 1
	}
	return new_profile_data 

func _on_acept_pressed():
	if (txt_firt_name.text.is_empty() or txt_last_name.text.is_empty()):
		if first_attempt_name:
			var first_name_parent = txt_firt_name.get_parent()
			var new_label = Label.new()
			new_label.text = "Debe ingresar un nombre y apellido"
			new_label.add_theme_font_size_override("font_size",20)
			new_label.add_theme_color_override("font_color",Color.DARK_RED)
			first_name_parent.add_child(new_label)
			first_attempt_name = false
		return
	if image_path.is_empty():
		if first_attempt_image:
			var image_parent = get_node("VBoxContainer/HBoxContainer3/ImagesList/VBoxContainer")
			var new_label = Label.new()
			new_label.text = "Debe seleccionar o cargar una imagen"
			new_label.add_theme_font_size_override("font_size",20)
			new_label.add_theme_color_override("font_color",Color.DARK_RED)
			image_parent.add_child(new_label)
			first_attempt_image = false
		return
	profile_id = MinosUUIDGenerator.generate_new_UUID()
	if has_custom_image:
		custom_profile_image.resize(72,72)
		if GlobalConf.invite_mode:
			DirAccess.make_dir_absolute(CUSTOM_IMAGES_PATH)
			var new_image_path = CUSTOM_IMAGES_PATH + (profile_data.get("id") if is_editing else profile_id) + ".png"
			custom_profile_image.save_png(new_image_path)
			image_path = new_image_path
	if is_editing:
		var profile_edited = get_data_as_json()
		profile_edited["id"] = profile_data["id"]
		if GlobalConf.invite_mode:
			DataSaver.save_profile(profile_edited)
		else:
			#ApiDataSaver.edit_profile(profile_edited)
			var endpoint_path = ApiDataSaver.PROFILES_ENDPOINT + "/" + profile_edited.get("id")
			request_save_profile.request(
				RequestManager.get_endpoint_path(endpoint_path),
				RequestManager.get_auth_headers(),
				HTTPClient.METHOD_PUT,
				JSON.stringify(profile_edited)
			)
			await request_save_profile_signal
		CurrentProfile.reload_data()
	else:
		if GlobalConf.invite_mode:
			DataSaver.save_profile(get_data_as_json())
			DataSaver.save_settings(Constants.DEFAULT_SETTINGS, profile_id)
			GameDataController.save_initial_game_data(profile_id)
		else:
			request_save_profile.request(
				RequestManager.get_endpoint_path(ApiDataSaver.PROFILES_ENDPOINT),
				RequestManager.get_auth_headers(),
				HTTPClient.METHOD_POST,
				JSON.stringify(get_data_as_json())
			)
			await request_save_profile_signal
			#ApiDataSaver.save_profile(get_data_as_json())
	if CurrentProfile.is_first_profile:
		CurrentProfile.is_first_profile = false
	MenuManager.load_menu(3)

func _on_change_image_default():
	panel_image.visible = true
	has_custom_image = false
	image_path = button_group_images.get_pressed_button().icon.resource_path
	set_profile_image_preview(image_path)

func _on_file_dialog_file_selected(path):
	image_path = path
	has_custom_image = true
	custom_profile_image = Image.load_from_file(path)
	set_profile_image_preview(image_path)
	if button_group_images.get_pressed_button() != null:
		button_group_images.get_pressed_button().button_pressed = false
	
func set_profile_image_preview(path: String):
	panel_image.visible = true
	current_profile_image = Image.load_from_file(path)
	var texture = ImageTexture.create_from_image(current_profile_image)
	texture.set_size_override(Vector2i(150,150))
	texture_image_profile.texture = texture

func set_init_profile_image_preview_api(image_url):
	var http_request_profile_image = HTTPRequest.new()
	add_child(http_request_profile_image)
	http_request_profile_image.request_completed.connect(_on_request_profile_image_completed)
	http_request_profile_image.request(image_url, [], HTTPClient.METHOD_GET)

func _on_request_profile_image_completed(result, response_code, headers, body):
	panel_image.visible = true
	var profile_image = Image.new()
	profile_image.load_png_from_buffer(body)
	var texture = ImageTexture.create_from_image(profile_image)
	texture.set_size_override(Vector2i(150,150))
	texture_image_profile.texture = texture

func _on_request_save_profile_completed(result, response_code, headers, body):
	var response: Dictionary = JSON.parse_string(body.get_string_from_utf8())
	var new_profile_id = str(response.get("id"))
	var image_to_send = current_profile_image
	image_to_send.resize(72,72)
	ApiDataSaver.update_profile_image(new_profile_id,image_to_send) 
