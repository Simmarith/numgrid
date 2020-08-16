extends HBoxContainer

func set_text(title: String, value : String):
	var title_node = get_child(0)
	title_node.bbcode_text = ""
	title_node.push_bold()
	title_node.add_text(title)
	title_node.pop()
	
	var value_node = get_child(1)
	value_node.bbcode_text = ""
	value_node.push_align(RichTextLabel.ALIGN_RIGHT)
	value_node.add_text(value)
	value_node.pop()
