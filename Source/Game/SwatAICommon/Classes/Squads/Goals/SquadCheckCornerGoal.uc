///////////////////////////////////////////////////////////////////////////////
// SquadMirrorCornerGoal.uc - SquadMirrorCornerGoal class
// this goal is used to organize the Officer's mirroring a corner

class SquadCheckCornerGoal extends SquadCommandGoal;
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
//
// Variables

// copied to our action
var(parameters) Actor TargetMirrorPoint;


///////////////////////////////////////////////////////////////////////////////
//
// Constructors

// Use this constructor
overloaded function construct( AI_Resource r, Pawn inCommandGiver, vector inCommandOrigin, Actor inTargetMirrorPoint )
{
	super.construct(r, inCommandGiver, inCommandOrigin);
	
	assert(inTargetMirrorPoint != None);
	TargetMirrorPoint = inTargetMirrorPoint;
}

///////////////////////////////////////////////////////////////////////////////
//
// Accessors

function bool IsInteractingWith(Actor TestActor)
{
	return (TargetMirrorPoint == TestActor);
}

///////////////////////////////////////////////////////////////////////////////
defaultproperties
{
	goalName = "SquadCheckCornerGoal"
}