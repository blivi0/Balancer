extends SlotInfo
class_name SlotItem

const DEFAULT_PICKUP_AUDIO := preload("res://assets/audio/sfx/pickups/item_general_pickup_draft_02.wav")
const DEFAULT_DROP_AUDIO := preload("res://assets/audio/sfx/drops/item_general_drop_draft_02.wav")

@export var weight: int
@export var pickup_audio: AudioStream = DEFAULT_PICKUP_AUDIO
@export var drop_audio: AudioStream = DEFAULT_DROP_AUDIO
