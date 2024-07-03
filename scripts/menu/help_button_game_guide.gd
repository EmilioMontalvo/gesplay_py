extends Button

@onready var help_dialog:Popup=$GameGuidePopup
@onready var dialog:Control=$GameGuidePopup/GameGuide
@onready var dialog_panel:Control=$GameGuidePopup/GameGuide/PanelContainer

@export var guide_data = [
	{
	"text": "This is a guide text1",
	"image": preload("res://assets/cursor_game/levels/icons/level_1.png")
	},
	{
	"text": "This is a guide text2",
	"image": preload("res://assets/buttons/icons/cursor_game_icon.png")
	},
	{
	"text": "This is a guide text3",
	"image": preload("res://assets/cursor_game/levels/icons/level_1.png")
	},
	{
	"text": "This is a guide text4",
	"image": preload("res://assets/cursor_game/levels/icons/level_1.png")
	},
]

func _ready():
	dialog.set_data(guide_data)
	print(help_dialog.size,dialog_panel.size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	help_dialog.visible=not help_dialog.visible
	if help_dialog.visible:
		dialog.on_show()
