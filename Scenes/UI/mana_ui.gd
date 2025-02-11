class_name ManaUI
extends Panel

@export var char_stats: CharacterStats : set = _set_char_stats

@onready var mana_label: Label = $ManaLabel

#TESTIN' CODE
#func _ready() -> void:
	#await get_tree().create_timer(3).timeout #HEY LOOK!!! you can use "await" in conjunction with a specific signal! SO useful!
	#char_stats.mana = 2

func _set_char_stats(value: CharacterStats) -> void:
	char_stats = value
	
	if not char_stats.stats_changed.is_connected(_on_stats_changed):
		char_stats.stats_changed.connect(_on_stats_changed)
		
	#So, again, I think this function gets called when the node is ready somehow? Meaning we need to wait for
	#...the WHOLE node to be ready, before we proceed, setting up our initial stats and such
	if not is_node_ready():
		await ready
		
	_on_stats_changed()
	
	
func _on_stats_changed() -> void:
	mana_label.text = "%s/%s" % [char_stats.mana, char_stats.max_mana]
