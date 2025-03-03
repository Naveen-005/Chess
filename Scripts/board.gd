extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_cell(Vector2i(0,1),0,Vector2i(2,1))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		#print("Mouse Click/Unclick at: ", event.position)
		#print(map_to_local((event.position)))
		print(local_to_map(get_viewport().get_mouse_position()))
		print(map_to_local(get_viewport().get_mouse_position()))
