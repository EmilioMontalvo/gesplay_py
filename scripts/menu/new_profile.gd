extends Control

@onready var file_dialog: FileDialog = $FileDialog
@onready var file_upload_button: Button = $VBoxContainer/HBoxContainer3/ImageUpload/VBoxContainer/FileUpload
@onready var txt_firt_name: TextEdit = $VBoxContainer/HBoxContainer/FirstName/VBoxContainer/TxtFirstName
@onready var txt_last_name: TextEdit = $VBoxContainer/HBoxContainer/LastName/VBoxContainer/TxtSecondName

var uuid: UUIDManager
var button_group_images: ButtonGroup = ButtonGroup.new()
var image_path: String
var dir_access: DirAccess
var custom_profile_image: Image
var has_custom_image: bool = false
var first_attempt_name: bool = true
var first_attempt_image: bool = true

func _ready():
	for button_image in get_tree().get_nodes_in_group('default_images'):
		button_image.button_group = button_group_images
		button_image.pressed.connect(_on_change_image_default)                                                                                       
 
func _on_file_upload_pressed():
	file_dialog.visible = true

func get_data_as_json() -> Dictionary:
	var new_profile_data: Dictionary = {
		"first_name": txt_firt_name.text,
		"last_name": txt_last_name.text,
		"image_path": image_path
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
	if has_custom_image:
		custom_profile_image.resize(72,72)
		var new_image_path = "res://assets/profile_images/custom_upload/"+MinosUUIDGenerator.generate_new_UUID()+".png"
		custom_profile_image.save_png(new_image_path)
		image_path = new_image_path
	print(get_data_as_json())
	DataSaver.save_profile(get_data_as_json())

func _on_change_image_default():
	has_custom_image = false
	image_path = button_group_images.get_pressed_button().icon.resource_path

func _on_file_dialog_file_selected(path):
	custom_profile_image = Image.load_from_file(path)
	var texture = ImageTexture.create_from_image(custom_profile_image)
	texture.set_size_override(Vector2i(150,150))
	file_upload_button.icon = texture
	image_path = path
	has_custom_image = true
