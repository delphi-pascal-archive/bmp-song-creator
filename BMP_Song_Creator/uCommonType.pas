unit uCommonType;

interface

type
  THeaderSong = record
    ID : array[0..3] of byte; // sert à reconnaitre 1 Bitmap 32bits normal                            // d'un BMP_SONG
    InstrumentDefault : byte;//instrument à jouer
    DelayDefault : byte ; // en millisecondes , durée delay avant note par defaut; max 255 ms
    DurationDefault : byte; // en millisecondes , durée note par defaut max; 255 ms
    OctaveDefault : byte; // de 1 à 10 octaves ...
  end;
  pTSong = ^Tsong;
  
  TSong = record
    Header : THeaderSong;
    TabNote : array of byte;//tableaux de notes ...
  end;

  TypeBmp = (bmpNormal,bmpSong);
  
  TypeErreurEng = (bmpNonValide , bmpTooSmall,OK);
 

const
  FIN_SONG = 255;
  //27 01 1988 , hé ma date d'annif ...
  // PS : ma carte son vient de griller alors que j'ai recu 1 système 5.1
  // petite idée cadeau vite fait :) lol
  ID1 = 27;
  ID2 = 01;
  ID3 = 19;
  ID4 = 88;
  // pr s'aider à creer les bonnes valeurs de byte (pas de jeu de mots svp ;))
  DNOTE = 0;
  FNOTE = 11;

  DOCTAVE=12;
  FOCTAVE=22;

  DDUREE=23;
  FDUREE=42;

  DDELAY = 43;
  FDELAY=63;

  DINSTRUMENT=64;
  FINSTRUMENT=237;
  
  LASTINSTRUMENT=174;
var

(* Repris directos de l'exemple , vais pas m'amuser à taper tt ca ! *)

  Instruments:array [0..LASTINSTRUMENT] of String=(
'AcousticGrandPiano','BrightAcousticPiano','ElectricGrandPiano',
'HonkyTonkPiano','ElectricPiano1','ElectricPiano2','Harpsichord','Clavinet',
'Celesta','Glockenspiel','MusicBox','Vibraphone','Marimba','Xylophone',
'TubularBells','Dulcimer',
'DrawbarOrgan','PercussiveOrgan','RockOrgan','ChurchOrgan',
'ReedOrgan','Accordion','Harmonica','TangoAccordion',
'AcousticNylonGuitar','AcousticSteelGuitar','JazzElectricGuitar',
'CleanElectricGuitar','MutedElectricGuitar','OverdrivenGuitar',
'DistortionGuitar','GuitarHarmonics','AcousticBass',
'FingeredElectricBass','PickedElectricBass','FretlessBass',
'SlapBass1','SlapBass2','SynthBass1','SynthBass2',
'Violin','Viola','Cello','Contrabass',
'TremoloStrings','PizzicatoStrings','OrchestralHarp','Timpani',
'StringEnsemble1','StringEnsemble2','SynthStrings1',
'SynthStrings2','ChoirAahs','VoiceOohs','SynthVoice','OrchestraHit',
'Trumpet','Trombone','Tuba','MutedTrumpet','FrenchHorn',
'BrassSection','SynthBrass1','SynthBrass2',
'SopranoSax','AltoSax','TenorSax','BaritoneSax',
'Oboe','EnglishHorn','Bassoon','Clarinet',
'Piccolo','Flute','Recorder','PanFlute','BlownBottle',
'Shakuhachi','Whistle','Ocarina',
'SquareLead','SawtoothLead','CalliopeLead','ChiffLead',
'CharangLead','VoiceLead','FifthsLead','BassandLead',
'NewAgePad','WarmPad','PolySynthPad','ChoirPad',
'BowedPad','MetallicPad','HaloPad','SweepPad',
'SynthFXRain','SynthFXSoundtrack','SynthFXCrystal','SynthFXAtmosphere',
'SynthFXBrightness','SynthFXGoblins','SynthFXEchoes','SynthFXSciFi',
'Sitar','Banjo','Shamisen','Koto','Kalimba',
'Bagpipe','Fiddle','Shanai',
'TinkleBell','Agogo','SteelDrums','Woodblock',
'TaikoDrum','MelodicTom','SynthDrum','ReverseCymbal',
'GuitarFretNoise','BreathNoise','Seashore','BirdTweet',
'TelephoneRing','Helicopter','Applause','Gunshot',
//percussion
'AcousticBassDrum','BassDrum1','SideStick','AcousticSnare',
'HandClap','ElectricSnare','LowFloorTom','ClosedHiHat',
'HighFloorTom','PedalHiHat','LowTom','OpenHiHat',
'LowMidTom','HiMidTom','CrashCymbal1','HighTom',
'RideCymbal1','ChineseCymbal','RideBell','Tambourine',
'SplashCymbal','Cowbell','CrashCymbal2','Vibraslap',
'RideCymbal2','HiBongo','LowBongo','MuteHiConga',
'OpenHiConga','LowConga','HighTimbale','LowTimbale',
'HighAgogo','LowAgogo','Cabasa','Maracas',
'ShortWhistle','LongWhistle','ShortGuiro','LongGuiro',
'Claves','HiWoodBlock','LowWoodBlock','MuteCuica',
'OpenCuica','MuteTriangle','OpenTriangle');

//notes
TabNotes:array[0..11] of string=('C','C#','D','D#','E','F','F#','G','G#','A','A#','B');


implementation

end.
 