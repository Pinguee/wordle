extends HBoxContainer
class_name Row

onready var columns := get_children()

func update_row(buffer : String):
	for e in columns:
		e.set_state(Square.State.UNDEFINED)
	for i in range(buffer.length()):
		columns[i].set_state(Square.State.NOT_TESTED, buffer[i])

func validate_row(test_array : Array, buffer : String):
	for i in range(columns.size()):
		match test_array[i] :
			0 :
				columns[i].set_state(Square.NOT_IN_WORD, buffer[i])
			1 :
				columns[i].set_state(Square.IN_WORD, buffer[i])
			2 :
				columns[i].set_state(Square.FOUND, buffer[i])

func _ready():
	pass
