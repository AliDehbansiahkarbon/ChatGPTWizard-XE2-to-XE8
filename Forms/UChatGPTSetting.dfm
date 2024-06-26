object Frm_Setting: TFrm_Setting
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Setting'
  ClientHeight = 451
  ClientWidth = 445
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 15
  object pgcSetting: TPageControl
    Left = 0
    Top = 0
    Width = 445
    Height = 405
    ActivePage = tsMainSetting
    Align = alClient
    TabOrder = 0
    OnChange = pgcSettingChange
    object tsMainSetting: TTabSheet
      Caption = 'Main Setting'
      object pnlMain: TPanel
        Left = 0
        Top = 0
        Width = 437
        Height = 375
        Align = alClient
        TabOrder = 0
        object grp_OpenAI: TGroupBox
          Left = 1
          Top = 1
          Width = 435
          Height = 160
          Align = alTop
          Caption = 'OpenAI preferences'
          TabOrder = 0
          object pnlOpenAI: TPanel
            AlignWithMargins = True
            Left = 5
            Top = 20
            Width = 425
            Height = 135
            Align = alClient
            BevelOuter = bvLowered
            TabOrder = 0
            object lbl_1: TLabel
              Left = 30
              Top = 18
              Width = 51
              Height = 15
              Caption = 'Base URL:'
            end
            object lbl_2: TLabel
              Left = 20
              Top = 46
              Width = 61
              Height = 15
              Caption = 'Access Key:'
            end
            object lbl_3: TLabel
              Left = 44
              Top = 75
              Width = 37
              Height = 15
              Caption = 'Model:'
            end
            object lbl_4: TLabel
              Left = 222
              Top = 75
              Width = 62
              Height = 15
              Caption = 'Max-Token:'
              Visible = False
            end
            object lbl_5: TLabel
              Left = 220
              Top = 140
              Width = 69
              Height = 15
              Caption = 'Temperature:'
              Visible = False
            end
            object edt_Url: TEdit
              Left = 89
              Top = 12
              Width = 318
              Height = 23
              TabOrder = 0
              Text = 'https://api.openai.com/v1/chat/completions'
              OnChange = edt_UrlChange
            end
            object edt_ApiKey: TEdit
              Left = 89
              Top = 42
              Width = 318
              Height = 23
              PasswordChar = '*'
              TabOrder = 1
              OnChange = edt_UrlChange
            end
            object edt_MaxToken: TEdit
              Left = 293
              Top = 73
              Width = 114
              Height = 23
              NumbersOnly = True
              TabOrder = 2
              Text = '2048'
              Visible = False
              OnChange = edt_UrlChange
            end
            object edt_Temperature: TEdit
              Left = 297
              Top = 136
              Width = 122
              Height = 23
              NumbersOnly = True
              TabOrder = 3
              Text = '0'
              Visible = False
              OnChange = edt_UrlChange
            end
            object cbbModel: TComboBox
              Left = 89
              Top = 72
              Width = 122
              Height = 23
              Style = csDropDownList
              TabOrder = 4
              OnChange = cbbModelChange
              Items.Strings = (
                'gpt-3.5-turbo'
                'gpt-3.5-turbo-16k'
                'gpt-4'
                'gpt-4-turbo'
                'gpt-4-turbo-preview')
            end
            object lbEdt_Timeout: TLabeledEdit
              Left = 126
              Top = 101
              Width = 28
              Height = 23
              Alignment = taCenter
              EditLabel.Width = 102
              EditLabel.Height = 15
              EditLabel.Caption = 'Request Timeout(s)'
              LabelPosition = lpLeft
              LabelSpacing = 5
              NumbersOnly = True
              TabOrder = 5
              Text = '20'
            end
            object chk_Offline: TCheckBox
              Left = 172
              Top = 105
              Width = 107
              Height = 17
              Caption = 'Ollama(Offline):'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 6
              OnClick = chk_OfflineClick
            end
            object edt_OfflineModel: TEdit
              Left = 286
              Top = 102
              Width = 121
              Height = 23
              TabOrder = 7
            end
          end
        end
        object pnlOther: TPanel
          Left = 1
          Top = 161
          Width = 435
          Height = 213
          Align = alClient
          TabOrder = 1
          object grp_Other: TGroupBox
            Left = 1
            Top = 1
            Width = 433
            Height = 92
            Align = alTop
            Caption = 'IDE && Other'
            TabOrder = 0
            object pnlIDE: TPanel
              AlignWithMargins = True
              Left = 5
              Top = 20
              Width = 423
              Height = 67
              Align = alClient
              BevelOuter = bvLowered
              TabOrder = 0
              object lbl_6: TLabel
                Left = 271
                Top = 17
                Width = 50
                Height = 15
                Caption = 'Identifier:'
              end
              object Edt_SourceIdentifier: TEdit
                Left = 327
                Top = 14
                Width = 54
                Height = 23
                Alignment = taCenter
                TabOrder = 0
                Text = 'cpt'
              end
              object chk_CodeFormatter: TCheckBox
                Left = 19
                Top = 17
                Width = 128
                Height = 17
                BiDiMode = bdLeftToRight
                Caption = 'Call Code Formatter'
                Checked = True
                ParentBiDiMode = False
                State = cbChecked
                TabOrder = 1
              end
              object chk_Rtl: TCheckBox
                Left = 162
                Top = 17
                Width = 97
                Height = 17
                Caption = 'Righ To Left'
                TabOrder = 2
              end
              object chk_AnimatedLetters: TCheckBox
                Left = 19
                Top = 40
                Width = 113
                Height = 17
                Caption = 'Animated Letters'
                Color = clBtnFace
                Ctl3D = True
                ParentColor = False
                ParentCtl3D = False
                TabOrder = 3
                OnClick = chk_AnimatedLettersClick
              end
            end
          end
        end
      end
    end
    object tsPreDefinedQuestions: TTabSheet
      Caption = 'PreDefined Questions'
      ImageIndex = 1
      object pnlPredefinedQ: TPanel
        Left = 0
        Top = 0
        Width = 437
        Height = 375
        Align = alClient
        TabOrder = 0
        object Btn_AddQuestion: TButton
          Left = 5
          Top = 11
          Width = 78
          Height = 27
          Caption = 'Add'
          TabOrder = 0
          OnClick = Btn_AddQuestionClick
        end
        object ScrollBox: TScrollBox
          AlignWithMargins = True
          Left = 4
          Top = 51
          Width = 429
          Height = 320
          Margins.Top = 50
          Align = alClient
          TabOrder = 1
          object GridPanelPredefinedQs: TGridPanel
            Left = 0
            Top = 0
            Width = 425
            Height = 0
            Align = alTop
            ColumnCollection = <
              item
                Value = 100.000000000000000000
              end>
            ControlCollection = <>
            RowCollection = <
              item
                Value = 50.000000000000000000
              end
              item
                Value = 50.000000000000000000
              end>
            TabOrder = 0
          end
        end
        object Btn_RemoveQuestion: TButton
          Left = 86
          Top = 11
          Width = 90
          Height = 27
          Caption = 'Remove latest'
          TabOrder = 2
          OnClick = Btn_RemoveQuestionClick
        end
      end
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 405
    Width = 445
    Height = 46
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      445
      46)
    object Btn_Default: TButton
      Left = 260
      Top = 9
      Width = 89
      Height = 28
      Anchors = [akRight, akBottom]
      Caption = 'Load Defaults'
      TabOrder = 0
      OnClick = Btn_DefaultClick
    end
    object Btn_Save: TButton
      Left = 351
      Top = 9
      Width = 89
      Height = 28
      Anchors = [akRight, akBottom]
      Caption = 'Save && Close'
      TabOrder = 1
      OnClick = Btn_SaveClick
    end
  end
end
