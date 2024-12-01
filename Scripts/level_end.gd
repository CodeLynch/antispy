extends CanvasLayer
var popped_up:bool = false
func _ready() -> void:
	$LevelDoneBox.visible = false
	
func pop_up(is_win:bool, score:int, attempts_left: int, time_left:int, hint_used: bool) -> void:
	if !popped_up:
		if is_win:
			popped_up = true
			$LevelDoneBox/header.text = "[center]MISSION COMPLETE[/center]"
			$LevelDoneBox/body.text = "[center]Good job, Agent![/center]"
			$LevelDoneBox/score.text = "SCORE: " + str(score)
			$LevelDoneBox/t_left.text = "TIME LEFT: " + str(time_left) + " * 1000 = " + str(time_left * 1000)
			$LevelDoneBox/a_left.text = "ATTEMPTS SPARED: " + str(attempts_left) + " * 5000 = " + str(attempts_left * 5000)
			if hint_used:
				$LevelDoneBox/h_bonus.text = "HINT BONUS: 0"
			else:
				$LevelDoneBox/h_bonus.text = "HINT BONUS: 10000"
			$LevelDoneBox.visible = true
		else:
			popped_up = true
			$LevelDoneBox/header.text = "[center]MISSION FAILED[/center]"
			$LevelDoneBox/body.text = "[center]We'll get 'em next time...[/center]"
			$LevelDoneBox/score.text = "SCORE: " + str(score)
			$LevelDoneBox/t_left.text = ""
			$LevelDoneBox/a_left.text = ""
			$LevelDoneBox/h_bonus.text = ""
			$LevelDoneBox.visible = true
	
func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _on_level_select_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/mission_select.tscn")
