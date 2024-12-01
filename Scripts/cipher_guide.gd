extends CanvasLayer

@export var pages:Array[Control] 
var current_page = 0

signal guide_over()

func _ready() -> void:
	var count: int = 0
	for i in range(0, pages.size()):
		if i == 0:
			pages[i].visible = true
		else:
			pages[i].visible = false
			
func next_page() -> void:
	if current_page + 1 < pages.size():
		pages[current_page].visible = false
		current_page += 1
		pages[current_page].visible = true
	else:
		self.visible = false
		guide_over.emit()
