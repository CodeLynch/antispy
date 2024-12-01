extends CanvasLayer

func _input(event):
	if event.is_action_pressed("mouse_click"):
		get_tree().change_scene_to_file("res://Scenes/mission_select.tscn")
		
		
