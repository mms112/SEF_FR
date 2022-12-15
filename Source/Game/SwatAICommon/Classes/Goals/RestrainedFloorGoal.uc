///////////////////////////////////////////////////////////////////////////////
// RestrainedFloorGoal.uc - CowerGoal class

class RestrainedFloorGoal extends SwatCharacterGoal;
///////////////////////////////////////////////////////////////////////////////
// copied to our action
var(parameters)	Pawn	Restrainer;	// pawn that we will be working with

///////////////////////////////////////////////////////////////////////////////
//
// Constructor

overloaded function construct( AI_Resource r, Pawn inRestrainer)
{
	super.construct( r );

	assert(inRestrainer != None);
	Restrainer = inRestrainer;
}

///////////////////////////////////////////////////////////////////////////////
defaultproperties
{
    priority   = 98
    goalName   = "RestrainedFloorGoal"
	bPermanent = true
}