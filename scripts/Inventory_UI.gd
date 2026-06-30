extends CanvasLayer

signal inventory_item_ui_selected(item_type: Item.ItemType)

const INVENTORY_ITEM_UI = preload("res://Scenes/InventarioUI.tscn")
@onready var container: HBoxContainer=$PanelContainer/HBoxContainer

func add_item(type: Item.ItemType, texture: CompressedTexture2D, quantity: int):
	var node_name= "inventory_item"+str(type)
	print("agregado")
	if not container.has_node(node_name):
		var inventory_item=INVENTORY_ITEM_UI.instantiate()
		inventory_item.name=node_name
		container.add_child(inventory_item)
		inventory_item.connect("inventory_item_used", _on_inventory_item_used)
		inventory_item.initialize(type,texture,quantity)
	else:
		var existing_node=container.get_node(node_name)
		existing_node.set_quantity(quantity)
		
func _on_inventory_item_used(item_type:Item.ItemType):
	inventory_item_ui_selected.emit(item_type)
	
func _on_inventory_item_added(item: Item, quantity : int):
	add_item(item.type, item.get_texture(), quantity)
	
func _ready() -> void:
	Inventory.item_added.connect(_on_inventory_item_added)
	
	load_existing_inventory()

func load_existing_inventory() -> void:
	for item_type in Inventory.get_items().keys():
		var data = Inventory.get_items()[item_type]
		add_item(item_type, data["texture"], data["quantity"])
