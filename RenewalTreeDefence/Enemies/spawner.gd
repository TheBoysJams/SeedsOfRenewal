extends Path3D

func Spawn(enemy:PackedScene) -> void:
	var newEnemy = enemy.instantiate()
	add_child(newEnemy)
