extends PathFollow3D

signal CoreReached(int)
signal EnemyDied(int)
var health := 3
var goldValue := 1
var speed := 3
var damage := 1

func _process(delta: float) -> void:
	if health > 0:
		progress += delta * speed
		if progress_ratio == 1.0:
			CoreReached.emit(damage)
			queue_free()

func TakeDamage(damagedDone:int) -> void:
	health -= damagedDone
	if health == 0:
		EnemyDied.emit(goldValue)
		$Giant2/AnimationPlayer.play("Death")
