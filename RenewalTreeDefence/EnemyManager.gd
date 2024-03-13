extends Node3D

@export var player:Player

@onready var spawners = $Spawners.get_children()

@export var enemy:PackedScene


func _on_spawn_timer_timeout() -> void:
	$SpawnTimer.wait_time = max($SpawnTimer.wait_time - 0.05,0.01) 
	if spawners.size() == 0: pass
	var randomSpawner = spawners[randi_range(0,spawners.size() -1)]
	randomSpawner.Spawn(enemy)
