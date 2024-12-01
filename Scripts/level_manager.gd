extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var interrogate_overlay: CanvasLayer = $InterrogateOverlay

@export var show_guide: bool = false
@export var level_no: int = 1
var score: int = 0
var time_left: int = 0
var attempts_left: int = 0
var hint_used: bool = false

signal timer_done()
signal out_of_attempts()
signal spy_cleared()

func _ready() -> void:
	$LevelTimer/TimerGroup.timer_done.connect(level_failed)
	$npc_spawner.spy_cleared.connect(level_clear)
	$AttemptsCounter.out_of_attempts.connect(level_failed)
	$CipherHint.ask_hint.connect(get_hints_from_manager)
	$GameGuide.visible = false
	if show_guide:
		$GameGuide.connect("guide_over", continue_game)
		$GameGuide.visible = true
		get_tree().paused = true
	
func _process(delta: float) -> void:
	if interrogate_overlay.is_active:
		player.can_move = false
	else:
		player.can_move = true

func level_failed()->void:
	end_level(false)

func level_clear()->void:
	progress.max_level = level_no + 1
	if level_no == 3:
		progress.done = true
	end_level(true)

func end_level(is_win:bool) -> void:
	await get_tree().create_timer(1).timeout
	time_left = $LevelTimer/TimerGroup.time
	attempts_left = $AttemptsCounter/Attempts.attempts
	if is_win:
		if hint_used:
			score = (time_left * 1000) + (attempts_left * 5000)
		else:
			score = (time_left * 1000) + (attempts_left * 5000) + 10000
	else:
		score = 0
	$LevelDoneOverlay.pop_up(is_win, score, attempts_left, time_left, hint_used)
	get_tree().paused = true

func get_hints_from_manager() -> void:
	hint_used = true
	$CipherHint.open_hint($npc_spawner.generate_hint())
	

func _on_control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		$GameGuide.next_page()

func continue_game() -> void:
	get_tree().paused = false
	


func _on_level_select_pressed() -> void:
	pass # Replace with function body.
