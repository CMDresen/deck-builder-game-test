extends Card

func apply_effects(targets: Array[Node]) -> void:
	var block_effect := BlockEffect.new()
	block_effect.amount = 5
	block_effect.sound = sound
	block_effect.execute(targets) 
	#"targets" is determined by the Card master class. The resource specifies that this specific block
	#...card targets "self". The card refers to its resource for the targeting mode, and the resource
	#...refers back to this specific script. This is why all cards in the game use both a resource AND script.
