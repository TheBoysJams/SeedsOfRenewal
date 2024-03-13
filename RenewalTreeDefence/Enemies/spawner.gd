extends Path3D

func Spawn(enemy:PackedScene) -> void:
	var newEnemy = enemy.instantiate()
	newEnemy.connect("CoreReached", DamageCore)
	add_child(newEnemy)
	
func DamageCore(damage:int)-> void:
	get_parent().get_parent().player.health -= damage
