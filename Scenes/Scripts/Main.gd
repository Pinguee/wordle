extends Node

var word : String
var wordlist : PoolStringArray
var dictionary : PoolStringArray
var buffer : String

var playing : bool = true

onready var rows : Array
onready var win_scene := preload("res://Scenes/End.tscn")

func _ready():
	set_process_input(false)
	$End/Background/VBoxContainer/Button.connect("pressed", self, "new_game")
	$Begin/All/Button.connect("pressed", self, "new_game")
	wordlist = load_file_lines("res://Resources/wordlist.txt")
	dictionary = load_file_lines("res://Resources/dictionary.txt")
	$Begin.show()

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
	
	# Setup
	buffer = buffer.to_upper()
	word = word.to_upper()
	
	var chars := []
	for c in word:
		chars.append(c)
	
	var matches := []
	for _i in range(len(word)):
		matches.append(Square.NOT_IN_WORD)
	
	# Perfect matches
	for i in range(len(word)):
		if word[i] == buffer[i]:
			matches[i] = Square.FOUND
			chars.erase(buffer[i])
	
	if len(rows) > 1:
		# Partial matches
		for i in range(len(word)):
			if buffer[i] in chars and matches[i] == Square.NOT_IN_WORD:
				matches[i] = Square.IN_WORD
				chars.erase(buffer[i])
		rows.pop_front().validate_row(matches, buffer)
	else:
		# Last word, wrong letters
		for i in range(len(word)):
			if buffer[i] != word[i]:
				matches[i] = Square.WRONG_LETTER
		rows.pop_front().validate_row(matches, word)
	
	
	# Win / Lose conditions
	if buffer == word or rows.size() == 0:
		$End.win(buffer == word)
	
	buffer = ""

func load_file_lines(path : String) -> PoolStringArray:
	var f : File = File.new()
	if f.open(path, File.READ != OK):
		printerr("Could not open %s" % path)
	var lines_array := f.get_as_text().split('\n', false)
	f.close()
	return lines_array

func new_game() -> void:
	$Begin.hide()
	$End.hide()

	set_process_input(true)
	randomize()
	if wordlist.size():
		word = (wordlist[randi() % wordlist.size()] as String).to_upper()
	buffer = ""
	rows = $Rows.get_children()
	
	for r in rows:
		(r as Row).reset_row()
	
	print_debug(word)
