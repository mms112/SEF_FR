///////////////////////////////////////////////////////////////////////////////
// StungGoal.uc - StungGoal class
// this goal that causes an AI to react to being stung by the sting grenade

class StungGoal extends StunnedGoal;
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
//
// Variables

var(parameters) Actor StingGrenade;
var(parameters) bool isMelee;

///////////////////////////////////////////////////////////////////////////////
//
// Constructor

overloaded function construct(AI_Resource r, Actor inGrenade, vector inStunningDeviceLocation, float inStunnedDuration , optional bool isMeleeParam )
{
	super.construct(r, inStunningDeviceLocation, inStunnedDuration);

	StingGrenade = inGrenade;
	
	isMelee = isMeleeParam;
}

///////////////////////////////////////////////////////////////////////////////
defaultproperties
{
    goalName = "Stung"
}