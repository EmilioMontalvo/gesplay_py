extends MenuButton

@onready var profile_image: TextureRect = $MarginContainer/HBoxContainer/ProfileImage
@onready var profile_name: Label = $MarginContainer/HBoxContainer/ProfileName
@onready var confirmation_dialog = $ConfirmationDialog

@export var dialog_message: bool = false

const DIALOG_TEXT = "¿Estas seguro de abandonar el nivel?"

func _ready():
	if CurrentProfile.is_profile_selected:
		profile_name.text = CurrentProfile.first_name + " " + CurrentProfile.last_name
		set_profile_image(CurrentProfile.image_path)
	var popup_menu: PopupMenu = get_popup()
	popup_menu.id_pressed.connect(_on_option_selected)
	confirmation_dialog.set_dialog_text(DIALOG_TEXT)
	
func set_profile_image(path: String):
	if GlobalConf.invite_mode:
		var profile_image = Image.load_from_file(path)
		var texture = ImageTexture.create_from_image(profile_image)
		texture.set_size_override(Vector2i(48,48))
		$MarginContainer/HBoxContainer/ProfileImage.texture = texture
	
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
