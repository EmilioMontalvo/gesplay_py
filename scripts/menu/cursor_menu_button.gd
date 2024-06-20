extends MenuButton

@onready var popup=get_popup()
# Called when the node enters the scene tree for the first time.
func _ready():
	popup.id_pressed.connect(change_icon)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func change_icon(id):
	var popupIcon=popup.get_item_icon(id)
	icon=popupIcon
	CursorIconConf.cursor_id=id
	CursorIconConf.send_update_to_upd()
