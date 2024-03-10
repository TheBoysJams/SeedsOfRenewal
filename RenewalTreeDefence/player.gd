extends Camera3D
class_name Player

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@export var gridmap: GridMap
@export var towerManager: TowerManager
@export var startingGold = 20

var selectedTowerIndex:int = 0

var gold: int:
	set(gold_in):
		gold = max(gold_in,0)
		$UI/Gold.text = "Gold: " + str(gold)
enum TileType{
	Living = 1,
	Dead = 2 #2 is the dead/brown cell
}

func _ready() -> void:
	gold = startingGold

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	ray_cast_3d.collision_mask = 1
	var mouse_pos : Vector2 = get_viewport().get_mouse_position()
	ray_cast_3d.target_position = project_local_ray_normal(mouse_pos) * 100
	ray_cast_3d.force_raycast_update()
	if ray_cast_3d.is_colliding():
		var collider = ray_cast_3d.get_collider()
		if collider is GridMap:
			var collision_point = ray_cast_3d.get_collision_point()
			var cell = GetCellAtPosition(collision_point)
			if gridmap.get_cell_item(cell) == TileType.Dead: 
				Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
				if Input.is_action_just_pressed("left_click"):
					if towerManager.towers.size() > 0:
						var towerCost = towerManager.GetTowerCost(selectedTowerIndex)
						if gold >= towerCost:
							towerManager.BuildTower(selectedTowerIndex,GetCellLocalPosition(cell))
							gold -= towerCost
							ToggleCell(cell)
						else:
							print("No towers in the towermanager")
			else:
				Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	#below is temp code to test doing damge (right right click for debugging purpose)
	ray_cast_3d.collision_mask = 2
	ray_cast_3d.force_raycast_update()
	if ray_cast_3d.is_colliding():
		var collider = ray_cast_3d.get_collider()
		if collider is Tower:
			if Input.is_action_just_pressed("right_click"):
				print(collider)
				collider.TakeDamage(5)
	

func GetCellAtPosition(pos:Vector3) -> Vector3i:
	return gridmap.local_to_map(pos)
	
func GetCellLocalPosition(pos:Vector3i) -> Vector3:
	return gridmap.map_to_local(pos)

func ToggleCell(cell:Vector3i) -> void:
	gridmap.set_cell_item(cell,wrapi(gridmap.get_cell_item(cell) + 1, 1,3)) #using 3 here because wrapi's 3rd arg is not inclusive (this will be 1 or 2)
