extends Node2D
class_name NPCChar


@export var is_spy: bool :
	get :  return is_spy
	set(value) : is_spy = value
@export var NPC_name: String : 
	get :  return NPC_name
	set(value) : NPC_name = value
@export var is_anxious: bool :
	get :  return is_anxious
	set(value) : is_anxious = value
@export var heart_rate: int :
	get :  return heart_rate
	set(value) : heart_rate = value
@export var pos: Vector2i :
	get :  return pos
	set(value) : pos = value

func _init(NPC_NAME, IS_ANXIOUS, HEART_RATE, IS_SPY) -> void:
	pos = global_position
	NPC_name = NPC_NAME
	is_anxious = IS_ANXIOUS
	heart_rate = HEART_RATE
	is_spy = IS_SPY
