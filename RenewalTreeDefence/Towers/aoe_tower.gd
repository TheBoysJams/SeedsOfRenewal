class_name AOETower extends Tower

@onready var aoe_area: Area3D = $AOEArea

func _ready() -> void:
	#this just gives it a bit of randomness, might also do a tiny bit of scaling and maybe even the color
	$Mushroom2.rotation_degrees = Vector3( 0, randi_range(0,360), 0 )
	$Mushroom3.rotation_degrees = Vector3( 0, randi_range(0,360), 0 )

func Attack() ->void:
	var hitEnemies = aoe_area.get_overlapping_areas()
	for enemy in hitEnemies:
		enemy.get_parent().TakeDamage(damage)

