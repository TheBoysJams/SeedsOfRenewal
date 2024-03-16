extends Node3D
class_name TowerManager

@export var towers: Array[TowerInfo] = []
@export var player:Player
	
func BuildTower(towerIndex:int, pos:Vector3) -> void:
	var newTower = towers[towerIndex].Scene.instantiate()
	add_child(newTower)
	newTower.global_position = pos
	
