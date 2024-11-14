extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var interrogate_overlay: CanvasLayer = $InterrogateOverlay

func _process(delta: float) -> void:
	if interrogate_overlay.is_active:
		player.can_move = false
	else:
		player.can_move = true
