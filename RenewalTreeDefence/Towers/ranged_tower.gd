class_name RangedTower extends Tower

var turretRange:= 10.0
var target: PathFollow3D
@export var projectile: PackedScene
@export var turret:Node3D
@onready var spawners = get_tree().get_first_node_in_group("spawners").get_children()

func _ready() -> void:
	super()
	$Tree_22.rotation_degrees = Vector3( 0, randi_range(0,360), 0 )

func Attack() ->void:
	if target && projectile:
		var shot = projectile.instantiate()
		shot.damage = damage
		add_child(shot)
		shot.global_position = turret.global_position
		shot.direction = turret.global_transform.basis.z
		$Chicken2/AnimationPlayer.play("Attack")

func _physics_process(delta: float) -> void:
	target = GetClosestTarget()
	if target && turret:
		turret.look_at(target.global_position,Vector3.UP,true)

func GetClosestTarget() -> PathFollow3D:
	var closestTarget = null
	var closestTargetDist = turretRange
	for spawner in spawners:
		for enemy in spawner.get_children():
			if enemy is PathFollow3D && enemy.health > 0:
				var dist := global_position.distance_to(enemy.global_position)
				if dist < closestTargetDist:
					closestTarget = enemy
					closestTargetDist = dist
	return closestTarget
