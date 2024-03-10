extends Node3D
class_name TowerManager

@export var towers: Array[TowerInfo] = []

func _ready() -> void:
	#Building the starting tree with code and not just adding nodes to the map
	var player = get_parent() as Player
	var startingCell = player.GetCellAtPosition(Vector3(-1.956554, 0.15, 10.19691))
	player.ToggleCell(startingCell)
	BuildTower(0,player.GetCellLocalPosition(startingCell))
	
func BuildTower(towerIndex:int, pos:Vector3) -> void:
	var newTower = towers[towerIndex].Scene.instantiate()
	print(newTower)
	add_child(newTower)
	newTower.global_position = pos
	newTower.rotation_degrees = Vector3( 0, randi_range(0,360), 0 )

func GetTowerCost(towerIndex:int) -> int:
	return towers[towerIndex].Cost
	
	
