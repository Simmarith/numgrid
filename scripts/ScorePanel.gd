extends MarginContainer

const SCORE_VALUE = preload("res://scenes/ScoreValue.tscn")
const HEADER = preload("res://scenes/ScoreHeader.tscn")

onready var text_space = get_node("Background/ScrollContainer/MarginContainer/VBoxContainer")

func add_value(title : String, value : String):
	var node = SCORE_VALUE.instance()
	node.set_text(title, value)
	text_space.add_child(node)

func recalculate():
	for text in text_space.get_children():
		text.queue_free()
	text_space.add_child(HEADER.instance())
	if Score.cleared_rows != 0:
		add_value("Rows Cleared %:", "%d%%" % ((Score.cleared_rows as float / Score.total_rows as float) * 100))
		add_value("Total Rows Cleared:", Score.cleared_rows as String)
	if Score.cleared_numbers != 0:
		add_value("Numbers Cleared %:", "%d%%" % ((Score.cleared_numbers as float / Score.total_numbers as float) * 100))
		add_value("Total Numbers Cleared:", Score.cleared_numbers as String)
	var elapsed = OS.get_unix_time() - Score.time_started
	var hours = elapsed / 3600
	var minutes = elapsed / 60
	var seconds = elapsed % 60
	add_value("Time Played:", "%02d : %02d : %02d" % [hours, minutes, seconds])
	pass
