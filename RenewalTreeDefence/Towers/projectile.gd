extends Area3D
var damage:int
var direction := Vector3.FORWARD
@export var speed := 40.0

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_area_entered(area: Area3D) -> void:
	area.get_parent().TakeDamage(damage)
	queue_free()

func _on_timer_timeout() -> void:
	queue_free()
