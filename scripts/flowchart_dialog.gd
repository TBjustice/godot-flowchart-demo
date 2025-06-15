extends FlowchartItem

func _init() -> void:
	title_clicked.connect(toggle_detail)

func toggle_detail() -> void:
	$VBoxContainer/Detail.visible = not $VBoxContainer/Detail.visible
