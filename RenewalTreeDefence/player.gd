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
							SetCellState(cell,TileType.Living)
						else:
							print("No towers in the towermanager")
			else:
				Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func GetCellAtPosition(pos:Vector3) -> Vector3i:
	return gridmap.local_to_map(pos)
	
func GetCellLocalPosition(pos:Vector3i) -> Vector3:
	return gridmap.map_to_local(pos)

func SetCellState(cell:Vector3i,state:TileType) -> void:
	gridmap.set_cell_item(cell,state) 
