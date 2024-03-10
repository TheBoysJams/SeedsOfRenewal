extends Node3D

@onready var spawners = $Spawners.get_children()

@export var enemy:PackedScene



func _on_spawn_timer_timeout() -> void:
	if spawners.size() == 0: pass
	var randomSpawner = spawners[randi_range(0,spawners.size() -1)]
	randomSpawner.Spawn(enemy)
