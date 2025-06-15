class_name FlowchartNode
extends Area2D
var has_mouse: set=set_has_mouse

func _init() -> void:
	mouse_entered.connect(set_has_mouse.bind(true))
	mouse_exited.connect(set_has_mouse.bind(false))

func set_has_mouse(value: bool) -> void:
	has_mouse = value
