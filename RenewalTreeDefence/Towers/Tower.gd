extends StaticBody3D
class_name Tower

@export var deathScene:PackedScene

var health := 10
var cost := 5

func TakeDamage(damage:int) -> void:
	health -= damage
	if(health <= 0):
		var towerManager = get_parent() as TowerManager
		var player = towerManager.get_parent() as Player
		player.ToggleCell(player.GetCellAtPosition(global_position))
		if deathScene:
			var remains = deathScene.instantiate()
			towerManager.add_child(remains)
			remains.global_position = global_position
			remains.rotation_degrees = rotation_degrees
		queue_free()
