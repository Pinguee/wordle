extends HBoxContainer

onready var columns := get_children()

func update_row(buffer : String):
	for e in columns:
		e.set_state(Square.State.UNDEFINED)
	for i in range(buffer.length()):
		columns[i].set_state(Square.State.NOT_TESTED, buffer[i])

func test_row(test_array : Array, buffer : String):
	for i in range(columns.size()):
		match test_array[i] :
			0 :
				columns[i].set_state(Square.State.NOT_IN_WORD, buffer[i])
			1 :
				columns[i].set_state(Square.State.IN_WORD, buffer[i])
			2 :
				columns[i].set_state(Square.State.FOUND, buffer[i])

func _ready():
	pass
