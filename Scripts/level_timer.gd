extends Node2D

@export var time: float = 0
var mins: float = 0
var secs: float = 0

func _process(delta: float) -> void:
	time -= delta
	secs = fmod(time, 60)
	mins = time / 60000 
	$lbl_min.text = "%02d:" % mins
	$lbl_sec.text = "%02d" % secs
	if time <= 0:
		stop_timer()
func stop_timer() -> void:
	set_process(false)
