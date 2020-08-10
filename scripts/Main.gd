extends Container

# Number of numbers per line
const WIDTH = 9
const CHAR_WIDTH = 50
const CHAR_HEIGHT = 76
const NUMBER_SCENE = preload("res://scenes/Number.tscn")
const ROW_SCENE = preload("res://scenes/Row.tscn")

# Should hold only instances of Number of WIDTH entries each - useful for quick referencing
var rows = []
# The Actual node that houses the numbers
var row_nodes = []
# Should hold 0-2 arrays with 2 ints each
var focused = []

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
# warning-ignore:unused_variable
	for n in range(12):
		rows.append(generate_row())
	update_rows()
	pass # Replace with function body.

func generate_row():
	var row = []
	var row_node = ROW_SCENE.instance()
	for n in range(WIDTH):
		var number = NUMBER_SCENE.instance()
		number.value = String(randi()%9 + 1)
		number.col = n
		number.rewrite_text()
		row.append(number)
		row_node.add_child(number)
	self.add_child(row_node)
	row_nodes.append(row_node)
	return row
	
func update_rows():
	for n in range(rows.size()):
		for number in rows[n]:
			number.row = n
	pass

func clear_numbers():
	for row in rows:
		for number in row:
			number.get_parent.remove_child(number)
	pass
	
func clear_focused():
	for row in rows:
		for number in row:
			number.focused = false
			number.rewrite_text()
	pass
	
func get_next_enabled(pos : Vector2, step : Vector2):
		var pointer = pos + step
		if pointer.y >= WIDTH:
			return get_next_enabled(Vector2(pointer.x + 1, -1), step)
		if pointer.y < 0:
			return get_next_enabled(Vector2(pointer.x - 1, 9), step)
		if pointer.x >= rows.size():
			return false
		if rows[pointer.x][pointer.y].disabled:
			return get_next_enabled(pointer, step)
		else:
			return pointer
	
func check_connect():
	var up = get_next_enabled(Vector2(focused[0][0], focused[0][1]), Vector2(-1,0))
	if up && (up.x == focused[1][0]) && (up.y == focused[1][1]):
		return true
	var down = get_next_enabled(Vector2(focused[0][0], focused[0][1]), Vector2(1,0))
	if down && (down.x == focused[1][0]) && (down.y == focused[1][1]):
		return true
	var left = get_next_enabled(Vector2(focused[0][0], focused[0][1]), Vector2(0,-1))
	if left && (left.x == focused[1][0]) && (left.y == focused[1][1]):
		return true
	var right = get_next_enabled(Vector2(focused[0][0], focused[0][1]), Vector2(0,1))
	if right && (right.x == focused[1][0]) && (right.y == focused[1][1]):
		return true
	return false
	
func check_match():
	if check_connect():
		var a = rows[focused[0][0]][focused[0][1]].value
		var b = rows[focused[1][0]][focused[1][1]].value
		if (a == b) || (a+b == 10):
			return true 
	return false

func check_delete_row():
	var deletable_rows = []
	for n in range(rows.size()):
		var should_delete = true
		for number in rows[n]:
			if number.disabled == false:
				should_delete = false
		if should_delete:
			deletable_rows.append(n)
			row_nodes[n].queue_free()
	var new_rows = []
	var new_row_nodes = []
	for n in range(rows.size()):
		if deletable_rows.has(n):
			row_nodes[n].queue_free()
		else:
			new_rows.append(rows[n])
			new_row_nodes.append(row_nodes[n])
	rows = new_rows
	row_nodes = new_row_nodes
	update_rows()
	pass

func register_focus(row : int, col: int):
	focused.append([row, col])
	
	if focused.size() == 2:
		if check_match():
			rows[focused[0][0]][focused[0][1]].disabled = true
			rows[focused[1][0]][focused[1][1]].disabled = true
		focused.clear()
		clear_focused()
		check_delete_row()
	pass
	
func register_unfocus(row : int, col: int):
	focused.erase([row, col])
	pass


func _on_AddRows_pressed():
	print_debug("PRESSED!")
# warning-ignore:unused_variable
	for n in range(3):
		rows.append(generate_row())
	update_rows()
	pass
