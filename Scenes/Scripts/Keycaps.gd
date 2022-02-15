extends Button
class_name Keycaps

func set_letter(letter_set : String):
	self.text = letter_set

func get_letter():
	return self.text
