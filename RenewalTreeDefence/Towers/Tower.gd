extends StaticBody3D
class_name Tower



var health := 10
var cost := 5

func TakeDamage(damage:int) -> void:
	health -= damage
	if(health <= 0):
		var player = get_parent().get_parent() as Player
		player.ToggleCell(player.GetCellAtPosition(global_position))
		queue_free()
