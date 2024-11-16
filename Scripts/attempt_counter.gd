extends CanvasLayer

signal npc_died(is_spy:bool)

func _ready() -> void:
	$"../npc_spawner".connect("npc_died", reduce_attempt)

func reduce_attempt(is_spy:bool) -> void:
	if not is_spy:
		$Attempts.on_attempt_failed()
