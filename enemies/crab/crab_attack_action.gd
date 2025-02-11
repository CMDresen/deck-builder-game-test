extends EnemyAction

@export var damage := 7

func perform_action() -> void:
	if not enemy or not target: #"enemy" and "target" are members of the parent class
		return
	
	var tween := create_tween().set_trans(Tween.TRANS_QUINT)
	var start := enemy.global_position
	var end := target.global_position + Vector2.RIGHT * 32
	var damage_effect := DamageEffect.new()
	var target_array: Array[Node] = [target]
	damage_effect.amount = damage
	damage_effect.sound = sound
	
	#Play first part of movement "animation"...
	tween.tween_property(enemy, "global_position", end, 0.4)
	#...trigger the damage effect...
	tween.tween_callback(damage_effect.execute.bind(target_array))
	tween.tween_interval(0.25)
	#...and finish the "animation" by moving back to original position.
	tween.tween_property(enemy, "global_position", start, 0.4)
	
	#Then tell the game "I'm done attacking!"
	tween.finished.connect(
		func():
			Events.enemy_action_completed.emit(enemy)
	)
