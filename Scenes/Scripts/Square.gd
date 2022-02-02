extends Panel
class_name Square

enum State {FOUND, NOT_IN_WORD, IN_WORD, NOT_TESTED, UNDEFINED}
var current_state : int = State.UNDEFINED
onready var anim_player = get_node("AnimationPlayer")

func _ready():
	set_state(State.UNDEFINED)

func set_state(state : int, letter : String = ''):
	current_state = state
	match state : 
		State.UNDEFINED :
			$Label.hide()
			self_modulate = Color("#1f1f1f")
		State.FOUND :
			$Label.show()
			$Label.text = letter
			self_modulate = Color("#80cd61")
		State.NOT_IN_WORD :
			$Label.show()
			$Label.text = letter
			self_modulate = Color("#2f2f2f")
		State.IN_WORD :
			$Label.show()
			$Label.text = letter
			self_modulate = Color("#ffa300")
		State.NOT_TESTED : 
			$Label.show()
			$Label.text = letter
			self_modulate = Color("#1f1f1f")

func shake():
	anim_player.connect("animation_finished", self, "on_finished")
	anim_player.play("Shake")

func on_finished():
	print("Animation finished")
