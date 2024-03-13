extends PathFollow3D

signal CoreReached(int)

var speed := 30
var damage := 1

func _process(delta: float) -> void:
	progress += delta * speed
	if progress_ratio == 1.0:
		CoreReached.emit(damage)
		queue_free()
