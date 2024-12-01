extends CanvasLayer

func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		get_tree().change_scene_to_file("res://scenes/mission_select.tscn")
