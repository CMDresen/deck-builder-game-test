extends Card

func apply_effects(targets: Array[Node]) -> void:
	var damage_effect := DamageEffect.new() #remember that DamageEffect is a "RefCounted", so I think we can call it in from anywhere?
	damage_effect.amount = 6
	damage_effect.sound = sound
	damage_effect.execute(targets)
