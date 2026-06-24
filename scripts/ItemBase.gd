class_name Item extends Area2D
enum ItemType { HEARTH, SWORD, KEY }

@export var type: ItemType

func collect_item():
	queue_free()

func get_texture() -> CompressedTexture2D:
	return $Sprite2D.texture
