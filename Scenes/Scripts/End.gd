extends Control
class_name End

onready var button = $Background/VBoxContainer/Button
onready var label = $Background/VBoxContainer/Label

func _ready():
	hide()

func win(win : bool):
	show()
	if win:
		label.text = "Bien ouej! :D"
	else:
		label.text = "Nooooooo! :("
