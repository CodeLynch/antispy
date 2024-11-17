extends CanvasLayer

signal npc_died(is_spy:bool)
signal out_of_attempts()

func _ready() -> void:
	$"../npc_spawner".connect("npc_died", reduce_attempt)
	$Attempts.connect("out_of_attempts", no_attempts)

func reduce_attempt(is_spy:bool) -> void:
	if not is_spy:
		$Attempts.on_attempt_failed()

func no_attempts():
	out_of_attempts.emit()
