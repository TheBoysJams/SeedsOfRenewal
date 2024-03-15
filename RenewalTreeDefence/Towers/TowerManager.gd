extends Node3D
class_name TowerManager

@export var towers: Array[TowerInfo] = []
@export var player:Player
	
func BuildTower(towerIndex:int, pos:Vector3) -> void:
	RemoveTowerAtPosition(pos)
	var newTower = towers[towerIndex].Scene.instantiate()
	add_child(newTower)
	newTower.global_position = pos
	#newTower.rotation_degrees = Vector3( 0, randi_range(0,360), 0 )
	
func GetTowersAtPosition(pos:Vector3) -> Array[Node]:
	var currentTowers = get_children()
	return currentTowers.filter(func(node): return node.global_position.is_equal_approx(pos))

func RemoveTowerAtPosition(pos:Vector3) -> void:
	var foundTowersAtPos = GetTowersAtPosition(pos)
	for t in foundTowersAtPos:
		t.queue_free()
