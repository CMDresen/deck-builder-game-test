class_name Card
extends Resource

enum Type {ATTACK, SKILL, POWER}
enum Target {SELF, SINGLE_ENEMY, ALL_ENEMIES, EVERYONE}

@export_group("Card Attributes")
@export var id: String
@export var type: Type
@export var target: Target
@export var cost: int

@export_group("Card Visuals")
@export var icon: Texture
@export_multiline var tooltip_text: String
@export var sound: AudioStream

func is_single_targeted() -> bool:
	return target == Target.SINGLE_ENEMY

func _get_targets(targets: Array[Node]) -> Array[Node]:
	if not targets:
		return []
		
	#have to get reference to the scene tree THROUGH the targets, since we can't get access to it through...
	#...resources. Resources are just flat files that exist on the drive, and act the same whether the game...
	#...is running or not.
	var tree := targets[0].get_tree()
	
	#"match" is similar to a switch case
	match target:
		Target.SELF:
			return tree.get_nodes_in_group("player")
		Target.ALL_ENEMIES:
			return tree.get_nodes_in_group("enemies")
		Target.EVERYONE:
			return tree.get_nodes_in_group("player") + tree.get_nodes_in_group("enemies")
		_:
			return []
			

func play(targets: Array[Node], char_stats: CharacterStats) -> void:
	Events.card_played.emit(self) #telling the Event Bus singleton to emit this signal, and passing ITSELF as a reference
	char_stats.mana -= cost
	
	#TO MENTION: "Targets", at certain points in the code base, can sometimes refer to an array of Area2Ds.
	#HOWEVER, that can get changed here, by the _get_targets function.
	#The card can transitions out of its dragging/aiming state with a valid target, it gets PLAYED.
	#If the card's RESOURCE is single-targeted, it will affect the Enemy that triggered its play (since Enemy is an Area2D)
	#Otherwise (the "else" in this if-else statement, the targets are determined by the _get_targets function.
	if is_single_targeted():
		apply_effects(targets)
	else: 
		apply_effects(_get_targets(targets))

#Virtual function. This function's effects will change for EACH SPECIFIC CARD.
func apply_effects(_targets: Array[Node]) -> void:
	pass
