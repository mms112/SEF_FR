///////////////////////////////////////////////////////////////////////////////
// SquadBreachLeaderThrowAndClearAction.uc - SquadBreachLeaderThrowAndClearAction class
// this action is used to organize the Officer's breach, bang, & clear behavior

class SquadBreachLeaderThrowAndClearAction extends SquadBreachThrowGrenadeAndClearAction;
///////////////////////////////////////////////////////////////////////////////

import enum EquipmentSlot from Engine.HandheldEquipment;

var bool grenadeThrown;

///////////////////////////
// Since the thrower is not an AI-controlled officer, we don't need to worry about Formation

protected function bool ShouldThrowerBeFirstOfficer()
{
	return false;
}

protected latent function MoveUpThrower()
{
  return;
}

protected function SetThrower()
{
  Thrower = CommandGiver;
}

function Pawn GetThrowingOfficer(EquipmentSlot ThrownItemSlot)
{
  return CommandGiver;
}

///////////////////////////
//

protected latent function WaitForGrenadeToBeThrown()
{
	while(!grenadeThrown) {
		yield();
	}
	
	sleep(PostGrenadeThrowDelayTime);
}

protected latent function PrepareToMoveThroughOpenDoorway()
{
}

protected latent function PreTargetDoorOpened()
{
}

protected latent function PostTargetDoorOpened()
{
	WaitForGrenadeToBeThrown();
}

protected latent function PostTargetDoorBreached()
{
	WaitForGrenadeToBeThrown();
}

function GrenadeGotDetonated(Pawn PawnThrower, EquipmentSlot ThrownItemSlot) {
	if(PawnThrower == Thrower) {
		PostGrenadeThrowDelayTime = 0;
			
		if (ThrownItemSlot == EquipmentSlot.Slot_CSGasGrenade) {
			if(DoAllOfficersHave('gasMask') || DoAllOfficersHave('helmetGasMask') )
			{
				PostGrenadeThrowDelayTime = CSGrenadeDelayTimeGasMask;
			}
			else if(DoAllOfficersHave('RiotHelmet'))
			{
				PostGrenadeThrowDelayTime = CSGrenadeDelayTimeRiotHelmet;
			}
			else
			{
				PostGrenadeThrowDelayTime = CSGrenadeDelayTime;
			}
		}
		
		if (ThrownItemSlot == EquipmentSlot.Slot_Flashbang)
		{
			if( !DoAllOfficersHave('HelmetAndGoggles') )
			{
				if ( ISwatOfficer(Thrower).Hasa('NinebangGrenade') )//the thrower has Ninebangs
				{
					PostGrenadeThrowDelayTime=NinebangDelayTime;
				}
				else
				{
					PostGrenadeThrowDelayTime=FlashbangDelayTime;
				}
			}
		}
		grenadeThrown = true;
	}
}

///////////////////////////////////////////////////////////////////////////////
defaultproperties
{
	satisfiesGoal = class'SquadBreachLeaderThrowAndClearGoal'
}
