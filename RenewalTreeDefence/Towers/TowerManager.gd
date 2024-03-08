extends Node3D
class_name TowerManager

@export var towers: Array[TowerInfo] = []

func BuildTower(towerIndex:int, pos:Vector3) -> void:
	var newTower = towers[towerIndex].Scene.instantiate()
	print(newTower)
	add_child(newTower)
	newTower.global_position = pos

func GetTowerCost(towerIndex:int) -> int:
	return towers[towerIndex].Cost
	
	
