extends RichTextLabel

const DISABLED_COLOR = Color(.2,.2,.2)
const ENABLED_COLOR = Color(.9,.9,.9)
const FOCUSED_COLOR = Color(.7,.7,.9)

var col : int
var row : int
var value : int
var disabled = false
var focused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if (self.connect("gui_input", self, "_on_click")):
		print_debug("couldn't register click event")
	pass # Replace with function body.


func _on_click(i : InputEvent):
	if (i is InputEventMouseButton) && (i.button_index == 1) && (i.is_pressed()):
		if !disabled:
			focused = !focused
			if focused:
				self.get_parent().get_parent().register_focus(row, col)
			else:
				self.get_parent().get_parent().register_unfocus(row, col)
	rewrite_text()
	pass
	
func rewrite_text():
	self.bbcode_text = ""
	self.push_align(RichTextLabel.ALIGN_CENTER)
	if disabled:
		self.push_color(DISABLED_COLOR)
	else:
		if focused:
			self.push_color(FOCUSED_COLOR)
		else:
			self.push_color(ENABLED_COLOR)
	self.add_text(String(value))
	self.pop()
	pass
