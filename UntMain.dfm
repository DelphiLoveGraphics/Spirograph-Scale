object FrmMain: TFrmMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Circle Orbit'
  ClientHeight = 515
  ClientWidth = 598
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 84
    Top = 0
    Width = 514
    Height = 515
    Align = alClient
    TabOrder = 0
    object ImgMain: TImage
      Left = 3
      Top = 3
      Width = 500
      Height = 500
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 84
    Height = 515
    Align = alLeft
    TabOrder = 1
    object Label1: TLabel
      Left = 2
      Top = 54
      Width = 56
      Height = 13
      Caption = 'Scale [1..9]'
    end
    object SPEScale: TSpinEdit
      Left = 1
      Top = 68
      Width = 77
      Height = 22
      MaxLength = 1
      MaxValue = 9
      MinValue = 1
      TabOrder = 0
      Value = 8
    end
    object BtnDraw: TButton
      Left = 1
      Top = 112
      Width = 81
      Height = 37
      Caption = 'Draw'
      TabOrder = 1
      OnClick = BtnDrawClick
    end
  end
end
