extends Node3D

@onready var spawners = $Spawners.get_children()

@export var enemy:PackedScene


func _on_spawn_timer_timeout() -> void:
	$SpawnTimer.wait_time = max($SpawnTimer.wait_time - 0.05,0.01) 
	if spawners.size() == 0: pass
	var randomSpawner = spawners[randi_range(0,spawners.size() -1)]
	randomSpawner.Spawn(enemy)


func _on_kill_volume_area_entered(area: Area3D) -> void:
	area.queue_free()
