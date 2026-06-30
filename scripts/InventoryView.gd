class_name InventoryItemUI extends Panel

signal inventory_item_used(item_type: Item.ItemType)

@onready var textureRect: TextureRect = $TextureRect
@onready var label : Label = $Label
@onready var patchRect : NinePatchRect = $NinePatchRect

var item_type : Item.ItemType

func initialize(type: Item.ItemType, texture: CompressedTexture2D, quantity: int):
	item_type = type
	textureRect.texture = texture
	label.text = str(quantity)

func set_quantity(quantity : int):
	label.text = str(quantity)
	
