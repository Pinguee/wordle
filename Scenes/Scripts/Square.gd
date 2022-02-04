extends Panel
class_name Square

enum {NOT_IN_WORD, FOUND, IN_WORD, NOT_TESTED, WRONG_LETTER, UNDEFINED}

var state : int = UNDEFINED
onready var anim_player = get_node("AnimationPlayer")

func _ready():
	set_state(UNDEFINED)

func set_state(new_state : int, letter : String = ''):
	state = new_state
	$Label.text = letter
	
	match new_state : 
		UNDEFINED :
			$Label.hide()
			self_modulate = Color("#1f1f1f")
		FOUND :
			$Label.show()
			self_modulate = Color("#80cd61")
		NOT_IN_WORD :
			$Label.show()
			self_modulate = Color("#2f2f2f")
		IN_WORD :
			$Label.show()
			self_modulate = Color("#ffa300")
		NOT_TESTED : 
			$Label.show()
			self_modulate = Color("#1f1f1f")
		WRONG_LETTER :
			$Label.show()
			self_modulate = Color("#fd5453")

func shake():
	anim_player.play("Shake")
