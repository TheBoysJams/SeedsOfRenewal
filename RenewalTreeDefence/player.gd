extends Camera3D

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@export var gridmap: GridMap

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var mouse_pos : Vector2 = get_viewport().get_mouse_position()
	ray_cast_3d.target_position = project_local_ray_normal(mouse_pos) * 100
	ray_cast_3d.force_raycast_update()
	if ray_cast_3d.is_colliding():
		var collider = ray_cast_3d.get_collider()
		if collider is GridMap:
			var collision_point = ray_cast_3d.get_collision_point()
			var cell = gridmap.local_to_map(collision_point)
			if gridmap.get_cell_item(cell) == 2: #2 is the dead/brown cell
				Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
				if Input.is_action_just_pressed("left_click"):
					gridmap.set_cell_item(cell,1) #1 is the living/green cell
					#var tile_pos = gridmap.map_to_local(cell)
					#call our tree manager and build the tree
			else:
				Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
