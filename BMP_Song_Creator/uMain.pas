unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MidiGen, StdCtrls, ExtCtrls, ExtDlgs, Spin,uCommonType, ComCtrls;

type

  (*
  comment sont representés les notes grace à 1 byte ???


  de [0 - 11 ] :
  C  C#     D  D#    E  F  F#   G   G#    A   A#    B
  do doMaj re reMaj mi fa faMaj sol solMaj la  laMaj Si
  0  1     2   3    4  5  6     7   8      9    10    11

  de [12,22] :
    Changement d'octave (si on veut un autre pendant la chanson <> DefaultOctave )
  12 13 14 15 16 17 18 19 20 21 22 : valeur byte
  0  1  2  3  4  5  6  7  8  9  10 : valeur octave

  de [23,42]
    Changement de Durée des  notes [*]
    valeur:         23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42
    durée :         1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20

  de [43,63]
    Changement de Delay entre les notes [*]
    valeur:         43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63
    delay :         0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20



  de [64,64+LASTINSTRUMENT = 238]:changement d'instrument
  regarder uCommonTypes pr les instruments
  64 AcousticGrandPiano
  ...
  237 = OpenTriangle

  [*]
  Comment sont calculer les nouvelles durees et nouveaux delay ???

  Prenons le cas d'une nouvelle durée (même raisonemment pr nvl delay )
  Tout repose sur la durée par defaut inscrite dans l'header ...

  Hein? Moi pas comprendre ! Explication :)

  Si Duree par defaut = 100 ms (exprimé en ms et duree par defaut = MAX 255 (normal limite byte))
  Si on met une valeur de 32 ca veut dire qu'on veut une nouvelle durée de 10

  --> Au fait on veut une nouvelle durée de 10 * durée par defaut 

  *)

  TMain = class(TForm)
    groupImage: TGroupBox;
    Image1: TImage;
    btCharger: TButton;
    labTailleImg: TLabel;
    labTailleMaxTab: TLabel;
    GroupSong: TGroupBox;
    btSaveBMPSong: TButton;
    GroupHeaderSong: TGroupBox;
    OpenPictureDialog1: TOpenPictureDialog;
    SaveDialog1: TSaveDialog;
    spinDefaultDuration: TSpinEdit;
    spinDefaultOctave: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    listNote: TListBox;
    Label5: TLabel;
    spinDefaultDelay: TSpinEdit;
    Label6: TLabel;
    comboInstruDefault: TComboBox;
    Label3: TLabel;
    GroupBox1: TGroupBox;
    Label7: TLabel;
    GroupInstru: TGroupBox;
    Label8: TLabel;
    comboNewInstru: TComboBox;
    btPlay: TButton;
    LabTypeBmp: TLabel;
    GroupBox16: TGroupBox;
    btNoteC: TButton;
    btNoteCs: TButton;
    btNoteD: TButton;
    btNoteDs: TButton;
    btNoteG: TButton;
    btNoteFc: TButton;
    btNoteF: TButton;
    btNoteE: TButton;
    btNoteGc: TButton;
    btNoteA: TButton;
    btNoteAc: TButton;
    btNoteB: TButton;
    panOct: TPanel;
    trackNewOct: TTrackBar;
    Label9: TLabel;
    edtPartition: TEdit;
    Label4: TLabel;
    Label10: TLabel;
    trackNewDuree: TTrackBar;
    panDuree: TPanel;
    trackNewDelay: TTrackBar;
    panDelay: TPanel;
    SaveDialogSong: TSaveDialog;
    OpenDialogSong: TOpenDialog;
    btSaveSong: TButton;
    btLoadSong: TButton;
    procedure btSaveBMPSongClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btChargerClick(Sender: TObject);
    procedure btPlayClick(Sender: TObject);
    procedure AjoutNote(Sender: TObject);
    procedure trackNewOctChange(Sender: TObject);
    procedure comboNewInstruChange(Sender: TObject);
    procedure trackNewDelayChange(Sender: TObject);
    procedure trackNewDureeChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btLoadSongClick(Sender: TObject);
    procedure btSaveSongClick(Sender: TObject);
  private
    fSong : TSong;
    Octave,SaveOctave : byte;
    Instrument , SaveInstrument : integer;
    Delay,SaveDelay : integer;
    Duree,SaveDuree : integer;
    Player : TMidiGen;
  public
    procedure PlaySong(ASong:TSong);
    // cette fonction est "intelligente" ; elle reconnait grace a l'ID present
    // dans le Header si le fichier est un bête fichier Bitmap
    // ou si c'est un fichier BMP_Song
    // à nous apres d'en faire bonne usage ;)
    function TestBmp(Bmp:TBitmap):TypeBmp;
    function LoadBMPSong(Bmp : TBitmap;pSong : pTSong):boolean;

    function SaveBMPSong(FileName : TFileName ; Bmp : TBitmap ; ASong : TSong):TypeErreurEng;
    procedure InitializeBmp(Bmp : TBitmap);

    procedure MAJHeader;
  
  end;
var
  Main: TMain;

implementation

{$R *.dfm}
procedure TMain.MAJHeader;
begin
  with fSong.Header do begin
    ID[0]:=ID1;
    ID[1]:=ID2;
    ID[2]:=ID3;
    ID[3]:=ID4;
    OctaveDefault:=spinDefaultOctave.Value;
    DelayDefault:=spinDefaultDelay.Value;
    DurationDefault:= spinDefaultDuration.Value;
    InstrumentDefault:=comboInstruDefault.ItemIndex;
  end;
  Octave :=spinDefaultOctave.Value;
  SaveOctave := Octave;

  Instrument:= comboInstruDefault.ItemIndex;
  SaveInstrument:=Instrument;

  Delay:= 1;
  SaveDelay :=Delay;

  Duree:=1;
  SaveDuree :=Duree;

end;

procedure TMain.PlaySong(ASong:Tsong);
var
  partition : String;
  value : byte;
  note : String;
  delay : integer;
  octave : integer;
  i : integer;
  Duration,len : integer;
  Instrument : byte;
begin
  // on chope les données utiles
  with ASong.Header do begin
    Duration := DurationDefault;
    delay := DelayDefault;
    Octave := OctaveDefault;
    Instrument :=InstrumentDefault;
  end;
  // Mise a blanc de la "partition"
  partition:='';

  len := Length(ASong.TabNote);

  for i:=0 to len do begin
    value := ASong.TabNote[i];
    case value  of
     DNOTE..FNOTE : note:=TabNotes[value];

     // Configuration : on configure et on passe à la valeur suivante
     // grâce au continue
     DOCTAVE..FOCTAVE : begin Octave:=value-DOCTAVE; continue; end;

     DDUREE..FDUREE : begin Duration:=(value-DDUREE)*ASong.Header.DurationDefault; continue; end;

     DDELAY..FDELAY : begin Delay:=(value-DDELAY)*ASong.Header.DelayDefault; continue; end;

     DINSTRUMENT..FINSTRUMENT: begin Instrument:=(value-DINSTRUMENT); continue; end;
    end;

    if (value>=DNOTE)then
      if(value<=FNOTE)then partition := partition + Format('I%d,%d;%s%d;%d,',[Instrument,delay,note,octave,Duration]);
  end;

  partition[Length(partition)]:=' ';
  edtPartition.Text:=partition;
  Player.PlayString(partition);
end;


function TMain.TestBmp(Bmp:TBitmap):TypeBmp;
var
  pPix : pRGBQuad;
  x : integer;
  TestID : array [0..4]of byte;
begin
  result:=bmpNormal;
  // Premier Test très rapide , si le Bitmap n'est pas un 32bits , ce n'est deja pas un BMPSong !
  if Bmp.PixelFormat = pf32bit then begin
  // ici, peut être que le bitmap cache un son (pas encore sûr ! )
    
    pPix := Bmp.ScanLine[Bmp.Height-1];
    // lecture de l'ID du fichier (donc lecture des 4 premiers bytes reservés )
    for x := 0 to Length(TestID) do begin
      TestID[x]:=pPix^.rgbReserved;
      inc(pPix);
    end;
    // on verifie si les infos sont correctes
    // bourrin aussi comme méthode !
    if( ((TestID[0]=ID1) and (TestID[1]=ID2))
    and (TestID[2]=ID3) and (TestID[3]=ID4)) then result:=bmpSong;
  end else
    result:=bmpNormal;
end;

// Charge un BMP et initialize ts les rgbReserved FIN_SONG
// FIN_SONG = fin enregistrement
// Prq mettre ts les byte reserve à FIN_SONG ?
// plus tard vous comprendrez
procedure TMain.InitializeBmp(Bmp : TBitmap);
var
  pPix : pRGBQuad;
  x : integer;
begin
  Bmp.PixelFormat := pf32bit;
  pPix := Bmp.ScanLine[Bmp.Height-1];

  for x := 0 to (Bmp.Width*Bmp.Height)-1 do
  begin
    pPix^.rgbReserved:=FIN_SONG;
    inc(pPix);
  end;
end;

function TMain.LoadBMPSong(Bmp : TBitmap;pSong : pTSong):boolean;
var
  pPix : pRGBQuad;
  TempTab : array of byte;
  CptNote : integer;
  x : integer;
begin
  result:=false;

  if Bmp.PixelFormat=pf32Bit then begin
    pPix := Bmp.ScanLine[Bmp.Height-1];

    //  on recupère le Header
    with pSong^.Header do begin
      ID[0]:=pPix^.rgbReserved;
      inc(pPix);
      ID[1]:=pPix^.rgbReserved;
      inc(pPix);
      ID[2]:=pPix^.rgbReserved;
      inc(pPix);
      ID[3]:=pPix^.rgbReserved;
      inc(pPix);
      InstrumentDefault:=pPix^.rgbReserved;
      inc(pPix);
      DelayDefault:=pPix^.rgbReserved;
      inc(pPix);
      DurationDefault:=pPix^.rgbReserved;
      inc(pPix);
      OctaveDefault:=pPix^.rgbReserved;
      inc(pPix);
    end;

    (*
    on parcours ts les bytes rgbReserved tant qu'il ne sont pas = a FIN_SONG
    On comprend mieux ici l'utilité d'initialisé le BMP normal
    et de remplir ts ces rgbReserved à FIN_SONG ...
    vu que la taille est indefinie , on reserve un tableau temporaire de
    taille MAX % à l'image , cad Width*Height - Taille Header

    *)
    // Ne pas Oublier d'initialiser !
    //sert à compter les note et a allouer apres la mémoire necessaire  pour fSong.TabNote
    CptNote:=0;

    //Alocation mémoire temporaire
    SetLength(TempTab,Bmp.Height*Bmp.Width);

    while (pPix^.rgbReserved<>FIN_SONG) do begin
      TempTab[CptNote]:=pPix^.rgbReserved;
      CptNote:=CptNote+1;
      // on passe au suivant ...
      inc(pPix);
    end;
    // on alloue la place pr le tableau pSong
    SetLength(pSong^.TabNote,CptNote-1);
    // on le recopie
    for x:=0 to cptNote-1 do
      pSong^.TabNote[x]:=TempTab[x];
    // et on libère l'autre
    SetLength(TempTab,0);
    result:=true;
  end;
end;


function TMain.SaveBMPSong(FileName : TFileName ; Bmp : TBitmap ; ASong : TSong):TypeErreurEng;
var
  pPix : pRGBQuad;
  x : integer;
begin
  // on teste si le bitmap est valide
  if Bmp = nil then begin
    result:=bmpNonValide;
    exit;
  end;

  // on met le bitmap en 32 bit pour profiter du byte " rgbReserved"
  Bmp.PixelFormat := pf32bit;

  // On teste ici si le son qu'on veut enregistrer n'est pas trop grand % au Bitmap
  // si le nombre de cellules du tableau > nombre de pixels de l'image
  // en gros même pour une petite image (genre 25x25) , on peut se faire une
  // petite mélodie ... :)

  if (sizeof(ASong))>Bmp.Width*Bmp.Height then begin
    result:=bmpTooSmall;
    exit;
  end;
  
  // un seul appel a Scanline , rien que pour Cari ^^
  pPix := Bmp.ScanLine[Bmp.Height-1];

  // enregistrement de l'Header
  // y'a surement moyen de faire mieux , un peu barbare comme méthode ...
  // j'aime pas :(
  with fSong.Header do begin
    // id
    pPix^.rgbReserved:=id[0];
    inc(pPix);
    pPix^.rgbReserved:=id[1];
    inc(pPix);
    pPix^.rgbReserved:=id[2];
    inc(pPix);
    pPix^.rgbReserved:=id[3];
    inc(pPix);
    // infos sur la musique
    pPix^.rgbReserved:=InstrumentDefault;
    inc(pPix);
    pPix^.rgbReserved:=DelayDefault;
    inc(pPix);
    pPix^.rgbReserved:=DurationDefault;
    inc(pPix);
    pPix^.rgbReserved:=OctaveDefault;
    inc(pPix);
  end;
  // on commence à la première cellule du tableau et
  // on continue jusque la fin , c-a-d sa longueur
  // utilise Length car fSong.TabNote est un tableau dynamique
  for x := 0 to Length(fSong.TabNote) do
  begin
    // ecriture des notes dans le byte reservé
    pPix^.rgbReserved:=fSong.TabNote[x];
    inc(pPix);
  end;
  // on sauve notre bitmap 
  Bmp.SaveToFile(FileName+'.bmp');
  result:=OK;
end;

procedure TMain.FormCreate(Sender: TObject);
var
  i : integer;
begin
  //Creation dynamique de TMidiGen pour les faineant
  // qui veulent pas l'installer
  Player := TMidiGen.Create(self);

  OpenPictureDialog1.InitialDir:=Application.ExeName;
  SaveDialog1.InitialDir:=Application.ExeName;

  // on rempli le comboBox instruments
  for i:=0 to LASTINSTRUMENT do begin
    comboInstruDefault.Items.Add(Instruments[i]);
    comboNewInstru.Items.Add(Instruments[i]);
  end;
  comboInstruDefault.ItemIndex:=0;
  comboNewInstru.ItemIndex:=0;

  MAJHeader;
  trackNewOct.Position:=Octave;
  trackNewDelay.Position:=delay;
  trackNewDuree.Position:=Duree;
end;


procedure TMain.btSaveBMPSongClick(Sender: TObject);
var
  i : integer;
  msg : String;
begin
  if(SaveDialog1.Execute) then begin
    // met à jour le Header avant d'enregistrer
    MAJHeader;
    // on calcule la longueur du tableau
    SetLength(fSong.TabNote,ListNote.Count-1);
    // on le rempli ... un jeu d'enfant :)
    for i:=0 to ListNote.Count-1 do
      fSong.TabNote[i]:= StrToInt(ListNote.Items.Strings[i]);

    // on lance la procedure pour mettre ts ca dans notre petit BMP
    // les erreurs c'etait juste pour m'amuser ;)

    case SaveBMPSong(SaveDialog1.FileName,Image1.Picture.Bitmap,fSong) of
      bmpNonValide :msg:='Bitmap non valide !';
      bmpTooSmall : msg:='Bitmap trop petit !';
      OK : msg:='Enregistrement réalisé avec succès';
    end;
      MessageBox(Handle,PChar(msg),'Info Sauvegarde',MB_OK);
  end;
end;

procedure TMain.btChargerClick(Sender: TObject);
var
  lx,ly,x : integer;
begin
// on fait differentes choses si c'est un bmp normal ou un bmp song
// Mais il y a une chose commune , on charge le Bitmap !
  if(OpenPictureDialog1.Execute)then begin
    Image1.Picture.Bitmap.LoadFromFile(OpenPictureDialog1.FileName);

    // voila notre fonction intelligente ;)
    case TestBmp(Image1.Picture.Bitmap) of
    // dans le cas d'une image normal
    // on initialize;
      bmpNormal :
      begin
        SetLength(fSong.TabNote,0);
        ListNote.Clear;
        LabTypeBmp.Caption:='Bmp " Normal " ';
        InitializeBmp(image1.Picture.Bitmap);
      end;
      // on charge la musique
      bmpSong :
      begin
        SetLength(fSong.TabNote,0);
        if(LoadBMPSong(Image1.Picture.Bitmap,@fSong))then begin
          LabTypeBmp.Caption:='Bmp Song';
          // on change les valeurs de l'header Mais dans la fiche
          with fSong.Header do begin
            spinDefaultDuration.Value:=DurationDefault;
            spinDefaultDelay.Value := DelayDefault;
            spinDefaultOctave.Value := OctaveDefault;
            comboInstruDefault.ItemIndex := InstrumentDefault;
          end;
          // on remplit la ListBox ...
          ListNote.Clear;
          for x:=0 to Length(fSong.TabNote) do begin
            ListNote.Items.Add(Format('%d',[fSong.TabNote[x]]));
          end;
        end;
      end;
    end;
    lx:=Image1.Picture.Bitmap.Width;
    ly:=Image1.Picture.Bitmap.Height;
    labTailleImg.Caption := Format('Taille X : %d ; Taille Y : %d',[lx,ly]);
    labTailleMaxTab.Caption := Format('Nombre de Notes Maximum = %d',[(lx*ly)-sizeof(THeaderSong)]);
  end
end;

procedure TMain.btPlayClick(Sender: TObject);
var
  i:integer;
  len : integer;
begin
  len:=ListNote.Items.Count-1;
  if(len = -1) then exit;

  MAJHeader;
  //Allocation de mémoire
  SetLength(fSong.TabNote,len);
  // copie des données dans le tableau
  for i:=0 to len  do
    fSong.TabNote[i]:= StrToInt(ListNote.Items.Strings[i]);

  PlaySong(fSong);
  
end;

procedure TMain.AjoutNote(Sender: TObject);
var
  Note : byte;
begin
  // si l'octave à changé
  if (Octave <>SaveOctave) then begin
    ListNote.Items.Add(Format('%d',[Octave+DOCTAVE]));
    SaveOctave:=Octave;
  end;
  // idem ...
  if(Instrument<>SaveInstrument) then begin
    ListNote.Items.Add(Format('%d',[Instrument+DINSTRUMENT]));
    SaveInstrument:=Instrument;
  end;

  if(Delay<>SaveDelay) then begin
    ListNote.Items.Add(Format('%d',[Delay+DDELAY]));
    SaveDelay:=Delay;
  end;

  if(Duree<>SaveDuree) then begin
    ListNote.Items.Add(Format('%d',[Duree+DDUREE]));
    SaveDuree:=Duree;
  end;
  
  Note := TButton(Sender).Tag;
  ListNote.Items.Add(Format('%d',[Note]));
end;

procedure TMain.trackNewOctChange(Sender: TObject);
begin
  panOct.Caption := Format('%d',[trackNewOct.Position]);
  Octave :=trackNewOct.Position;
end;

procedure TMain.comboNewInstruChange(Sender: TObject);
begin
  Instrument:= comboNewInstru.ItemIndex;
end;

procedure TMain.trackNewDelayChange(Sender: TObject);
begin
  panDelay.Caption := Format('%d',[trackNewDelay.Position]);
  Delay:=trackNewDelay.Position;
end;

procedure TMain.trackNewDureeChange(Sender: TObject);
begin
  panDuree.Caption := Format('%d',[trackNewDuree.Position]);
  Duree:=trackNewDuree.Position;
end;

procedure TMain.FormDestroy(Sender: TObject);
begin
  Player.Free;
end;

procedure TMain.btLoadSongClick(Sender: TObject);
var
  i:integer;
begin
  if(OpenDialogSong.Execute) then begin

    listNote.Items.LoadFromFile(OpenDialogSong.FileName);
    // les 4 premiers dans l'ordre : durée default , delay default , octave default, instrument default
    // il faudrat apres les retirer de la listBox
    spinDefaultDuration.Value:=StrToInt(listNote.Items.Strings[0]);
    spinDefaultDelay.Value:=StrToInt(listNote.Items.Strings[1]);
    spinDefaultOctave.Value:=StrToInt(listNote.Items.Strings[2]);
    comboInstruDefault.ItemIndex:=StrToInt(listNote.Items.Strings[3]);
    for i:=0 to 3 do
      listNote.Items.Delete(0);
  end;

end;

procedure TMain.btSaveSongClick(Sender: TObject);
begin
  if(SaveDialogSong.Execute) then begin
    // les 4 premiers dans l'ordre : durée default , delay default , octave default, instrument default
    ListNote.Items.Insert(0,IntToStr(comboInstruDefault.ItemIndex));
    ListNote.Items.Insert(0,IntToStr(spinDefaultOctave.Value));
    ListNote.Items.Insert(0,IntToStr(spinDefaultDelay.Value));
    ListNote.Items.Insert(0,IntToStr(spinDefaultDuration.Value));
    ListNote.Items.SaveToFile(SaveDialogSong.FileName+'.ltn');
    ListNote.Items.Clear;
  end;

end;

end.
