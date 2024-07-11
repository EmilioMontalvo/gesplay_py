extends MenuButton

@onready var profile_image: TextureRect = $MarginContainer/HBoxContainer/ProfileImage
@onready var profile_name: Label = $MarginContainer/HBoxContainer/ProfileName
@onready var confirmation_dialog = $ConfirmationDialog

@export var dialog_message: bool = false

var http_request_profile_image: HTTPRequest
const DIALOG_TEXT = "¿Estas seguro de abandonar el nivel?"

func _ready():
	if CurrentProfile.is_profile_selected:
		profile_name.text = CurrentProfile.first_name + " " + CurrentProfile.last_name
		if GlobalConf.invite_mode:
			set_profile_image(CurrentProfile.image_path)
		else:
			set_profile_image_api(CurrentProfile.image_path)
	var popup_menu: PopupMenu = get_popup()
	popup_menu.id_pressed.connect(_on_option_selected)
	confirmation_dialog.set_dialog_text(DIALOG_TEXT)
	
func set_profile_image(path: String):
	var profile_image = Image.load_from_file(path)
	var texture = ImageTexture.create_from_image(profile_image)
	texture.set_size_override(Vector2i(48,48))
	$MarginContainer/HBoxContainer/ProfileImage.texture = texture

func set_profile_image_api(image_url: String):
	http_request_profile_image =  HTTPRequest.new()
	add_child(http_request_profile_image)
	http_request_profile_image.request_completed.connect(_on_profile_image_request_complete)
	http_request_profile_image.request(image_url,[],HTTPClient.METHOD_GET)

func _on_profile_image_request_complete(result, response_code, headers, body):
	var profile_image = Image.new()
	profile_image.load_png_from_buffer(body)
	var texture_image = ImageTexture.create_from_image(profile_image)
	texture_image.set_size_override(Vector2i(48,48))
	$MarginContainer/HBoxContainer/ProfileImage.texture = texture_image
	
func _on_option_selected(id: int):
	if dialog_message:
		if await confirmation_dialog.on_show():
			routing_option(id)
	else:
		routing_option(id)

func routing_option(id: int):
	match id:
		0:
			MenuManager.load_menu(MenuManager.MENU_LEVEL.SETTINGS)
		1:
			MenuManager.load_menu(MenuManager.MENU_LEVEL.PROFILES)
		2:
			MenuManager.load_menu(MenuManager.MENU_LEVEL.LOGIN)
