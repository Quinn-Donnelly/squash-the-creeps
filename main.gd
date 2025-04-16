extends Node

@export var mob_scene: PackedScene


func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	
	$MobSpawnPath/MobSpawnLocation.progress_ratio = randf()
	
	var spawnLocation = $MobSpawnPath/MobSpawnLocation.position
	var playerLocation = $player.position
	
	mob.initalize(spawnLocation, playerLocation)
	add_child(mob)


func _on_player_hit() -> void:
	$MobTimer.stop()
	print("get shit on")
