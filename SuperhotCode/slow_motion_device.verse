using { /Verse.org/Simulation }
using { /Fortnite.com }
using { /Fortnite.com/Devices }
using { /Fortnite.com/Playspaces }
using { /Fortnite.com/Characters }
using { /UnrealEngine.com/Temporary/SpatialMath }

slow_motion_device := class(creative_device):
  @editable
  SlowMotionSequence : cinematic_sequence_device = cinematic_sequence_device{} # has a sequence with property "time dialation" lowered from 1 to a smaller number.
  
  @editable
  TickSpeed : float = 1.0/10.0 # one second / times per second. Times per second = frequency
  
  @editable
  Tolerance : float = 1.0 # distance you can move before slow motion turns off
  
  OnBegin<override>()<suspends>:void=
    # Method creative_object_interface has.
    # Gives a reference to the "playspace" (game area) that players are in.
    Playspace: fort_playspace = GetPlayspace()
    
    # Get a list of player objects
    # player class is from Simulation
    Players : []player = Playspace.GetPlayers()
      
    # Accessing an array is a failable expression.
    # GetFortplayer is a faliable expression.
    if( layer : player = Players[0],
        FortCharacter : fort_character = Player.GetFortCharacter[]):
        
        # Get the transform (class that holds position information) of the player.
        var Transform : transform = FortCharacter.GetTransform()
        
        # Record the position of the player.
        var LastPosition : vector3 = Transform.Translation
        
        # Loops the following code endlessly
        loop:
          # Pause execution for TickSpeed amount of seconds.
          Sleep(TickSpeed)
          
          # Update Transform object.
          set Transform = FortCharacter.GetTransform()
          NewPosition : vector3 = Transform.Translation
