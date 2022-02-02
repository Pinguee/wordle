extends Control

var word : String
var wordlist : PoolStringArray
var dictionary : PoolStringArray
var buffer : String

onready var rows := $Rows.get_children()
onready var win_scene := preload("res://Scenes/End.tscn")


func _ready():
	wordlist = load_file_lines("res://Resources/wordlist.txt")
	dictionary = load_file_lines("res://Resources/dictionary.txt")
	
	randomize()
	word = (wordlist[randi() % wordlist.size()] as String).to_upper()
	print_debug(word)


func _input(event : InputEvent):
	if event is InputEventKey and event.is_pressed():
		match event.scancode:
			KEY_BACKSPACE:
				buffer.erase(buffer.length()-1, 1)
				rows[0].update_row(buffer)
			KEY_ENTER:
				if buffer.length() == 5:
					enter_word()
			_:
				var c : int = ord(char(event.scancode).to_upper())
				if c in range(ord('A'), ord('Z') + 1) and buffer.length() < 5:
					buffer = buffer + char(c)
				rows[0].update_row(buffer)


func enter_word() -> void:
	if not buffer.to_upper() in dictionary:
		for square in rows[0].get_children():
			square.shake()
		return
	
	buffer = buffer.to_upper()
	word = word.to_upper()
	
	var chars := []
	var matches := [0,0,0,0,0]
	for c in word:
		chars.append(c)
	for i in range(5):
		if word[i].to_lower() == buffer[i].to_lower():
			matches[i] = 2
			chars.erase(buffer[i].to_lower())
	for i in range(5):
		if buffer[i].to_lower() in a and b[i] == 0:
			b[i] = 1
			a.erase(buffer[i].to_lower())
	(rows[0] as Row).validate_row(matches, buffer)
	rows.pop_front()
	if buffer.to_lower() == word.to_lower():
		var root = get_tree().root
		var main = root.get_node("Main")
		root.remove_child(main)
		main.call_deferred("free")
		var win_instance = win_scene.instance()
		win_instance.win(true)
		root.add_child(win_instance)
	elif rows.size() == 0:
		var root = get_tree().root
		var main = root.get_node("Main")
		root.remove_child(main)
		main.call_deferred("free")
		var win_instance = win_scene.instance()
		win_instance.win(false)
		root.add_child(win_instance)
	buffer = ""

func load_file_lines(path : String) -> PoolStringArray:
	var f : File = File.new()
	assert(f.open(path, File.READ) == OK, "Error opening %s" % path )
	var lines_array := f.get_as_text().split('\n', false)
	f.close()
	return lines_array




