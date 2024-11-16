extends Control

@export var attempts: int = 3


func _ready() -> void:
	$TextureRect.size.x = attempts * 16
	
func on_attempt_failed() -> void:
	attempts -= 1
	$TextureRect.size.x = attempts * 16
	attempts * 16
