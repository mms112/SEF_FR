class Procedure_PreventEvidenceDestroyed extends SwatGame.Procedure
    implements  IInterested_GameEvent_EvidenceDestroyed;
	
	
var config int PenaltyPerInfraction;

var int numInfractions;
	
function PostInitHook()
{
    Super.PostInitHook();

    //register for notifications that interest me
    GetGame().GameEvents.EvidenceDestroyed.Register(self);
	TriggerPenaltyMessage(None);
}

//interface IInterested_GameEvent_EvidenceDestroyed implementation
function OnEvidenceDestroyed(IEvidence What)
{
    numInfractions++;
	TriggerPenaltyMessage(None);
}

function string Status()
{
    return string(numInfractions);
}

//interface IProcedure implementation
function int GetCurrentValue()
{
    return PenaltyPerInfraction * numInfractions;
}