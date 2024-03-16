extends Path3D

@onready var core_damaged_sfx: AudioStreamPlayer = $CoreDamagedSFX
@onready var enemy_killed_sfx: AudioStreamPlayer = $EnemyKilledSFX


func Spawn(enemy:PackedScene, hpScale:float) -> void:
	var newEnemy = enemy.instantiate()
	newEnemy.health *= hpScale
	newEnemy.connect("CoreReached", DamageCore)
	newEnemy.connect("EnemyDied", EnemyKilled)
	add_child(newEnemy)
	
func DamageCore(damage:int)-> void:
	if core_damaged_sfx:
		core_damaged_sfx.play()
	get_parent().get_parent().player.health -= damage

func EnemyKilled(goldValue:int) -> void:
	if enemy_killed_sfx:
		enemy_killed_sfx.play()
	get_parent().get_parent().player.gold += goldValue
