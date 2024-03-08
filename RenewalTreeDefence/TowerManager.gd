extends Node3D

@export var towers: Array[PackedScene] = []

func BuildTower(towerIndex:int, pos:Vector3) -> void:
	var newTower = towers[towerIndex].instantiate()
	print(newTower)
	add_child(newTower)
	newTower.global_position = pos

func GetTowerCost(towerIndex:int) -> int:
	return 1
