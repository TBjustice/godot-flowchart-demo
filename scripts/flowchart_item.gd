class_name FlowchartItem
extends Node2D
signal title_clicked
signal position_changed
@export_node_path("Control") var titlebar_path

var _titlebar : Node
var _title_clicked := false
var _dragging := false
var last_mouse_position := Vector2()

func _ready() -> void:
	if not titlebar_path:
		return
	_titlebar = get_node(titlebar_path)
	if _titlebar and _titlebar is Control:
		_titlebar.gui_input.connect(_titlebar_gui_input)
		_titlebar.mouse_filter = Control.MOUSE_FILTER_STOP

func _titlebar_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				_title_clicked = true
				_dragging = false
				last_mouse_position = get_global_mouse_position()
			else:
				if not _dragging:
					title_clicked.emit()
				_title_clicked = false
	if event is InputEventMouseMotion:
		if _title_clicked:
			_dragging = true
			var new_position = get_global_mouse_position()
			position += (new_position - last_mouse_position)
			last_mouse_position = new_position
			position_changed.emit()
			
	
