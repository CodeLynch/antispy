extends Node2D
class_name progress
static var max_level:int = 1
static var done:bool = false

func _ready() -> void:
	$Button.disabled = false
	if max_level >= 2:
		$Button2.disabled = false
	else:
		$Button2.disabled = true
	if max_level >= 3:
		$Button3.disabled = false
	else:	
		$Button3.disabled = true	
	if done:
		$congrats.visible = true
	else:
		$congrats.visible = false		
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game2.tscn")
	
func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game3.tscn")
	
