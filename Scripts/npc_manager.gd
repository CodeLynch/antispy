extends Node2D

@export var npc_count = 5
@export var spy_count = 1
@export var x_limit = 0 
@export var y_limit = 0
@export var npcs:Array[PackedScene] = []
var npcs_pos:Array[Vector2i] = []
var rng = RandomNumberGenerator.new() 
var npc_list
signal npc_clicked(id:int, name:String, role_int: int, role_tex: String, is_spy:bool)

func spawn_random():
	var spy_spawned = 0;
	for i in range(0, npc_count):
		var npc_scene = npcs.pick_random()
		var npc_name = "" 
		var npc_ins = npc_scene.instantiate()
		if npc_ins.name == "analyst":
			npc_name = $RandomNames.get_random_name(1)
		else:
			npc_name = $RandomNames.get_random_name(0)
		if  spy_spawned < spy_count:
			npc_ins.set_params(i + 1, npc_name, get_role_no(npc_ins.name), false, true)
			spy_spawned += 1
		else:
			npc_ins = npc_scene.instantiate()
			npc_ins.set_params(i + 1, npc_name, get_role_no(npc_ins.name), false, false)
		npc_ins.npc_clicked.connect(show_overlay)
		npc_ins.position = Vector2i(rng.randi_range(-x_limit, x_limit),rng.randi_range(-y_limit, y_limit))
		add_child(npc_ins)
		npc_ins.add_to_group("npcs")
	npc_list = get_tree().get_nodes_in_group("npcs")

func _ready() -> void:
	spawn_random()
	$"../InterrogateOverlay".kill_npc.connect(kill_npc)

func show_overlay(id:int, name:String, role_int: int, role_tex: String, is_spy:bool) -> void:
	$"../InterrogateOverlay".start(id, name, role_int, role_tex, is_spy)

func kill_npc(id: int) -> void:
	var tar = npc_list[id]
	tar.die()

func get_role_no(role_name: String) -> int:
	if role_name == "field_agent":
		return 0
	elif role_name == "analyst":
		return 1
	elif role_name == "rd_eng":
		return 2
	elif role_name == "janitor":
		return 3
	else:
		return -1
