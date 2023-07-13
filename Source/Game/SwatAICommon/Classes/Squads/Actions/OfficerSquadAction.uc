///////////////////////////////////////////////////////////////////////////////
// OfficerSquadAction.uc - OfficerSquadAction class
// this goal is the base class for all Swat Officer Squad actions

class OfficerSquadAction extends Tyrion.AI_SquadAction;
///////////////////////////////////////////////////////////////////////////////

import enum EquipmentSlot from Engine.HandheldEquipment;
import enum Pocket from Engine.HandheldEquipment;

///////////////////////////////////////////////////////////////////////////////
//
// Variables

// copied from our goal
var(parameters) Pawn	CommandGiver;	// who gave us this goal
var(parameters) vector	CommandOrigin;	// where the command giver was when the goal was created
var(parameters) bool	bHasBeenCopied;	// whether we're a copy of another goal

///////////////////////////////////////////////////////////////////////////////
//
// Death

function pawnDied( Pawn pawn )
{
	super.pawnDied(pawn);

	if (squad().pawns.length == 0)
	{
		// nobody is alive.  we have to fail.
		instantFail(ACT_ALL_RESOURCES_DIED);
	}
	else
	{
		NotifyPawnDied(pawn);
	}
}

// subclasses should override and call down the chain
protected function NotifyPawnDied(Pawn pawn);

///////////////////////////////////////////////////////////////////////////////
//
// Officer Accessors

function Pawn GetClosestOfficerWithEquipmentTo(EquipmentSlot Slot, vector Point, optional bool bUsePathfindingDistance , optional bool rejectShield)
{
	assert(squad().IsA('OfficerTeamInfo'));

	return OfficerTeamInfo(squad()).GetClosestOfficerWithEquipmentTo(Slot, Point, bUsePathfindingDistance , rejectShield );
}

function bool DoesAnOfficerHaveUsableEquipment(EquipmentSlot Slot, optional Name EquipmentClassName)
{
	assert(squad().IsA('OfficerTeamInfo'));

	return OfficerTeamInfo(squad()).DoesAnOfficerHaveUsableEquipment(Slot, EquipmentClassName);
}

function bool DoAllOfficersHave(Name EquipmentClassName)
{
	assert(squad().IsA('OfficerTeamInfo'));

	return OfficerTeamInfo(squad()).DoAllOfficersHave(EquipmentClassName);
}

function bool DoesAnOfficerHave(Name EquipmentClassName)
{
	assert(squad().IsA('OfficerTeamInfo'));

	return OfficerTeamInfo(squad()).DoesAnOfficerHave(EquipmentClassName);
}

function Pawn GetFirstShieldOfficer()
{
	assert(squad().IsA('OfficerTeamInfo'));

	return OfficerTeamInfo(squad()).GetFirstShieldOfficer();
}

function Pawn GetFirstOfficer()
{
	assert(squad().IsA('OfficerTeamInfo'));

	return OfficerTeamInfo(squad()).GetFirstOfficer();
}

function Pawn GetSecondOfficer()
{
	assert(squad().IsA('OfficerTeamInfo'));

	return OfficerTeamInfo(squad()).GetSecondOfficer();
}

function Pawn GetClosestOfficerTo(Actor Target, optional bool bRequiresLineOfSight, optional bool bUsePathfindingDistance)
{
	assert(squad().IsA('OfficerTeamInfo'));

	return OfficerTeamInfo(squad()).GetClosestOfficerTo(Target, bRequiresLineOfSight, bUsePathfindingDistance);
}

function bool AllSquadInFormation(Pawn Leader)
{
	assert(squad().IsA('OfficerTeamInfo'));

	return OfficerTeamInfo(squad()).AllSquadInFormation(Leader);
}

function Pawn GetClosestOfficerWithEquipment(vector Location, EquipmentSlot Slot, optional Name EquipmentClassName, optional bool bUsePathfindingDistance, optional bool rejectShield)
{
	assert(squad().IsA('OfficerTeamInfo'));

	return OfficerTeamInfo(squad()).GetClosestOfficerWithEquipment(Location, Slot, EquipmentClassName, bUsePathfindingDistance, rejectShield);
}

///////////////////////////////////////////////////////////////////////////////
//
// wait for zulu command to be issued
// (ignores Zulu if TargetDoor is locked)

latent function WaitForZulu(optional Door TargetDoor)
{
	if (GetFirstOfficer().logTyrion && OfficerSquadGoal(achievingGoal).bHoldCommand)
		log(Name @ "WAITING for Zulu");

	if (TargetDoor != None && (TargetDoor.IsLocked() || TargetDoor.IsWedged()))
	{
		// LOG("WaitForZulu: Abort! Door locked or wedged!");
		squad().Level.GetLocalPlayerController().ClearHeldCommand(squad());
		squad().Level.GetLocalPlayerController().ClearHeldCommandCaptions(squad());
		OfficerTeamInfo(squad()).ClearHeldFlag();
		OfficerSquadGoal(achievingGoal).bHoldCommand = false;
	}

	while (OfficerSquadGoal(achievingGoal).bHoldCommand)
	{
		yield();
	}
}
