extends Control

var word : String
var dictionary : PoolStringArray
var dictionary_full : PoolStringArray
var buffer : String
onready var rows := $Rows.get_children()
onready var win_scene := preload("res://Scenes/End.tscn")

func enter_word():
	if not buffer.to_upper() in dictionary_full:
		for square in rows[0].get_children():
			square.shake()
		return
	var a := []
	var b := [0,0,0,0,0]
	for c in word:
		a.append(c)
	for i in range(5):
		if word[i].to_lower() == buffer[i].to_lower():
			b[i] = 2
			a.erase(buffer[i].to_lower())
	for i in range(5):
		if buffer[i].to_lower() in a and b[i] == 0:
			b[i] = 1
			a.erase(buffer[i].to_lower())
	rows[0].test_row(b, buffer)
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

func load_dic(path : String) -> PoolStringArray:
	var f : File = File.new()
	f.open(path, File.READ)
	return f.get_as_text().split('\n', false)

func _input(event : InputEvent):
	if event is InputEventKey and event.is_pressed():
		if event.scancode == KEY_BACKSPACE:
			buffer.erase(buffer.length()-1, 1)
			rows[0].update_row(buffer)
		elif event.scancode == KEY_ENTER and buffer.length() == 5:
			enter_word()
		else:
			var c = ord(char(event.scancode).to_upper())
			if c in range(ord('A'), ord('Z') + 1) and buffer.length() < 5:
				buffer = buffer + char(c)
			rows[0].update_row(buffer)

func _ready():
	randomize()
	dictionary = load_dic("res://dico_trie.txt")
	dictionary_full = load_dic("res://dico5.txt")
	word = dictionary[randi() % dictionary.size()]
	print(word)
