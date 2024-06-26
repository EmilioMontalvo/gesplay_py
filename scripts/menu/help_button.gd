extends Button

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

@onready var guide = $GameGuide

func _ready():
	guide.set_data(guide_data)

func _on_pressed():
	guide.on_show()
