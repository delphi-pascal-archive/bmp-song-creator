object Main: TMain
  Left = 238
  Top = 129
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Bmp Song Creator v1.0'
  ClientHeight = 785
  ClientWidth = 1025
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 120
  TextHeight = 16
  object groupImage: TGroupBox
    Left = 8
    Top = 1
    Width = 543
    Height = 740
    Caption = ' Image '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Image1: TImage
      Left = 10
      Top = 69
      Width = 523
      Height = 533
      Proportional = True
      Stretch = True
    end
    object labTailleImg: TLabel
      Left = 22
      Top = 662
      Width = 75
      Height = 16
      Caption = 'labTailleImg'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object labTailleMaxTab: TLabel
      Left = 22
      Top = 682
      Width = 103
      Height = 16
      Caption = 'labTailleMaxTab'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LabTypeBmp: TLabel
      Left = 22
      Top = 642
      Width = 83
      Height = 16
      Caption = 'LabTypeBmp'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object btCharger: TButton
      Left = 10
      Top = 30
      Width = 523
      Height = 30
      Caption = 'Open image'
      TabOrder = 0
      WordWrap = True
      OnClick = btChargerClick
    end
  end
  object GroupSong: TGroupBox
    Left = 559
    Top = 1
    Width = 458
    Height = 740
    Caption = ' Song '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label3: TLabel
      Left = 304
      Top = 215
      Width = 70
      Height = 16
      Caption = 'Tab Notes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 10
      Top = 662
      Width = 102
      Height = 16
      Caption = 'Partition generee'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object GroupHeaderSong: TGroupBox
      Left = 10
      Top = 47
      Width = 439
      Height = 159
      Caption = ' Header '
      TabOrder = 0
      object Label1: TLabel
        Left = 10
        Top = 20
        Width = 199
        Height = 16
        Caption = 'Duree par defaut (max 255) en ms'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 10
        Top = 89
        Width = 137
        Height = 16
        Caption = 'Octave par Defaut (1-9)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 226
        Top = 20
        Width = 198
        Height = 16
        Caption = 'Delay par defaut (max 255) en ms'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 226
        Top = 89
        Width = 132
        Height = 16
        Caption = 'Instruments par Defaut'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object spinDefaultDuration: TSpinEdit
        Left = 10
        Top = 49
        Width = 149
        Height = 22
        MaxValue = 255
        MinValue = 1
        TabOrder = 0
        Value = 30
      end
      object spinDefaultOctave: TSpinEdit
        Left = 10
        Top = 118
        Width = 149
        Height = 22
        MaxValue = 10
        MinValue = 0
        TabOrder = 1
        Value = 4
      end
      object spinDefaultDelay: TSpinEdit
        Left = 226
        Top = 49
        Width = 149
        Height = 22
        MaxValue = 255
        MinValue = 1
        TabOrder = 2
        Value = 10
      end
      object comboInstruDefault: TComboBox
        Left = 225
        Top = 118
        Width = 152
        Height = 24
        ItemHeight = 16
        TabOrder = 3
      end
    end
    object listNote: TListBox
      Left = 288
      Top = 234
      Width = 113
      Height = 383
      ItemHeight = 16
      TabOrder = 1
    end
    object GroupBox1: TGroupBox
      Left = 10
      Top = 370
      Width = 228
      Height = 169
      Caption = ' Changer Duree ou Delay '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object Label7: TLabel
        Left = 10
        Top = 20
        Width = 37
        Height = 16
        Caption = 'Duree'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 10
        Top = 89
        Width = 36
        Height = 16
        Caption = 'Delay'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object trackNewDuree: TTrackBar
        Left = 20
        Top = 49
        Width = 99
        Height = 31
        Max = 20
        Min = 1
        Frequency = 5
        Position = 1
        TabOrder = 0
        ThumbLength = 10
        OnChange = trackNewDureeChange
      end
      object panDuree: TPanel
        Left = 130
        Top = 43
        Width = 23
        Height = 23
        Hint = 'Octave'
        BevelInner = bvLowered
        BevelOuter = bvLowered
        Caption = '1'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
      object trackNewDelay: TTrackBar
        Left = 20
        Top = 118
        Width = 99
        Height = 31
        LineSize = 0
        Max = 20
        Frequency = 5
        Position = 1
        TabOrder = 2
        ThumbLength = 10
        OnChange = trackNewDelayChange
      end
      object panDelay: TPanel
        Left = 130
        Top = 112
        Width = 23
        Height = 23
        Hint = 'Octave'
        BevelInner = bvLowered
        BevelOuter = bvLowered
        Caption = '1'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
      end
    end
    object GroupInstru: TGroupBox
      Left = 10
      Top = 548
      Width = 228
      Height = 99
      Caption = ' Instruments '
      TabOrder = 3
      object Label8: TLabel
        Left = 10
        Top = 30
        Width = 123
        Height = 16
        Caption = 'changer d'#39'instrument'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object comboNewInstru: TComboBox
        Left = 10
        Top = 59
        Width = 208
        Height = 24
        ItemHeight = 16
        TabOrder = 0
        Text = 'comboNewInstru'
        OnChange = comboNewInstruChange
      end
    end
    object btPlay: TButton
      Left = 288
      Top = 624
      Width = 113
      Height = 25
      Caption = 'Play'
      TabOrder = 4
      OnClick = btPlayClick
    end
    object GroupBox16: TGroupBox
      Left = 10
      Top = 209
      Width = 228
      Height = 155
      Caption = ' Note && Octave '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      object Label9: TLabel
        Left = 24
        Top = 106
        Width = 49
        Height = 16
        Caption = 'Octave'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object btNoteC: TButton
        Left = 25
        Top = 27
        Width = 30
        Height = 23
        Caption = 'C'
        TabOrder = 0
        OnClick = AjoutNote
      end
      object btNoteCs: TButton
        Tag = 1
        Left = 55
        Top = 27
        Width = 31
        Height = 23
        Caption = 'C#'
        TabOrder = 1
        OnClick = AjoutNote
      end
      object btNoteD: TButton
        Tag = 2
        Left = 86
        Top = 27
        Width = 31
        Height = 23
        Caption = 'D'
        TabOrder = 2
        OnClick = AjoutNote
      end
      object btNoteDs: TButton
        Tag = 3
        Left = 117
        Top = 27
        Width = 31
        Height = 23
        Caption = 'D#'
        TabOrder = 3
        OnClick = AjoutNote
      end
      object btNoteG: TButton
        Tag = 7
        Left = 117
        Top = 50
        Width = 31
        Height = 24
        Caption = 'G'
        TabOrder = 4
        OnClick = AjoutNote
      end
      object btNoteFc: TButton
        Tag = 6
        Left = 86
        Top = 50
        Width = 31
        Height = 24
        Caption = 'F#'
        TabOrder = 5
        OnClick = AjoutNote
      end
      object btNoteF: TButton
        Tag = 5
        Left = 55
        Top = 50
        Width = 31
        Height = 24
        Caption = 'F'
        TabOrder = 6
        OnClick = AjoutNote
      end
      object btNoteE: TButton
        Tag = 4
        Left = 25
        Top = 50
        Width = 30
        Height = 24
        Caption = 'E'
        TabOrder = 7
        OnClick = AjoutNote
      end
      object btNoteGc: TButton
        Tag = 8
        Left = 25
        Top = 74
        Width = 30
        Height = 23
        Caption = 'G#'
        TabOrder = 8
        OnClick = AjoutNote
      end
      object btNoteA: TButton
        Tag = 9
        Left = 55
        Top = 74
        Width = 31
        Height = 23
        Caption = 'A'
        TabOrder = 9
        OnClick = AjoutNote
      end
      object btNoteAc: TButton
        Tag = 10
        Left = 86
        Top = 74
        Width = 31
        Height = 23
        Caption = 'A#'
        TabOrder = 10
        OnClick = AjoutNote
      end
      object btNoteB: TButton
        Tag = 11
        Left = 117
        Top = 74
        Width = 31
        Height = 23
        Caption = 'B'
        TabOrder = 11
        OnClick = AjoutNote
      end
      object panOct: TPanel
        Left = 130
        Top = 112
        Width = 23
        Height = 23
        Hint = 'Octave'
        BevelInner = bvLowered
        BevelOuter = bvLowered
        Caption = '4'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 12
      end
      object trackNewOct: TTrackBar
        Left = 22
        Top = 122
        Width = 100
        Height = 23
        Hint = 'Octave'
        ParentShowHint = False
        Position = 4
        ShowHint = True
        TabOrder = 13
        ThumbLength = 10
        OnChange = trackNewOctChange
      end
    end
    object edtPartition: TEdit
      Left = 10
      Top = 682
      Width = 439
      Height = 21
      TabOrder = 6
    end
    object btSaveSong: TButton
      Left = 10
      Top = 709
      Width = 439
      Height = 21
      Caption = 'Sauvegarder la musique'
      TabOrder = 7
      OnClick = btSaveSongClick
    end
    object btLoadSong: TButton
      Left = 10
      Top = 20
      Width = 439
      Height = 21
      Caption = 'Charger une musique'
      TabOrder = 8
      OnClick = btLoadSongClick
    end
  end
  object btSaveBMPSong: TButton
    Left = 8
    Top = 749
    Width = 1009
    Height = 28
    Caption = 'Save Bitmap Song'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btSaveBMPSongClick
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Left = 24
    Top = 104
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Left = 56
    Top = 104
  end
  object SaveDialogSong: TSaveDialog
    Filter = 'Fichier Liste Tab Note|*.ltn'
    Left = 56
    Top = 136
  end
  object OpenDialogSong: TOpenDialog
    Filter = 'Fichier Liste Tab Note|*.ltn'
    Left = 24
    Top = 136
  end
end
