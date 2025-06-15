extends Node2D

var _connection_list:Dictionary = {}

var _new_connection: FlowchartNode
var _new_connection_is_right:=true
var _test_connection: FlowchartNode

func _init() -> void:
	child_entered_tree.connect(setup_child)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		mouse_event(event)

func setup_child(node:Node) -> void:
	if node is FlowchartItem:
		node.position_changed.connect(queue_redraw)

func find_nearest_flowchart_node(group: String) -> FlowchartNode:
	var min_length := INF
	var min_node:FlowchartNode = null
	var flowchart_nodes := get_tree().get_nodes_in_group(group)
	for element in flowchart_nodes:
		if element is not FlowchartNode:
			continue
		var flowchart_node:FlowchartNode = element
		if not flowchart_node.has_mouse:
			continue
		var mouse_pos := flowchart_node.get_local_mouse_position()
		if mouse_pos.length() < min_length:
			min_length = mouse_pos.length()
			min_node = flowchart_node
	return min_node

func mouse_event(event: InputEventMouse) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				var fnode := find_nearest_flowchart_node("FlowchartNode")
				if fnode:
					if fnode.is_in_group("FlowchartNodeLeft"):
						_new_connection_is_right = false
						_new_connection = fnode
					elif fnode.is_in_group("FlowchartNodeRight"):
						_new_connection_is_right = true
						_new_connection = fnode
			elif _new_connection:
				var query := "FlowchartNodeLeft" if _new_connection_is_right else "FlowchartNodeRight"
				var fnode := find_nearest_flowchart_node(query)
				if fnode:
					if _new_connection_is_right:
						_connection_list[_new_connection] = fnode
					else:
						_connection_list[fnode] = _new_connection
				_new_connection = null
				_test_connection = null
				queue_redraw()
	elif event is InputEventMouseMotion:
		if _new_connection:
			var query := "FlowchartNodeLeft" if _new_connection_is_right else "FlowchartNodeRight"
			var fnode := find_nearest_flowchart_node(query)
			if fnode != _test_connection:
				_test_connection = fnode
		queue_redraw()

func _draw() -> void:
	for right in _connection_list:
		var left = _connection_list[right]
		draw_line(
			left.global_position - global_position,
			right.global_position - global_position,
			Color.BLUE)
	if _new_connection:
		if _test_connection:
			draw_line(
				_new_connection.global_position - global_position,
				_test_connection.global_position - global_position,
				Color.BLUE)
		else:
			draw_line(
				_new_connection.global_position - global_position,
				get_local_mouse_position(),
				Color.DEEP_SKY_BLUE)
