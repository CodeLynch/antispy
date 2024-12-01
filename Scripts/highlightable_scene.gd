extends Area2D
signal npc_clicked(id: int, name:String, role_int: int, role_tex: String, is_spy:bool)

@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var npc_char: NPCChar = $"../NPCChar"
var is_highlighted: bool = false

func _mouse_enter() -> void:
	if npc_char.near_player:
		animated_sprite_2d.material.set_shader_parameter("is_active", true)
		is_highlighted = true
	
func _mouse_exit() -> void:
	if npc_char.near_player:
		animated_sprite_2d.material.set_shader_parameter("is_active", false)
		is_highlighted = false

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and (!npc_char.is_talking and !npc_char.is_dead):
		npc_clicked.emit($"../NPCChar".npc_id, $"../NPCChar".NPC_name, $"../NPCChar".role_no, $"../NPCChar".portrait_texture, $"../NPCChar".is_spy)
		
func _process(delta: float) -> void:
	if(!npc_char.near_player):
		animated_sprite_2d.material.set_shader_parameter("is_active", false)
		is_highlighted = false	
