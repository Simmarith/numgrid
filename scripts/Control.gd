extends Control

const HELP_PANEL = preload("res://scenes/HelpPanel.tscn")
const SCORE_PANEL = preload("res://scenes/ScorePanel.tscn")

var help_panel = HELP_PANEL.instance()
var score_panel = SCORE_PANEL.instance()

func _on_Help_toggled(button_pressed):
	if button_pressed:
		self.add_child(help_panel)
	else:
		self.remove_child(help_panel)
	pass


func _on_Score_toggled(button_pressed):
	if button_pressed:
		self.add_child(score_panel)
		score_panel.recalculate()
	else:
		self.remove_child(score_panel)
	pass
