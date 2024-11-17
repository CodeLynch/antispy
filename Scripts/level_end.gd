extends CanvasLayer

func _ready() -> void:
	$LevelDoneBox.visible = false
	
func pop_up(is_win:bool, score:int, attempts_left: int, time_left:int) -> void:
	if is_win:
		$LevelDoneBox/header.text = "[center]MISSION COMPLETE[/center]"
		$LevelDoneBox/body.text = "[center]Good job, Agent![/center]"
		$LevelDoneBox/score.text = "SCORE: " + str(score)
		$LevelDoneBox/t_left.text = "TIME LEFT: " + str(time_left) + " * 1000 = " + str(time_left * 1000)
		$LevelDoneBox/a_left.text = "CIVILIANS SPARED: " + str(attempts_left) + " * 5000 = " + str(attempts_left * 5000)
		$LevelDoneBox.visible = true
	else:
		$LevelDoneBox/header.text = "[center]MISSION FAILED[/center]"
		$LevelDoneBox/body.text = "[center]We'll get 'em next time...[/center]"
		$LevelDoneBox/score.text = "SCORE: " + str(score)
		$LevelDoneBox/t_left.text = ""
		$LevelDoneBox/a_left.text = ""
		$LevelDoneBox.visible = true
	
func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
