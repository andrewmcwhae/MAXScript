macroScript EPBridge category:"Drews Tools" buttonText:"EPBridge" tooltip:"Bridge no Dialog"
(
	co = classof(modpanel.getCurrentObject())
	if co == Editable_Poly and subObjectLevel == 2 do $.EditablePoly.Bridge()
	if co == Edit_Poly and subObjectLevel == 2 do $.modifiers[#Edit_Poly].ButtonOp #BridgeEdge
)