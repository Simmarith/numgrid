extends Control

const HELP_PANEL = preload("res://scenes/HelpPanel.tscn")

var help_panel = HELP_PANEL.instance()

func _on_Help_toggled(button_pressed):
	print_debug(button_pressed)
	if button_pressed:
		self.add_child(help_panel)
	else:
		self.remove_child(help_panel)
	pass
