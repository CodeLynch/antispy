extends Node2D

@export var npc_count = 5
@export var spy_count = 1
@export var x_limit = 0 
@export var y_limit = 0
@export var npcs:Array[PackedScene] = []

var ANXIOUS_PROB = .3
var SUS_PROB = .3

var npcs_pos:Array[Vector2i] = []
var rng = RandomNumberGenerator.new() 
var npc_list
var spy_list:Array[String] = []
var active_spy_cnt: int = 0

signal npc_clicked(id:int, name:String, role_int: int, role_tex: String, is_spy:bool)
signal npc_died(is_spy:bool)
signal update_spy_count(new_count:int)
signal spy_cleared()
signal close_overlay(id:int)
signal mark_npc(id:int)

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
			npc_ins.set_params(i + 1, npc_name, get_role_no(npc_ins.name), true, true, true)
			spy_list.append(npc_name + "," + transform_role(npc_ins.name))
			spy_spawned += 1
		else:
			npc_ins = npc_scene.instantiate()
			npc_ins.set_params(i + 1, npc_name, get_role_no(npc_ins.name), rand_bool(ANXIOUS_PROB), rand_bool(SUS_PROB), false)
		npc_ins.name = npc_ins.name + "[" + str(i) + "]"
		npc_ins.npc_clicked.connect(show_overlay)
		npc_ins.npc_died.connect(was_npc_spy)
		npc_ins.position = Vector2i(rng.randi_range(-x_limit, x_limit),rng.randi_range(-y_limit, y_limit))
		add_child(npc_ins)
		npc_ins.add_to_group("npcs")
	npc_list = get_tree().get_nodes_in_group("npcs")
	active_spy_cnt = spy_count

func _ready() -> void:
	spawn_random()
	$"../InterrogateOverlay".kill_npc.connect(kill_npc)
	$"../InterrogateOverlay".close_overlay.connect(stop_talk)
	$"../InterrogateOverlay".mark_npc.connect(toggle_mark)

func generate_hint() -> String:
	var hint:String = ""
	var count = 0
	if spy_list.size() > 1:
		hint = "There are spies pretending to be the following roles: "
		for spy in spy_list:
			var spy_details = spy.split(",")
			hint = hint + spy_details[1]
			count += 1
			if count < spy_list.size():
				hint = hint + ", "
		
	else:
		hint = "The spy is pretending to be a " + spy_list[0].split(",")[1]
	return hint
	
func show_overlay(id:int, name:String, role_int: int, role_tex: String, is_spy:bool) -> void:
	$"../InterrogateOverlay".start(id, name, role_int, role_tex, is_spy)

func kill_npc(id: int) -> void:
	var tar = npc_list[id]
	tar.die()
	
func stop_talk(id: int) -> void:
	var tar = npc_list[id]
	tar.toggle_talk()

func was_npc_spy(is_spy:bool):
	if is_spy:
		active_spy_cnt -= 1
		update_spy_count.emit(active_spy_cnt)
		if active_spy_cnt <= 0:
			spy_cleared.emit()
	npc_died.emit(is_spy)

func rand_bool(chance:float) -> bool:
	if rng.randf_range(0, 1) <= chance:
		return true
	else:
		return false
	 

func transform_role(role_name:String) -> String:
	if role_name == "field_agent":
		return "Field Agent"
	elif role_name == "analyst":
		return "Analyst"
	elif role_name == "rd_eng":
		return "R&D Engineer"
	elif role_name == "janitor":
		return "Janitor"
	else:
		return "<Invalid Input>"
	
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

func toggle_mark(id:int) -> void:
	var tar = npc_list[id]
	tar.toggle_mark()
	
