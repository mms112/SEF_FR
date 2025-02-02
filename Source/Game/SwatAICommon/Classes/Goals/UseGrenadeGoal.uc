///////////////////////////////////////////////////////////////////////////////
// UseGrenadeGoal.uc - UseGrenadeGoal class
// this goal causes the AI to throw a grenade at a particular target.

class UseGrenadeGoal extends SwatWeaponGoal;
///////////////////////////////////////////////////////////////////////////////

import enum EquipmentSlot from Engine.HandheldEquipment;

///////////////////////////////////////////////////////////////////////////////
//
// UseGrenadeGoal variables

// copied to our action
var(parameters) vector							vTargetLocation;
var(parameters) vector							InitialPosition;
var(parameters) EquipmentSlot					GrenadeSlot;
var(parameters) bool							bWaitToThrowGrenade;
var(parameters) bool							bInitialPosOverridden;
var(parameters) IInterestedGrenadeThrowing		ThrowClient;

///////////////////////////////////////////////////////////////////////////////
//
// UseGrenadeGoal constructors

// don't use this constructor!
overloaded function construct( AI_Resource r ) { assert(false); }

// use this constructor
overloaded function construct( AI_Resource r, EquipmentSlot inGrenadeSlot, vector inTargetLocation, optional bool bInitialPos, optional vector inInitialPosition)
{
	super.construct(r, priority);

	vTargetLocation = inTargetLocation;
	GrenadeSlot     = inGrenadeSlot;
	bInitialPosOverridden = bInitialPos;
	InitialPosition = inInitialPosition;
}

///////////////////////////////////////////////////////////////////////////////
//
// Clients

function RegisterForGrenadeThrowing(IInterestedGrenadeThrowing inThrowClient)
{
	ThrowClient = inThrowClient;
}

///////////////////////////////////////////////////////////////////////////////
//
// Manipulators

function SetWaitToThrowGrenade(bool inWaitToThrowGrenade)
{
	bWaitToThrowGrenade = inWaitToThrowGrenade;
}

///////////////////////////////////////////////////////////////////////////////
//
// Throwing

function NotifyThrowGrenade()
{
	assert(bWaitToThrowGrenade == true);

//	log(Name $ " NotifyThrowGrenade - achievingAction: " $ achievingAction $ " isIdle(): " $ achievingAction.isIdle());
	if (achievingAction != None)
	{
		// if we're idle, run the action
		// otherwise we should let the action know it should continue (by not calling pause)
		if (achievingAction.isIdle())
		{
			achievingAction.runAction();
		}
		else
		{
			UseGrenadeAction(achievingAction).SetContinueToThrowGrenade();
		}
	}
}

function EquipmentSlot GetGrenadeSlot()
{
	return GrenadeSlot;
}

///////////////////////////////////////////////////////////////////////////////
defaultproperties
{
	priority = 80
	goalName = "UseGrenade"
}
