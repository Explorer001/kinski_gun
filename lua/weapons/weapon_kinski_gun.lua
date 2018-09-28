--GMod config stuff

AddCSLuaFile()

SWEP.PrintName = "Kinski Gun"

--Text for equip menu
SWEP.EquipMenuData = {
  type = "Weapon",
  desc = "Weapon of a well known german actor."
};

--Always derive from weapon_tttbase
SWEP.Base = "weapon_tttbase"

--Standard GMod values
SWEP.DrawAmmo              = false
SWEP.Primary.Recoil        = 5.1
SWEP.Primary.Damage        = 100
SWEP.Primary.Delay         = 1
SWEP.Primary.NumShots      = 1
SWEP.Primary.Cone          = 0.01
SWEP.Primary.ClipSize      = 2
SWEP.Primary.ClipMax       = 2
SWEP.Primary.DefaultClip   = 2
SWEP.Primary.Automatic     = false

SWEP.Secondary.ClipSize    = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic   = false
SWEP.Secondary.Ammo        = "none"

SWEP.Category              = "Klaus Kinski"
SWEP.Spawnable             = true

SWEP.HeadshotMultiplier    = 4
SWEP.UseHands              = true
SWEP.ViewModelFlip         = false
SWEP.ViewModelFOV          = 54

SWEP.Icon                  = "kinski/ttt_icon.png"
SWEP.WepSelectIcon         = Material("kinski/ttt_icon.png")

SWEP.Kind                  = WEAPON_PISTOL
SWEP.AmmoEnt               = "fooammo"
SWEP.ViewModel             = Model("models/weapons/cstrike/c_pist_deagle.mdl")
SWEP.WorldModel            = Model("models/weapons/w_pist_deagle.mdl")

SWEP.IronSightsPos         = Vector(-6.361, -3.701, 2.15)
SWEP.IronSightsAng         = Vector(0, 0, 0)

SWEP.HoldType              = "pistol"

SWEP.CanBuy                = {ROLE_TRAITOR}
SWEP.LimitedStock          = false
SWEP.Ammo                  = "pistol"
SWEP.AllowDrop             = true
SWEP.IsSilent              = false
SWEP.NoSights              = false


function SWEP:Initialize()
  self:SetHoldType(self.HoldType)
end

function SWEP:PrimaryAttack()
  
  if !self:CanPrimaryAttack() then return end
  
  --bullet calculations
  if (IsFirstTimePredicted()) then
    self:ShootBullet( self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self.Primary.Cone)
    
    
    self:EmitSound("weapons/kinski/dumme_sau.mp3", 75, 100, 1, CHAN_AUTO)
    
    if SERVER then
      sound.Play("weapons/kinski/dumme_sau.mp3", self:GetPos(), 1)
    end

    self:TakePrimaryAmmo( 1 )
  end

  self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
  self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
end

--start glorious sound
function SWEP:Deploy()
  if (!self.LoopSound) then
    self.LoopSound = CreateSound(self.Owner, Sound("weapons/kinski/kirchenjesus.mp3"))
    if (self.LoopSound) then self.LoopSound:Play() end
    self.LoopSound:ChangeVolume(0.25, 0.1)
  end
end

--stop loop sound
function SWEP:StopSounds()
  if ( self.LoopSound ) then self.LoopSound:Stop() self.LoopSound = nil end
end

function SWEP:OnRemove()
  self:StopSounds()
end

function SWEP:OnDrop()
  self:StopSounds()
end

function SWEP:Holster()
  self:StopSounds()
  return true
end
