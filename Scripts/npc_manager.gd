extends Node2D
@export var npc_count = 5
@export var x_limit = 0 
@export var y_limit = 0
@export var npcs:Array[PackedScene] = []
var npcs_pos:Array[Vector2i] = []
var rng = RandomNumberGenerator.new() 
func spawn_random():
	for i in range(0, npc_count):
		var npc_scene = npcs.pick_random()
		var npc_ins = npc_scene.instantiate()
		var npc_pos = Vector2i(rng.randi_range(-x_limit, x_limit),rng.randi_range(-y_limit, y_limit))
		while npc_pos in npcs_pos:
			npc_pos = Vector2i(rng.randi_range(-x_limit, x_limit),rng.randi_range(-y_limit, y_limit))
		npc_ins.position = Vector2i(rng.randi_range(-x_limit, x_limit),rng.randi_range(-y_limit, y_limit))
		add_child(npc_ins)
	
func _ready() -> void:
	spawn_random()
