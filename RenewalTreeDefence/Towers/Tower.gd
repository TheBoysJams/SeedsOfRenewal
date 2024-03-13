extends StaticBody3D
class_name Tower

#@export var deathScene:PackedScene

signal EnemyKilled

var health := 10
var cost := 5

func TakeDamage(damage:int) -> void:
	health -= damage
	if(health <= 0):
		var towerManager = get_parent() as TowerManager
		var player = towerManager.get_parent() as Player
		player.SetCellState(player.GetCellAtPosition(global_position),player.TileType.Dirt)
		#if deathScene:
			#var remains = deathScene.instantiate()
			#towerManager.add_child(remains)
			#remains.global_position = global_position
			#remains.rotation_degrees = rotation_degrees
		queue_free()


func _on_area_3d_area_entered(area: Area3D) -> void:
	TakeDamage(area.get_parent().damage)
	EnemyKilled.emit()
	area.get_parent().queue_free()
