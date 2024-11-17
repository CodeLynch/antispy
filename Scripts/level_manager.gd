extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var interrogate_overlay: CanvasLayer = $InterrogateOverlay

var score: int = 0
var time_left: int = 0
var attempts_left: int = 0

signal timer_done()
signal out_of_attempts()
signal spy_cleared()

func _ready() -> void:
	$LevelTimer/TimerGroup.timer_done.connect(level_failed)
	$npc_spawner.spy_cleared.connect(level_clear)
	$AttemptsCounter.out_of_attempts.connect(level_failed)
	
func _process(delta: float) -> void:
	if interrogate_overlay.is_active:
		player.can_move = false
	else:
		player.can_move = true

func level_failed()->void:
	end_level(false)

func level_clear()->void:
	end_level(true)

func end_level(is_win:bool) -> void:
	time_left = $LevelTimer/TimerGroup.time
	attempts_left = $AttemptsCounter/Attempts.attempts
	if is_win:
		score = (time_left * 1000) + (attempts_left * 50000)
	else:
		score = 0
	$LevelDoneOverlay.pop_up(is_win, score, attempts_left, time_left)
	get_tree().paused = true
