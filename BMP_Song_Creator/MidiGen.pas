unit MidiGen;

interface

uses
  Windows, Messages, SysUtils, Classes,mmsystem,forms;


//*************************************************************
//TMidiGen

const
     //default values
     VolumeDef=100;
     ChorusDef=0;
     ReverbDef=0;
     SustainDef=false;
     PanDef=0;
     PBDef=0;
     PBDelayDef=0;
     PBDurationDef=100;
     DurationDef=50;
     OctaveDef=4;
     NoteDef=0;
     ModulationDef=0;
     InstrumentDef=0;
     ChannelDef=0;
     LoopsDef=1;

type
  TMGPercentage = 0..100;
  //TMGNote= (mg00_C,mg01_Dsharp,mg02_D,mg03_Eb,mg04_E,mg05_F,mg06_Gb,mg07_G,mg08_Ab,mg09_A,mg10_Bb,mg11_B);
  TMGNote= (mgC,mgCsharp,mgD,mgDsharp,mgE,mgF,mgFsharp,mgG,mgGsharp,mgA,mgAsharp,mgB);
  TMGChannel=(mgCh01,mgCh02,mgCh03,mgCh04,mgCh05,mgCh06,mgCh07,mgCh08,mgCh09,mgCh10,mgCh11,mgCh12,mgCh13,mgCh14,mgCh15,mgCh16);
  //instruments (type)
  TMGInstrument=(
  mgAcousticGrandPiano,mgBrightAcousticPiano,mgElectricGrandPiano,
  mgHonkyTonkPiano,mgElectricPiano1,mgElectricPiano2,mgHarpsichord,mgClavinet,
  mgCelesta,mgGlockenspiel,mgMusicBox,mgVibraphone,mgMarimba,mgXylophone,
  mgTubularBells,mgDulcimer,
  mgDrawbarOrgan,mgPercussiveOrgan,mgRockOrgan,mgChurchOrgan,
  mgReedOrgan,mgAccordion,mgHarmonica,mgTangoAccordion,
  mgAcousticNylonGuitar,mgAcousticSteelGuitar,mgJazzElectricGuitar,
  mgCleanElectricGuitar,mgMutedElectricGuitar,mgOverdrivenGuitar,
  mgDistortionGuitar,mgGuitarHarmonics,mgAcousticBass,
  mgFingeredElectricBass,mgPickedElectricBass,mgFretlessBass,
  mgSlapBass1,mgSlapBass2,mgSynthBass1,mgSynthBass2,
  mgViolin,mgViola,mgCello,mgContrabass,
  mgTremoloStrings,mgPizzicatoStrings,mgOrchestralHarp,mgTimpani,
  mgStringEnsemble1,mgStringEnsemble2,mgSynthStrings1,
  mgSynthStrings2,mgChoirAahs,mgVoiceOohs,mgSynthVoice,mgOrchestraHit,
  mgTrumpet,mgTrombone,mgTuba,mgMutedTrumpet,mgFrenchHorn,
  mgBrassSection,mgSynthBrass1,mgSynthBrass2,
  mgSopranoSax,mgAltoSax,mgTenorSax,mgBaritoneSax,
  mgOboe,mgEnglishHorn,mgBassoon,mgClarinet,
  mgPiccolo,mgFlute,mgRecorder,mgPanFlute,mgBlownBottle,
  mgShakuhachi,mgWhistle,mgOcarina,
  mgSquareLead,mgSawtoothLead,mgCalliopeLead,mgChiffLead,
  mgCharangLead,mgVoiceLead,mgFifthsLead,mgBassandLead,
  mgNewAgePad,mgWarmPad,mgPolySynthPad,mgChoirPad,
  mgBowedPad,mgMetallicPad,mgHaloPad,mgSweepPad,
  mgSynthFXRain,mgSynthFXSoundtrack,mgSynthFXCrystal,mgSynthFXAtmosphere,
  mgSynthFXBrightness,mgSynthFXGoblins,mgSynthFXEchoes,mgSynthFXSciFi,
  mgSitar,mgBanjo,mgShamisen,mgKoto,mgKalimba,
  mgBagpipe,mgFiddle,mgShanai,
  mgTinkleBell,mgAgogo,mgSteelDrums,mgWoodblock,
  mgTaikoDrum,mgMelodicTom,mgSynthDrum,mgReverseCymbal,
  mgGuitarFretNoise,mgBreathNoise,mgSeashore,mgBirdTweet,
  mgTelephoneRing,mgHelicopter,mgApplause,mgGunshot,
  //percussion
  mgAcousticBassDrum,mgBassDrum1,mgSideStick,mgAcousticSnare,
  mgHandClap,mgElectricSnare,mgLowFloorTom,mgClosedHiHat,
  mgHighFloorTom,mgPedalHiHat,mgLowTom,mgOpenHiHat,
  mgLowMidTom,mgHiMidTom,mgCrashCymbal1,mgHighTom,
  mgRideCymbal1,mgChineseCymbal,mgRideBell,mgTambourine,
  mgSplashCymbal,mgCowbell,mgCrashCymbal2,mgVibraslap,
  mgRideCymbal2,mgHiBongo,mgLowBongo,mgMuteHiConga,
  mgOpenHiConga,mgLowConga,mgHighTimbale,mgLowTimbale,
  mgHighAgogo,mgLowAgogo,mgCabasa,mgMaracas,
  mgShortWhistle,mgLongWhistle,mgShortGuiro,mgLongGuiro,
  mgClaves,mgHiWoodBlock,mgLowWoodBlock,mgMuteCuica,
  mgOpenCuica,mgMuteTriangle,mgOpenTriangle
  );

  TMidiGen = class(TComponent)

  private
    { Private declarations }
    //midi handle
    OutHandle: HMIDISTRM;
    //midi device
    MidiDevice: UINT;
    //memory handle
    DataBuffer: PChar;
    //buffer size
    BufferSize: Integer;
    //short event count
    sEventCount: Integer;
    //midi header
    mhdr: MIDIHDR;

    //unique ID for each component
    ID:Integer;

    fVolume:Integer;
    fModulation:Integer;
    fChorus:Integer;
    fReverb:Integer;
    fPitchBend:Integer;
    fPBDelay:Integer;
    fPBDuration:Integer;
    fSustain:bool;
    fPan:Integer;
    fNote:TMGNote;
    fOctave:Integer;
    fDuration:Cardinal;
    fInstrument:TMGInstrument;
    fChannel:TMGChannel;
    ChannelInUse:TMGChannel;
    fLoops:Cardinal;
    fIsPlaying:bool;

    CleaningUp:bool;
    DeviceOpened:bool;

    LoopAllowed:bool;
    LoopCount:Cardinal;

    CanPlay:bool;

    TMGHwnd:HWND;

    procedure SetVolume(val:Integer);
    procedure SetReverb(val:Integer);
    procedure SetModulation(val:Integer);
    procedure SetPan(val:Integer);
    procedure SetChorus(val:Integer);
    procedure SetSustain(val:bool);
    procedure SetPitchBend(val:Integer);
    procedure SetPBDelay(val:Integer);
    procedure SetPBDuration(val:Integer);
    procedure SetDuration(val:Cardinal);
    procedure SetNote(val:TMGNote);
    procedure SetOctave(val:Integer);
    procedure SetInstrument(val:TMGInstrument);
    procedure SetChannel(val:TMGChannel);
    procedure SetLoops(val:Cardinal);
    procedure WndProc(var TM: TMessage);

    function LimitValue(lower,upper,val: Integer):Integer;
    function GetPercentage(PC: Integer):Integer;
    function PlayData(ResetOnly:bool; PitchBendEnabled:bool; Data:TList):bool;
    function ExtractNotes(NoteString:String; var Data:TList):bool;
    function WaitForClose: bool;

    class function GetUniqueID: Integer;
    class function IDInUse: Integer;

  protected
    { Protected declarations }

  public
    { Public declarations }

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    { Published declarations }
    property Volume: Integer read fVolume write SetVolume default VolumeDef;
    property Pan: Integer read fPan write SetPan default PanDef;
    property Reverb: Integer read fReverb write SetReverb default ReverbDef;
    property Chorus: Integer read fChorus write SetChorus default ChorusDef;
    property Sustain: bool read fSustain write SetSustain default SustainDef;
    property Modulation: Integer read fModulation write SetModulation default ModulationDef;
    property PitchBend: Integer read fPitchBend write SetPitchBend default PBDef;
    property PBDelay: Integer read fPBDelay write SetPBDelay default PBDelayDef;
    property PBDuration: Integer read fPBDuration write SetPBDuration default PBDurationDef;
    property Duration: Cardinal read fDuration write SetDuration default DurationDef;
    property Note: TMGNote read fNote write SetNote default TMGNote(NoteDef);
    property Octave: Integer read fOctave write SetOctave default OctaveDef;
    property Instrument: TMGInstrument read fInstrument write SetInstrument default TMGInstrument(InstrumentDef);
    property Channel: TMGChannel read fChannel write SetChannel default TMGChannel(ChannelDef);
    property Loops: Cardinal read fLoops write SetLoops default LoopsDef;
    property IsPlaying:bool read fIsPlaying;

    function MidiAvailable:bool;
    function Play:bool;
    function PlayString(Notes:String):bool;
    function PlayNote(NoteVal:Integer):bool;
    function SetDevice(Device:Integer):bool;
    procedure Stop;

  end;

procedure Register;

implementation

//short event types
type sEvent=(sePBRange,seRPNLSB,seRPNMSB,seReverb,seChorus,seSustain,seInstrument,seReset,seNoteOn,seNoteOff,sePitchBend,seVolume,sePan,seModulation);

//midievent short message
type sMIDIEVENT= record
        dwDeltaTime: DWORD;
        dwStreamID: DWORD;
        dwEvent: DWORD;
        end;

//string data contents
type event=record
     dwEventStart:DWORD;
     dwEventType:sEvent;
     dwData:DWORD;
     dwChannel:TMGChannel;
     Processed:bool;
     end;

//forward declarations
function ShortEvent(Time:Integer; lChannel:TMGChannel; Event:SEvent; Data:DWORD;DoCallback:bool=false):sMIDIEVENT;forward;
function NoteOn(Time:Integer; lChannel:TMGChannel; Note:String; Octave:DWORD; Level:Integer):sMIDIEVENT;forward;
function NoteOnDWord(Time:Integer; lChannel:TMGChannel; Note:DWORD; Level:Integer):sMIDIEVENT;forward;
function NoteOff(Time:Integer; lChannel:TMGChannel; Note:String; Octave:DWORD):sMIDIEVENT;forward;
function ResetChannel(Time:Integer; lChannel:TMGChannel;Callback:bool=false):sMIDIEVENT;forward;
function AllNotesOff(Time:Integer; lChannel:TMGChannel):sMIDIEVENT;forward;
function GetNoteNumber(NoteString:String):Integer;forward;
function AddInstrument(Time:Integer; lChannel:TMGChannel; Instrument:TMGInstrument):sMIDIEVENT;forward;
function SetPercussion(Time:Integer; Instrument:DWORD; Level:DWORD; Hit: bool):sMIDIEVENT;forward;
function MidiWord(dw:DWORD):DWORD;forward;
function AddData(Data:PChar; var DataBuf:PChar; var BufSize:Integer; DataSize:Integer):bool;forward;
function AddShortEvent(sEvent:sMIDIEVENT; var DataBuf:PChar; var BufSize:Integer; var EvCount:Integer):bool;forward;
procedure DoPitchBend(TotalTime:Integer; delayPC:Integer; durationPC:Integer; levelPC:Integer; lChannel:TMGChannel; var DataBuf:PChar; var BufSize:Integer; var EvCount:Integer );forward;
function DoReverb(Time:Integer; lChannel:TMGChannel; LevelPC:Integer):sMIDIEVENT;forward;
function DoChorus(Time:Integer; lChannel:TMGChannel; LevelPC:Integer):sMIDIEVENT;forward;
function DoModulation(Time:Integer; lChannel:TMGChannel; LevelPC:Integer):sMIDIEVENT;forward;
function DoVolume(Time:Integer; lChannel:TMGChannel; LevelPC:Integer):sMIDIEVENT;forward;
function DoPan(Time:Integer; lChannel:TMGChannel; LevelPC:Integer):sMIDIEVENT;forward;
function DoSustain(Time:Integer; lChannel:TMGChannel; EffectOn:bool):sMIDIEVENT;forward;
procedure AddChannelEndEvent(lChannel:TMGChannel; var DataBuf:PChar; var BufSize:Integer; var EvCount:Integer);forward;
function EventSort(Item1, Item2: Pointer): Integer;forward;

//procedure dbout(dbstring:String;ok:bool;extra:String='');forward;

var
  //class variables
  UniqueID:Integer=1;
  CurrentID:Integer=0;

  //size of short event structure
  sEventSize: Integer=sizeof(sMIDIEVENT);
  //size of midi header
  HeaderSize: Integer=sizeof(MIDIHDR);
  //note-number string
  NoteNumbers: String='00C01C+01C#02D01D-03D+03D#04E03E-05F06F+06F#07G06G-08G+08G#09A08A-10A+10A#11B10B-';
TotalAlloc:integer;
EventCount:integer;

const
     PERCUSSION=TMGChannel(9);
     LASTINSTRUMENT=174;

procedure Register;
begin
  RegisterComponents('Samples', [TMidiGen]);
end;


//unique ID for each component **********************************************
class function TMidiGen.GetUniqueID: Integer;
begin
Result:=UniqueID;
end;

//current component using midi **********************************************
class function TMidiGen.IDInUse: Integer;
begin
Result:=CurrentID;
end;

//limit value
function TMidiGen.LimitValue(lower,upper,val: Integer):Integer;
var
   msg:String;

begin
if (val>=lower) and (val<=upper) then
   begin
   Result:=val;
   Exit;
   end;

//error message?
if csDesigning in ComponentState then
   begin
   msg:='Value must be between '+IntToStr(lower)+' and '+IntToStr(upper);
   MessageBox(0,PChar(msg),'Error',MB_OK or MB_ICONERROR);
   end;

if val>upper then
   Result:=upper
else
   Result:=lower;


end;


//limit values  0 to 100 **********************************************
//if designing give warning
//force to limits
function TMidiGen.GetPercentage(PC: Integer):Integer;
begin

Result:=LimitValue(0,100,PC);
end;

//constructor **********************************************
constructor TMidiGen.Create(AOwner: TComponent);
begin
Inherited Create(AOwner);

OutHandle:=0;
MidiDevice:=MIDIMAPPER;
DataBuffer:=nil;
BufferSize:=0;
sEventCount:=0;

fLoops:=LoopsDef;
fVolume:=VolumeDef;
fReverb:=ReverbDef;
fChorus:=ChorusDef;
fPan:=PanDef;
fPitchBend:=PBDef;
fPBDelay:=PBDelayDef;
fPBDuration:=PBDurationDef;
fDuration:=DurationDef;
fOctave:=OctaveDef;
fNote:=TMGNote(NoteDef);
fSustain:=SustainDef;
fModulation:=ModulationDef;
fInstrument:=TMGInstrument(InstrumentDef);
fChannel:=TMGChannel(ChannelDef);
ChannelInUse:=fChannel;

CleaningUp:=false;

fIsPlaying:=false;
LoopAllowed:=false;
DeviceOpened:=false;

//unique ID
ID:=GetUniqueID;
inc(UniqueID);

//window handle & proc
TMGHwnd:=AllocateHWnd(WndProc);
TotalAlloc:=0;

//can play
CanPlay:=true;

end;

//destructor **********************************************
destructor TMidiGen.Destroy;
begin
//stop
Stop;

while DeviceOpened do
      Application.ProcessMessages;


DeallocateHWnd(TMGHwnd);

inherited Destroy;
end;

//wndproc **********************************************
procedure TMidiGen.WndProc(var TM: TMessage);
var
   msg:UINT;

begin
msg:=TM.Msg;

//open
if msg=MOM_OPEN then
   begin
   //mdshow('open');
   DeviceOpened:=true;
   fIsPlaying:=true;
   LoopAllowed:=true;
   LoopCount:=fLoops;

   end;

//callback on first event
if (msg=MM_MOM_POSITIONCB) or (msg=MOM_POSITIONCB) then
   begin
   CanPlay:=true;
   end;

if msg=MOM_DONE then
        begin

        //loop?
        if LoopAllowed and ((LoopCount>1) or (LoopCount=0))then
           begin

           //play again?
           if (LoopCount>1) or (LoopCount=0) then
              begin
              midiStreamOut(OutHandle,@mhdr,HeaderSize);
              midiStreamRestart(OutHandle);
              end;

           //dec loop count
           if LoopCount>1 then
              begin
              Dec(LoopCount);
              end;

           Exit;
           end;

        midiOutUnprepareHeader(OutHandle,@mhdr,HeaderSize);

        midiStreamStop(OutHandle);

        midiOutReset(OutHandle);

        if DataBuffer<>nil then
           begin
           GlobalFree(HGLOBAL(DataBuffer));
           Dec(TotalAlloc);

          DataBuffer:=nil;
          BufferSize:=0;
          sEventCount:=0;
          end;

        midiStreamClose(OutHandle);

        end;//MOM_DONE

if msg=MOM_CLOSE then
   begin
   //mdshow('closed');
   DeviceOpened:=false;
   OutHandle:=0;
   fIsPlaying:=false;
   LoopAllowed:=false;
   Inc(EventCount);

   end;

end;

//set device **********************************************
function TMidiGen.SetDevice(Device:Integer):bool;
var
   nd:Integer;

begin
MidiDevice:=Device;

//number of devices
nd:=midiOutGetNumDevs;

//error?
if (nd=0) or (nd<=Device) then
   result:=false
else
   result:=true;

end;


//volume **********************************************
procedure TMidiGen.SetVolume(val:Integer);
begin
fVolume:=GetPercentage(val);
end;

//reverb **********************************************
procedure TMidiGen.SetReverb(val:Integer);
begin
fReverb:=GetPercentage(val);
end;

//pan **********************************************
procedure TMidiGen.SetPan(val:Integer);
begin
fPan:=LimitValue(-100,100,val);
end;

//chorus **********************************************
procedure TMidiGen.SetChorus(val:Integer);
begin
fChorus:=GetPercentage(val);
end;

//sustain **********************************************
procedure TMidiGen.SetSustain(val:bool);
begin
fSustain:=val;
end;

//modulation **********************************************
procedure TMidiGen.SetModulation(val:Integer);
begin
fModulation:=GetPercentage(val);
end;

// pitch bend level **********************************************
procedure TMidiGen.SetPitchBend(val:Integer);
begin
fPitchBend:=LimitValue(-120,120,val);
end;

// pitch bend delay **********************************************
procedure TMidiGen.SetPBDelay(val:Integer);
begin
fPBDelay:=GetPercentage(val);
end;

// pitch bend duration **********************************************
procedure TMidiGen.SetPBDuration(val:Integer);
begin
fPBDuration:=GetPercentage(val);
end;

//duration **********************************************
procedure TMidiGen.SetDuration(val:Cardinal);
begin
fDuration:=val;
end;

//note **********************************************
procedure TMidiGen.SetNote(val:TMGNote);
begin
fNote:=TMGNote(LimitValue(0,11,Integer(val)));
end;

//octave **********************************************
procedure TMidiGen.SetOctave(val:Integer);
begin
fOctave:=LimitValue(0,10,val);
end;

//instrument **********************************************
procedure TMidiGen.SetInstrument(val:TMGInstrument);
begin
fInstrument:=TMGInstrument(LimitValue(0,LASTINSTRUMENT,Integer(val)));
end;

//channel **********************************************
procedure TMidiGen.SetChannel(val:TMGChannel);
begin

fChannel:=TMGChannel(LimitValue(0,15,Integer(val)));

end;

//loops **********************************************
procedure TMidiGen.SetLoops(val:Cardinal);
begin
fLoops:=val;
end;

//----------------------------------------------------------------------------
//midi callback
procedure MidiProc(hmo:HMIDIOUT; msg:UINT; inst:DWORD; param1:DWORD; param2:DWORD);stdcall;
var
   passed:TMidiGen;

begin
passed:=TMidiGen(inst);

//pass to wndproc
PostMessage(passed.TMGHwnd,msg,0,0);

end;

//play string
//----------------------------------------------------------------------------
function TMidiGen.PlayString(Notes:String):bool;
var
   Data:TList;
   CanUsePB:bool;

begin
Result:=false;

//no play allowed?
if not WaitForClose then exit;

LoopCount:=fLoops;
ChannelInUse:=fChannel;

Data:=TList.Create;

CanUsePB:=ExtractNotes(Notes,Data);

if Data.Count>0 then
   Result:=PlayData(false,CanUSePB,Data);

Data.Free;
Data:=nil;

end;
//play single from properties
//----------------------------------------------------------------------------
function TMidiGen.Play:bool;
begin
Result:=PlayNote(Integer(fNote)+(12*fOctave));
end;

//play single
//----------------------------------------------------------------------------
function TMidiGen.PlayNote(NoteVal:Integer):bool;
var
   Data:TList;
   info:^event;
   tChannel:TMGChannel;
   tNote:Integer;

begin
result:=false;

if not WaitForClose then exit;

LoopCount:=fLoops;
ChannelInUse:=fChannel;

Data:=TList.Create;

//add instrument
if ChannelInUse<>PERCUSSION then
    begin
    new(info);
    info.dwEventStart:=0;
    info.dwEventType:=seInstrument;
    info.dwData:=Cardinal(fInstrument);

    if Integer(fInstrument)>127 then
      begin
      info.dwChannel:=PERCUSSION;
      end
    else
      begin
      info.dwChannel:=ChannelInUse;
      end;

    tChannel:=info.dwChannel;
    Data.Add(info);
    end
else
    tChannel:=PERCUSSION;

tNote:=LimitValue(0,127,NoteVal);//Integer(fNote)+(12*fOctave);

//add note on
new(info);
info.dwEventStart:=0;
info.dwEventType:=seNoteOn;
info.dwChannel:=tChannel;

//percussion channel selected?
if (ChannelInUse<>PERCUSSION) and (tChannel=PERCUSSION) then
  info.dwData:=Integer(fInstrument)
else
  info.dwData:=tNote;
Data.Add(info);

//add note off
new(info);
info.dwEventStart:=fDuration;
info.dwEventType:=seNoteOff;
info.dwChannel:=tChannel;
if (ChannelInUse<>PERCUSSION) and (tChannel=PERCUSSION) then
  info.dwData:=Integer(fInstrument)
else
  info.dwData:=tNote;
Data.Add(info);

//play data
Result:=PlayData(false,true,Data);

//finished with tlist
Data.Free;


end;
//stop
//----------------------------------------------------------------------------
procedure TMidiGen.Stop;
begin
LoopAllowed:=false;

if (DeviceOpened) and (CanPlay) then
   begin
   midiStreamStop(OutHandle);
   end;


end;

//----------------------------------------------------------------------------
function TMidiGen.WaitForClose: bool;
begin

//are we already playing and can we do a stop?
if (CanPlay=false) or (MidiAvailable=false) then
   begin
   result:=false;
   exit;
   end;

//no more play calls for now
CanPlay:=false;
LoopAllowed:=false;

//close from previous use?
if DeviceOpened then
   begin
   midiStreamStop(OutHandle);
   end;

while DeviceOpened do
      begin
      Application.ProcessMessages;
      end;

Result:=true;
end;

//----------------------------------------------------------------------------
function TMidiGen.PlayData(ResetOnly:bool; PitchBendEnabled:bool; Data:TList):bool;
var
   prop: MIDIPROPTIMEDIV;
   edata:^event;
   err: Integer;
   i: Integer;
   dopb:bool;
   firstnoteoff:bool;
   DeltaTime,RunningTime:DWORD;

begin
Result:=false;
//currently in use by someone else?
if (IDInUse<>0) and (IDInUse<>ID) then exit;

ChannelInUse:=fChannel;

dopb:=(fPitchBend<>0) and PitchBendEnabled;


//only doing reset?
if not ResetOnly then
    begin
    //play instrument***************
    //reset channels
    //tag callback onto first event
    AddShortEvent(ResetChannel(0,ChannelInUse,true),DataBuffer,BufferSize,sEventCount);
    AddShortEvent(ResetChannel(0,PERCUSSION),DataBuffer,BufferSize,sEventCount);

    //set PB range to 12 semitones
    AddShortEvent(ShortEvent(0,ChannelInUse,seRPNLSB,$64),DataBuffer,BufferSize,sEventCount);
    AddShortEvent(ShortEvent(0,ChannelInUse,seRPNMSB,$65),DataBuffer,BufferSize,sEventCount);
    AddShortEvent(ShortEvent(0,ChannelInUse,sePBRange,($c*$100)+$6),DataBuffer,BufferSize,sEventCount);
    AddShortEvent(ShortEvent(0,ChannelInUse,seRPNLSB,$7f64),DataBuffer,BufferSize,sEventCount);
    AddShortEvent(ShortEvent(0,ChannelInUse,seRPNMSB,$7f65),DataBuffer,BufferSize,sEventCount);

    //pan
    //if fPan<>0 then
       begin
       //set pan to position
       AddShortEvent(DoPan(0,ChannelInUse,fPan),DataBuffer,BufferSize,sEventCount);
       AddShortEvent(DoPan(0,PERCUSSION,fPan),DataBuffer,BufferSize,sEventCount);
       end;

    //modulation
    //if fModulation>0 then
       AddShortEvent(DoModulation(0,ChannelInUse,fModulation),DataBuffer,BufferSize,sEventCount);

    //volume
    AddShortEvent(DoVolume(0,ChannelInUse,fVolume),DataBuffer,BufferSize,sEventCount);
    AddShortEvent(DoVolume(0,PERCUSSION,fVolume),DataBuffer,BufferSize,sEventCount);

    //sustain
    //if fSustain then
       AddShortEvent(DoSustain(0,ChannelInUse,fSustain),DataBuffer,BufferSize,sEventCount);

    //reverb
    //if fReverb>0 then
       AddShortEvent(DoReverb(0,ChannelInUse,fReverb),DataBuffer,BufferSize,sEventCount);

    //chorus
    //if fChorus>0 then
        AddShortEvent(DoChorus(0,ChannelInUse,fChorus),DataBuffer,BufferSize,sEventCount);


    //add data
    RunningTime:=0;
    firstnoteoff:=true;
    for i:=0 to Data.Count-1 do
        begin
        edata:=Data.Items[i];
        DeltaTime:=edata.dwEventStart-RunningTime;

        //no instrument specified at start so use property
        if (i=0) and (edata.dwEventType<>seInstrument) then
           begin
           AddShortEvent(AddInstrument(0,ChannelInUse,fInstrument),DataBuffer,BufferSize,sEventCount);
           end;

        //select event type
        case edata.dwEventType of

             //note on
             seNoteOn:
                      begin
                      if (edata.dwChannel=PERCUSSION) and (ChannelInUse<>PERCUSSION) then
                         begin
                         AddShortEvent(SetPercussion(DeltaTime,edata.dwData,127,true),DataBuffer,BufferSize,sEventCount);
                         end
                      else
                          begin
                          AddShortEvent(NoteOnDWord(DeltaTime,edata.dwChannel,edata.dwData,127),DataBuffer,BufferSize,sEventCount);
                          end;
                      end;//note on

             //note off
             seNoteOff:
                      begin
                      //pitch bend
                      if dopb and firstnoteoff then
                         begin
                         DoPitchBend(DeltaTime,fPBDelay,fPBDuration,fPitchBend,edata.dwChannel,DataBuffer,BufferSize,sEventCount);
                         firstnoteoff:=false;
                         end;

                       if (edata.dwChannel=PERCUSSION) and (ChannelInUse<>PERCUSSION) then
                          begin
                          AddShortEvent(SetPercussion(DeltaTime,edata.dwData,127,false),DataBuffer,BufferSize,sEventCount);
                          end
                       else
                           begin
                           AddShortEvent(NoteOnDWord(DeltaTime,edata.dwChannel,edata.dwData,0),DataBuffer,BufferSize,sEventCount);
                           end;
                      end; //noteoff

             //instrument change
             seInstrument:
                      begin
                      AddShortEvent(AddInstrument(DeltaTime,edata.dwChannel,TMGInstrument(edata.dwData)),DataBuffer,BufferSize,sEventCount);

                      end;//instrument

        end;//case

        //update running time
        RunningTime:=edata.dwEventStart;

        //dump entry
        Dispose(edata);

        end;//for i

    end;//reset only

//open midi stream
while DeviceOpened do
      begin
      Application.ProcessMessages;
      end;

//err:=midiStreamOpen(@OutHandle,@MidiDevice,1,DWORD (@MidiProc),Cardinal(self),CALLBACK_FUNCTION);
err:=midiStreamOpen(@OutHandle,@MidiDevice,1,DWORD (TMGHwnd),Cardinal(self),CALLBACK_WINDOW);

repeat
      Application.ProcessMessages;
until (DeviceOpened);


if err<>MMSYSERR_NOERROR then
        begin
        //mdshow('OpenErr');
        //mdshow(err);
        Exit;
        end;

//flag as in use by us
CurrentID:=ID;

//reset
midiOutReset(OutHandle);

//set time sig
prop.cbStruct:=sizeof(prop);
prop.dwTimeDiv:=50;
err:=midiStreamProperty(OutHandle,@prop,MIDIPROP_SET or MIDIPROP_TIMEDIV);

if err<>MMSYSERR_NOERROR then
        begin
        //mdshow('PropertyErr');
        //mdshow(err);
        Exit;
        end;

//put in midi header
FillMemory(@mhdr,HeaderSize,0);
mhdr.lpData:=DataBuffer;
mhdr.dwBufferLength:=BufferSize;
mhdr.dwBytesRecorded:=BufferSize;

//prepare header
err:=midiOutPrepareHeader(OutHandle,@mhdr,HeaderSize);
if err<>MMSYSERR_NOERROR then
        begin
        //mdshow('PrepareErr');
        //mdshow(err);
        Exit;
        end;

//send to stream
err:=midiStreamOut(OutHandle,@mhdr,HeaderSize);
if err<>MMSYSERR_NOERROR then
        begin
        //mdshow('OutErr');
        //mdshow(err);
        Exit;
        end;


//restart stream
err:=midiStreamRestart(OutHandle);
if err<>MMSYSERR_NOERROR then
        begin
        //mdshow('RestartErr');
        //mdshow(err);
        Exit;
        end;

Result:=true;
end;
//----------------------------------------------------------------------------
//is midi available
function TMidiGen.MidiAvailable:bool;
var
   tOutHandle:Integer;
   mmr:MMRESULT;

begin

if (DeviceOpened) then
   begin
   Result:=true;
   Exit;
   end;

//not currently in use?
//if IDInUse=0 then
   begin
    {while DeviceOpened do
          begin
          Application.ProcessMessages;
          end;}

    mmr:=midiOutOpen(@tOutHandle,MidiDevice,0,0,CALLBACK_NULL);
    midioutClose(tOutHandle);


    if mmr<>MMSYSERR_NOERROR then
       begin
       Result:=false;
       end
    else
       begin
       Result:=true;
       end;
   end;
//else
   begin
   //Result:=false;
   end;

end;
//----------------------------------------------------------------------------
//create normal instrument
function AddInstrument(Time:Integer; lChannel:TMGChannel; Instrument:TMGInstrument):sMIDIEVENT;
begin

if Integer(Instrument)>127 then Instrument:=TMGInstrument(127);
//if Instrument<0 then Instrument:=0;

Result:=ShortEvent(Time,lChannel,seInstrument,Cardinal(Instrument));

end;
//----------------------------------------------------------------------------
//create percussion instrument
function SetPercussion(Time:Integer; Instrument:DWORD; Level:DWORD; Hit: bool):sMIDIEVENT;
begin

Instrument:=Instrument-93;
if Instrument<35 then Instrument:=35;
if Instrument>81 then Instrument:=81;

//on or off?
if hit then
   begin
   //on
   Result:=NoteOnDWord(Time,PERCUSSION,Instrument,Level);
   end
else
   begin
   //off
   Result:=NoteOnDWord(Time,PERCUSSION,Instrument,0);
   end;

end;
//----------------------------------------------------------------------------
//end of play sequence event
procedure AddChannelEndEvent(lChannel:TMGChannel; var DataBuf:PChar; var BufSize:Integer; var EvCount:Integer);
begin

//all notes off
AddShortEvent(AllNotesOff(0,lChannel),DataBuf,BufSize,EvCount);
//midi reset
//AddShortEvent(ResetChannel(10,lChannel),DataBuf,BufSize,EvCount);

end;

//----------------------------------------------------------------------------
//all notes off
function AllNotesOff(Time:Integer; lChannel:TMGChannel):sMIDIEVENT;
begin

Result:=ShortEvent(Time,lChannel,seReset,123);
end;

//----------------------------------------------------------------------------
//create channel reset
function ResetChannel(Time:Integer; lChannel:TMGChannel; Callback:bool = false):sMIDIEVENT;
begin

Result:=ShortEvent(Time,lChannel,seReset,$79,Callback);

end;
//----------------------------------------------------------------------------
//create note on (value)
function NoteOnDWord(Time:Integer; lChannel:TMGChannel; Note:DWORD; Level:Integer):sMIDIEVENT;
var
   NoteVal: DWORD;

begin
NoteVal:=Level*$100;

if Note>127 then Note:=127;
//if Note<0 then Note:=0;

//add note number
NoteVal:=NoteVal or Note;

Result:=ShortEvent(Time,lChannel,seNoteOn,NoteVal);
end;
//----------------------------------------------------------------------------
//create note on (string)
function NoteOn(Time:Integer; lChannel:TMGChannel; Note:String; Octave:DWORD; Level:Integer):sMIDIEVENT;
var
   NoteNum:Integer;

begin

NoteNum:=GetNoteNumber(Note);


if NoteNum>127 then NoteNum:=127;
if NoteNum<0 then NoteNum:=0;

//add note number
Result:=NoteOnDWord(Time,lChannel,(Octave*12) + DWORD(NoteNum),Level);

end;
//----------------------------------------------------------------------------
//extract note number
function GetNoteNumber(NoteString:String):Integer;
var
   NotePos: Integer;

begin
NotePos:=AnsiPos(AnsiUpperCase(NoteString),NoteNumbers);
Result:=-1;

if NotePos>0 then
   Result:=StrToIntDef(String(NoteNumbers[NotePos-2])+String(NoteNumbers[NotePos-1]),0);

end;
//----------------------------------------------------------------------------
//create note off
function NoteOff(Time:Integer; lChannel:TMGChannel; Note:String; Octave:DWORD):sMIDIEVENT;
begin

//note on with zero volume
Result:=NoteOn(Time,lChannel,Note,Octave,0);

end;
//----------------------------------------------------------------------------
//sustain
function DoSustain(Time:Integer; lChannel:TMGChannel; EffectOn:bool):sMIDIEVENT;
var
   Level:DWORD;

begin
if EffectOn then
   Level:=$7f00
else
   Level:=$0;

Result:=ShortEvent(Time,lChannel,seSustain,Level+$40);

end;

//----------------------------------------------------------------------------
//chorus
function DoChorus(Time:Integer; lChannel:TMGChannel; LevelPC:Integer):sMIDIEVENT;
var
   level:Integer;

begin
level:=($7f * LevelPC) div 100;

Result:=ShortEvent(Time,lChannel,seChorus,(level*$100)+$5D);

end;

//----------------------------------------------------------------------------
//reverb
function DoReverb(Time:Integer; lChannel:TMGChannel; LevelPC:Integer):sMIDIEVENT;
var
   level:Integer;

begin
level:=($7f * LevelPC) div 100;

Result:=ShortEvent(Time,lChannel,seReverb,(level*$100)+$5b);

end;

//----------------------------------------------------------------------------
//modulation
function DoModulation(Time:Integer; lChannel:TMGChannel; LevelPC:Integer):sMIDIEVENT;
var
   level:Integer;

begin
level:=($7f * LevelPC) div 100;

Result:=ShortEvent(Time,lChannel,seModulation,(level*$100)+$1);

end;

//----------------------------------------------------------------------------
//volume
function DoVolume(Time:Integer; lChannel:TMGChannel; LevelPC:Integer):sMIDIEVENT;
var
   level:Integer;

begin
level:=($7f * LevelPC) div 100;

Result:=ShortEvent(Time,lChannel,seVolume,(level*$100)+$7);

end;

//----------------------------------------------------------------------------
//pan
function DoPan(Time:Integer; lChannel:TMGChannel; LevelPC:Integer):sMIDIEVENT;
var
   level:Integer;

begin
level:=$40+(($3f * LevelPC) div 100);


Result:=ShortEvent(Time,lChannel,sePan,(Level*$100)+$a);

end;

//----------------------------------------------------------------------------
//create pitch bend sequence
procedure DoPitchBend(TotalTime:Integer; delayPC:Integer; durationPC:Integer; levelPC:Integer; lChannel:TMGChannel; var DataBuf:PChar; var BufSize:Integer; var EvCount:Integer );
var
   i:Integer;
   pbevent:sMIDIEVENT;
   PBLevel:Integer;
   PBStep:Integer;
   Offset,Steps:Integer;

begin

//nothing to do?
if (TotalTime=0) or (durationPC=0) or (delayPC=100) or (levelPC=0) then Exit;

//delay value
Offset:=(TotalTime * delayPC) div 100;

//no of steps
Steps:=((TotalTime-Offset) * durationPC) div 100;

if (Steps=0) or (Steps>8191) then Exit;

//increment per step
PBStep:=((8191 * levelPC) div 120) div Steps;

PBLevel:=8192+PBStep;

for i:=1 to Steps do
    begin

    if i=1 then
       begin
       //add offset
       pbevent:=ShortEvent(Offset+1,lChannel,sePitchBend,MidiWord(PBLevel));
       end
    else
        begin
        pbevent:=ShortEvent(1,lChannel,sePitchBend,MidiWord(PBLevel));
        end;

    AddShortEvent(pbevent,DataBuf,BufSize,EvCount);

    //inc or dec
    PBLevel:=PBLevel+PBStep;

    end;


end;

//----------------------------------------------------------------------------
//create a short event
function ShortEvent(Time:Integer; lChannel:TMGChannel; Event:SEvent; Data:DWORD; DoCallback:bool=false):sMIDIEVENT;
var
   rv:sMIDIEVENT;
   Status: DWORD;

begin
//reserved
rv.dwStreamID:=0;

//time offset
rv.dwDeltaTime:=Time;

//set status value
case Event of
     //note on
     seNoteOn:Status:=$90;

     //NoteOff
     seNoteOff:Status:=$90;

     //reset
     seReset: Status:=$B0;

     //instrument
     seInstrument: Status:=$C0;

     //pitch bend
     sePitchBend: Status:=$E0;

     //modulation, volume,pan,sustain,reverb,chorus
     seSustain,seModulation,seVolume,sePan,seReverb,seChorus: Status:=$B0;

     //rpn
     seRPNLSB: Status:=$B0;
     seRPNMSB: Status:=$B0;

     //Pitch bend range
     sePBRange: Status:=$B0;

     else Status:=$B0;

     end;

//add channel
Status:=Status or (Cardinal(lChannel) and $f);

//shift left
Data:=Data*$100;

//build event
if DoCallback then //callback?
   rv.dwEvent:=(MEVT_F_SHORT *$1000000) or MEVT_F_CALLBACK or Data or Status
else
    rv.dwEvent:=(MEVT_F_SHORT*$1000000) or Data or Status;

Result:=rv;
end;
//----------------------------------------------------------------------------
//create a midi message MSB LSB from 14 bits of a DWORD
function MidiWord(dw:DWORD):DWORD;
var
   MSB,LSB:DWORD;

begin


LSB:=dw and $7f;
MSB:=(dw and $3f80) * 2;
Result:=MSB or LSB;

end;
//----------------------------------------------------------------------------
//add a midi short event to a memory block
function AddShortEvent(sEvent:sMIDIEVENT; var DataBuf:PChar; var BufSize:Integer; var EvCount:Integer):bool;
begin
Result:=false;

//add event to data block
if AddData(@sEvent,DataBuf,BufSize,sEventSize) then
   begin
   Inc(EvCount);
   Result:=true;
   end

end;
//----------------------------------------------------------------------------
//re-allocate memory and add data
function AddData(Data:PChar; var DataBuf:PChar; var BufSize:Integer; DataSize:Integer):bool;
var
   TempBuf: PChar;

begin

//max buffersize allowed
if BufSize+DataSize>$ffff then
   begin
   Result:=false;
   Exit;
   end;

//allocate temporary block
TempBuf:=PChar(GlobalAlloc(GMEM_FIXED,BufSize+DataSize));
Inc(TotalAlloc);


//failed?
if TempBuf=nil then
   begin
   Result:=false;
   Exit;
   end;

if (DataBuf<>nil) and (BufSize>0) then
   begin
   //copy original data
   CopyMemory(TempBuf,DataBuf,BufSize);
   end;

//add new data
CopyMemory(TempBuf+BufSize,Data,DataSize);

//delete original
if DataBuf<>nil then
   begin
   GlobalFree(HGLOBAL(DataBuf));
   Dec(TotalAlloc);

   DataBuf:=nil;
   end;

//assign variable
DataBuf:=TempBuf;
BufSize:=BufSize+DataSize;


Result:=true;
end;

//----------------------------------------------------------------------------
//extract note & octave data from a string
//return no of valid strings found
function TMidiGen.ExtractNotes(NoteString:String; var Data:TList):bool;
var
   noteval,inst,note,tdel,del,tdur,dur,tOct,Oct,lts,sl,dp,dmp:Integer;
   ts,tns,tos,tdels,tnots:String;
   info:^event;
   LastStartTime:Integer;
   tInstrument:TMGInstrument;
   tChannel:TMGChannel;
   CanUsePB:bool;

begin
NoteString:=Trim(NoteString);
NoteString:=AnsiUpperCase(NoteString);
dp:=0;
LastStartTime:=0;
Oct:=fOctave;
dur:=-1;
del:=0;
CanUsePB:=true;

//default instrument if not percussion channel
if (Integer(fInstrument)<128) and (ChannelInUse<>PERCUSSION) then
   begin
   tChannel:=ChannelInUse;
   tInstrument:=fInstrument;
   end
else
   begin
   tChannel:=PERCUSSION;
   tInstrument:=fInstrument;
   end;


//strip out all spaces
repeat
  dmp:=AnsiPos(' ',NoteString);

  if dmp>0 then
     Delete(NoteString,dmp,1);

until dmp=0;


sl:=Length(NoteString);

if sl=0 then
   begin
   Result:=false;
   Exit;
   end;

while sl>0 do
      begin
      note:=-1;
      inst:=-1;
      tdel:=-1;
      noteval:=-1;

      //find , delimiter
      dmp:=AnsiPos(',',NoteString);

      //no , delimiter but not an empty string
      if (dmp=0) and (sl>0) then dmp:=sl+1;

      if dmp>1 then
          begin

          //get , delimited substring
          ts:=Trim(Copy(NoteString,1,dmp-1));

          //no data specified?
          lts:=Length(ts);
          if lts=0 then Break;

          //find ; delimiters
          //no number or ; to start?
          if (StrToIntDef(ts[1],-1)=-1) and (ts[1]<>';') then
             begin
             //add start ;
             ts:=';'+ts;
             end;

          //starts with ;?
          if ts[1]=';' then
             begin
             //add default delay
             ts:=IntToStr(del)+ts;
             end;

          //only one ;
          if LastDelimiter(';',ts)=AnsiPos(';',ts) then
             begin
             //only one so tag one on the end
             ts:=ts+';';
             end;

          //ends with ;?
          lts:=Length(ts);
          if ts[lts]=';' then
             begin
             //used for duration changes in PB checks
             if dur=-1 then dur:=fDuration;

             //add default duration
             ts:=ts+IntToStr(dur);
             end;


          //extract delay************************
          dp:=AnsiPos(';',ts);

          //get ; delimited delay substring
          tdels:=Copy(ts,1,dp-1);

          //get delay?
          tdel:=StrToIntDef(tdels,-1);
          if tdel>-1 then del:=tdel;

          //no pitch bend if delay not zero
          if tdel<>0 then CanUsePB:=false;

          //delete substring from master
          Delete(ts,1,dp);

          //extract note & octave or instrument**********************
          dp:=AnsiPos(';',ts);

          //get ; delimited note substring
          tnots:=Copy(ts,1,dp-1);
          lts:=Length(tnots);

          inst:=-1;
          //instrument change?
          if lts>1 then
             begin
             if tnots[1]='I' then
                begin
                //instrument number
                inst:=StrToIntDef(Copy(tnots,2,lts-1),-1);
                end;
             end;

          noteval:=-1;
          if inst<0 then
             begin
              //direct note value?
              if lts>1 then
                 begin
                 if tnots[1]='N' then
                    begin
                    //note value
                    noteval:=StrToIntDef(Copy(tnots,2,lts-1),-1);
                    if (noteval<0) or (noteval>127) then noteval:=-1;
                    end;
                 end;
             end;

          //not an instrument or note value
          if (noteval<0) and (inst<0) then
             begin
              //no octave specified?
              if (lts<2) or (StrToIntDef(tnots[lts],-1)=-1) then
                 begin
                 tnots:=tnots+IntToStr(Oct);
                 lts:=Length(tnots);
                 end;

              //#, + or -?
              if (StrToIntDef(tnots[2],-1)<>-1) then //octave value is second character
                 begin
                 //extract note and octave
                 tns:=Copy(tnots,1,1);
                 tos:=Copy(tnots,2,lts-1);
                 end
              else //accidental
                 begin
                 tns:=Copy(tnots,1,2);
                 tos:=Copy(tnots,3,lts-1);
                 end;

              //valid note?
              note:=-1;
              tOct:=StrToIntDef(tos,-1);
              if (tOct>-1)  and (tOct<11) then //octave ok
                 begin
                 //search for note string
                 note:=GetNoteNumber(tns);
                 if note>-1 then
                    begin
                    Oct:=tOct;
                    note:=Oct*12+note;
                    end;
                 end;

              end;
              end;

          //delete substring from ; master
          Delete(ts,1,dp);

          //get duration
          tdur:=StrToIntDef(ts,-1);
          if tdur>0 then
             begin
             //no pitch bend if duration varies
             if (dur<>tdur) and (dur<>-1) then CanUsePB:=false;

             dur:=tdur;
             end;

       if noteval>-1 then note:=noteval;

       //add data to TList
       if ((tdur>-1) and (tdel>-1)) and (((inst>-1) and (inst<=LASTINSTRUMENT)) or ((note>-1) and (note<128))) then
          begin
          new (info);
          LastStartTime:=del+LastStartTime;
          info.Processed:=false;

          //instrument change
          if (inst>-1) then
             begin
             info.dwEventStart:=LastStartTime;
             info.dwEventType:=seInstrument;
             info.dwData:=inst;

             if inst>127 then
                begin
                tChannel:=PERCUSSION;
                tInstrument:=TMGInstrument(inst);
                end
             else
                begin
                tChannel:=ChannelInUse;
                end;

             info.dwChannel:=tChannel;
             //add instrument
             if ChannelInUse<>PERCUSSION then
                Data.Add(info)
             else
                tChannel:=PERCUSSION;
             end

          else //note
             begin
             info.dwEventStart:=LastStartTime;
             info.dwEventType:=seNoteOn;
             if (tChannel=PERCUSSION) and (ChannelInUse<>PERCUSSION) then
                info.dwData:=Integer(tInstrument)
             else
                info.dwData:=note;

             info.dwChannel:=tChannel;
             //add note on
             Data.Add(info);

             //now do note off
             new(info);
             info.dwEventStart:=LastStartTime+dur;
             info.dwEventType:=seNoteOff;
             if (tChannel=PERCUSSION ) and (ChannelInUse<>PERCUSSION)then
                info.dwData:=Integer(tInstrument)
             else
                info.dwData:=note;

             info.dwData:=note;
             info.dwChannel:=tChannel;
             Data.Add(info);
             end;

          end;

       //delete substring from master
       Delete(NoteString,1,dmp);

       sl:=Length(NoteString);
       end;

//sort tlist into event start order
Data.Sort(EventSort);

Result:=CanUsePB;
end;
//----------------------------------------------------------------------------
//tlist sort function
function EventSort(Item1, Item2: Pointer): Integer;
var
   info1,info2:^event;
begin
info1:=Item1;
info2:=Item2;

//instrument change first
if info1.dwEventStart=info2.dwEventStart then
   begin

   if (info1.dwEventType=seInstrument) and (info2.dwEventType<>seInstrument) then
      begin
      Result:=-1;
      Exit;
      end;


   if (info2.dwEventType=seInstrument) and (info1.dwEventType<>seInstrument) then
      begin
      Result:=1;
      Exit;
      end;
   end;

Result:=info1.dwEventStart-info2.dwEventStart;
end;

//---------------------------------------------------------------------
//output debug info to file
{procedure dbout(dbstring:String;ok:bool;extra:String='');
var
   fs:TFileStream;
   ts:String;

begin

fs:=TFileStream.Create(ExtractFilePath(Application.ExeName)+'dbinfo.txt',fmOpenReadWrite);
fs.Seek(0,soFromEnd);

ts:=IntToStr(GetTickCount)+#9#9;

fs.Write(ts[1],Length(ts));

if ok then
   dbstring:=dbstring+' OK'
else
    dbstring:=dbstring+' *FAIL*';

dbstring:=dbstring+#9#9+IntToStr(EventCount)+' '+extra+#13;
fs.Write(dbstring[1],Length(dbstring));
fs.Free;

end;}

end.
