extends PathFollow3D

signal CoreReached(int)
signal EnemyDied(int)
var health := 3
var goldValue := 1
var speed := 3
var damage := 1

func _process(delta: float) -> void:
	progress += delta * speed
	if progress_ratio == 1.0:
		CoreReached.emit(damage)
		queue_free()

func TakeDamage(damage:int) -> void:
	health -= damage
	if health == 0:
		EnemyDied.emit(goldValue)
		queue_free()
