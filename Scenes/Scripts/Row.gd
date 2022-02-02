extends HBoxContainer
class_name Row

onready var columns := get_children()

func update_row(buffer : String):
	reset_row()
	for i in range(buffer.length()):
		columns[i].set_state(Square.NOT_TESTED, buffer[i])


func reset_row():
	for e in columns:
		e.set_state(Square.UNDEFINED)


func validate_row(matches : Array, buffer : String):
	for i in range(columns.size()):
		columns[i].set_state(matches[i], buffer[i])
