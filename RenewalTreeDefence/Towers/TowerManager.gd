extends Node3D
class_name TowerManager

@export var towers: Array[TowerInfo] = []
@onready var player = get_parent() as Player

func _ready() -> void:
	#Building the starting tree with code and not just adding nodes to the map
	var startingCell = player.GetCellAtPosition(Vector3(-1.956554, 0.15, 10.19691))
	player.ToggleCell(startingCell)
	BuildTower(0,player.GetCellLocalPosition(startingCell))
	
func BuildTower(towerIndex:int, pos:Vector3) -> void:
	RemoveTowerAtPosition(pos)
	var newTower = towers[towerIndex].Scene.instantiate()
	add_child(newTower)
	newTower.global_position = pos
	newTower.rotation_degrees = Vector3( 0, randi_range(0,360), 0 )
	newTower.connect("EnemyKilled", func():player.gold += 2)

func GetTowerCost(towerIndex:int) -> int:
	return towers[towerIndex].Cost
	
func RemoveTowerAtPosition(pos:Vector3) -> void:
	var currentTowers = get_children()
	var foundTowersAtPos = currentTowers.filter(func(node): return node.global_position.is_equal_approx(pos))
	if foundTowersAtPos.size() == 1:
		foundTowersAtPos[0].queue_free()
