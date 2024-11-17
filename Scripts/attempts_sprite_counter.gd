extends Control

@export var attempts: int = 3

signal out_of_attempts()

func _ready() -> void:
	$TextureRect.size.x = attempts * 16
	
func on_attempt_failed() -> void:
	attempts -= 1
	if attempts <= 0:
		out_of_attempts.emit()
		
	$TextureRect.size.x = attempts * 16
