class SwatEnemyConfig extends Core.Object
    config(AI);

var config float						LowSkillAdditionalBaseAimError;
var config float						MediumSkillAdditionalBaseAimError;
var config float						HighSkillAdditionalBaseAimError;

var config float						LowSkillMinTimeToFireFullAuto;
var config float						LowSkillMaxTimeToFireFullAuto;
var config float						MediumSkillMinTimeToFireFullAuto;
var config float						MediumSkillMaxTimeToFireFullAuto;
var config float						HighSkillMinTimeToFireFullAuto;
var config float						HighSkillMaxTimeToFireFullAuto;

var config float						MinDistanceToAffectMoraleOfOtherEnemiesUponDeath;

var config array<name>					ThrowWeaponDownAnimationsHG;
var config array<name>					ThrowWeaponDownAnimationsMG;
var config array<name>					ThrowWeaponDownAnimationsSMG;
var config array<name>					ThrowWeaponDownAnimationsSG;

var config float						LowSkillFullBodyHitChance;
var config float						MediumSkillFullBodyHitChance;
var config float						HighSkillFullBodyHitChance;

//chance enemy doesnt drop all weapons
var config float 			LowSkillNoDropChance;
var config float			MediumSkillNoDropChance;
var config float 			HighSkillNoDropChance;

defaultproperties
{
	LowSkillNoDropChance=0.1
	MediumSkillNoDropChance=0.3
	HighSkillNoDropChance=0.5
}
