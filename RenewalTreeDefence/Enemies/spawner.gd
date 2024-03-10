extends Node3D

@onready var enemiesContainer = get_tree().get_first_node_in_group("enemies")

func Spawn(enemy:PackedScene) -> void:
	var newEnemy = enemy.instantiate()
	enemiesContainer.add_child(newEnemy)
	newEnemy.global_position = global_position
	newEnemy.direction = ($Destination.global_position - global_position).normalized()
