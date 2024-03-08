extends Camera3D

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@export var gridmap: GridMap
@export var towerManager: TowerManager

var selectedTowerIndex:int = 0
var currentGold = 20

enum TileType{
	Living = 1,
	Dead = 2 #2 is the dead/brown cell
}

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
			if gridmap.get_cell_item(cell) == TileType.Dead: 
				Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
				if Input.is_action_just_pressed("left_click"):
					var towerCost = towerManager.GetTowerCost(selectedTowerIndex)
					if towerCost <= currentGold:
						var tile_pos = gridmap.map_to_local(cell)
						towerManager.BuildTower(selectedTowerIndex,tile_pos)
						currentGold -= towerCost
						toggleCell(cell)
			else:
				Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func toggleCell(cell:Vector3i) -> void:
	gridmap.set_cell_item(cell,wrapi(gridmap.get_cell_item(cell) + 1, 1,3)) #using 3 here because wrapi's 3rd arg is not inclusive (this will be 1 or 2)
