extends Node3D

@export var player:Player
@onready var spawners = $Spawners.get_children()
@export var enemy:PackedScene
var hpScale:= 1.0


func _on_spawn_timer_timeout() -> void:
	if spawners.size() == 0: pass
	$SpawnTimer.wait_time = max($SpawnTimer.wait_time - 0.05,0.25)
	if $SpawnTimer.wait_time == 0.25:
		hpScale += 0.1
	var randomSpawner = spawners[randi_range(0,spawners.size() -1)]
	randomSpawner.Spawn(enemy,hpScale)
