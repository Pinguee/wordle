extends VBoxContainer

var french_keyboard : PoolStringArray = ["AZERTYUIOP","QSDFGHJKLM","WXCVBN"]
onready var rows := get_children()
var keys = []

func _ready():
	for i in range(len(french_keyboard)):
		keys = rows[i].get_children()
		for j in range(len(french_keyboard[i])):
			var key = Keycaps.new()
			key.set_letter(french_keyboard[i][j])
			rows[i].add_child(key)
