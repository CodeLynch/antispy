extends CanvasLayer

@export var is_spy_near = false
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var fine_sprite = preload("res://Assets/spy_track1.png")
@export var sus_sprite = preload("res://Assets/spy_track2.png")

signal spy_near(is_near:bool)

func _ready() -> void:
	$"../Player".connect("spy_near", be_suspicious)
	
func _process(delta: float) -> void:
	if is_spy_near:
		sprite_2d.texture = sus_sprite
	else:
		sprite_2d.texture = fine_sprite
		

func be_suspicious(is_near:bool) -> void:
	if is_near:
		is_spy_near = true
	else:
		is_spy_near = false
