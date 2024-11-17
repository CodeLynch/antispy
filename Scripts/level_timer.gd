extends Node2D

@export var time: float = 0
var mins: int = 0
var secs: int = 0

signal timer_done()

func _process(delta: float) -> void:
	time -= delta
	secs = fmod(time, 60)
	mins = fmod(time, 3600) / 60
	$lbl_min.text = "%02d:" % mins
	$lbl_sec.text = "%02d" % secs
	if time <= 0:
		stop_timer()


func stop_timer() -> void:
	set_process(false)
	timer_done.emit()
