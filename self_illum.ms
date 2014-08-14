/*  
	Andrew McWhae 2014
	
	Converts current selection to blueprints
	- puts objects on layer called "_Blueprints" by default (this is editable)
	- sets renderable to False
	- sets frozen in gray to False
	- if material is applied, sets self-illunimation to True
*/

macroScript SetBP category:"Drew" tooltip:"Useful for setting blueprints"
(
fn SetAsBP layername renderable showgray layerfrozen sil =
(
	if (selection.count > 0) then
	(
		layerBP = layermanager.newLayerFromName layername
		SI = False
		
		for obj in (selection as array) do
		(
			layerBP.addNode obj
			obj.renderable = renderable
			obj.showFrozenInGray = showgray
			
			if (obj.material != undefined) then
			(
				obj.material.selfIllumAmount = sil
				SI = True
			)
		)
		
		if (SI == False) then messageBox "No maps to apply self illumination to." title:"No maps found"

		clearSelection()
		layerBP.isfrozen = layerfrozen
	)
	else messageBox "No objects are selected" title:"Nothing selected"
)

rollout blueprints "Set blueprints"	
(
	-- ui elements
	label info1 "Select objects to set as blueprints"
	group "Options"
	(
	checkbox renderable "Renderable" checked:False
	checkbox grayfrozen "Show frozen in gray" checked:False
	checkbox freezelayer "Freeze layer" checked:True
	spinner selfillum "Self illumination: " range:[0,100,100] type:#integer
	)
	edittext layerName "Layer name: " text:"_Blueprints"
	Button setBP "Set"
	
	-- event handlers
	on setBP pressed do
		SetAsBP layerName.text renderable.checked grayfrozen.checked freezelayer.checked selfillum.value
)

createDialog blueprints width:200
)

macros.run "Drew" "SetBP"