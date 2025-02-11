class_name EnemyHandler
extends Node2D

func _ready() -> void:
	Events.enemy_action_completed.connect(_on_enemy_action_completed)


func reset_enemy_actions() -> void:
	var enemy: Enemy
	for child in get_children():
		enemy = child as Enemy
		enemy.current_action = null
		enemy.update_action()


func start_turn() -> void:
	if get_child_count() == 0:
		return
	
	#we don't want to loop through all the children and do_turn() in one big loop.
	#if we did it that way, the enemies would all take their turns at the same time!
	var first_enemy: Enemy = get_child(0) as Enemy
	first_enemy.do_turn()


func _on_enemy_action_completed(enemy: Enemy) -> void:
	#check if the enemy that just finished their turn is the last enemy.
	#if so, return.
	if enemy.get_index() == get_child_count() - 1:
		Events.enemy_turn_ended.emit()
		return
	
	#if not, make the next enemy start their turn.
	var next_enemy: Enemy = get_child(enemy.get_index() + 1) as Enemy
	next_enemy.do_turn()
