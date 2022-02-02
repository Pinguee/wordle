extends Control
class_name End

var winLose = {
	"win" : "T'as gagné sale BG", 
	"lose" : "T'as perdu sale nul"
}

onready var button = get_node("Button")

func win(win : bool):
	if win:
		$Panel/Label.text = "T'as gagné sale BG"
	else:
		$Panel/Label.text = "T'as perdu sale nul"

func _ready():
	button.connect("pressed", self, "_button_pressed")

func _button_pressed():
	get_tree().change_scene("res://Scenes/Main.tscn")
