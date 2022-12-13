class Procedure_NoOfficersDown extends SwatGame.Procedure
    implements  IInterested_GameEvent_PawnIncapacitated,
                IInterested_GameEvent_PawnDied,
                IInterested_GameEvent_PawnDamaged;

var config int Bonus;

var array<SwatPawn> DownedOfficers;

function PostInitHook()
{
    Super.PostInitHook();

    //register for notifications that interest me
    GetGame().GameEvents.PawnIncapacitated.Register(self);
    GetGame().GameEvents.PawnDied.Register(self);
	GetGame().GameEvents.PawnDamaged.Register(self);
}

//interface IInterested_GameEvent_PawnIncapacitated implementation
function OnPawnIncapacitated(Pawn Pawn, Actor Incapacitator, bool WasAThreat)
{
    if( !Pawn.IsA('SwatOfficer') )
        return;   //we only care about officers

    GetGame().CheckForCampaignDeath(Pawn);

    AssertNotInArray( Pawn, DownedOfficers, 'DownedOfficers' );
    Add( Pawn, DownedOfficers );
}

//interface IInterested_GameEvent_PawnDied implementation
function OnPawnDied(Pawn Pawn, Actor Killer, bool WasAThreat)
{
    if( !Pawn.IsA('SwatPlayer') )
        return;   //we only care about players

    GetGame().CheckForCampaignDeath(Pawn);

    //AssertNotInArray( Pawn, DownedOfficers, 'DownedOfficers' );
    Add( Pawn, DownedOfficers );
}

function OnPawnDamaged(Pawn Pawn, Actor Damager)
{
	if (Pawn.Level.NetMode != NM_Standalone) return;
    if (!Pawn.IsA('SwatPlayer')) return;

    Add( Pawn, DownedOfficers );
}

//interface IProcedure implementation
function int GetCurrentValue()
{
    local float Modifier;
    local int total;
    local int NumOfficers;

    NumOfficers = GetNumActors( class'SwatPlayer' ) + GetNumActors( class'SwatOfficer' );
    Modifier = float(NumOfficers-DownedOfficers.length)/float(NumOfficers);
    total = int(float(Bonus)*Modifier);

    return total;
}

///////////////////////////////////////

function string Status()
{
    return GetNumActors( class'SwatPlayer' ) + GetNumActors( class'SwatOfficer' ) - DownedOfficers.length
        $"/"$( GetNumActors( class'SwatPlayer' ) + GetNumActors( class'SwatOfficer' ) );
}

///////////////////////////////////////
