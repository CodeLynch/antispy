extends Node2D
@onready var lbl_spy_remain: RichTextLabel = $lbl_spy_remain

signal update_spy_count(new_count:int)

func _ready() -> void:
	var s_count = $"../../npc_spawner".spy_count
	if s_count > 1:
		lbl_spy_remain.text = "[right]"  + str(s_count) +  " Spies Remaining[/right]"
	else:
		lbl_spy_remain.text = "[right]"  + str(s_count) +  " Spy Remaining[/right]"
	$"../../npc_spawner".update_spy_count.connect(set_count)

func set_count(num: int) -> void:
	if num > 1:
		lbl_spy_remain.text = "[right]"  + str(num) +  " Spies Remaining[/right]"
	else:
		lbl_spy_remain.text = "[right]"  + str(num) +  " Spy Remaining[/right]"
