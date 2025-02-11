extends Node

func play(audio: AudioStream, single=false) -> void:
	if not audio:
		return
	
	if single: #for sounds that need to play by themselves
		stop()
	
	for player in get_children(): #"player" as in "Sound player"
		player = player as AudioStreamPlayer
		
		if not player.playing:
			player.stream = audio
			player.play()
			break

func stop() -> void:
	for player in get_children():
		player = player as AudioStreamPlayer
		player.stop()
