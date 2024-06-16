object Fram_Question: TFram_Question
  Left = 0
  Top = 0
  Width = 435
  Height = 433
  TabOrder = 0
  object pgcMain: TPageControl
    Left = 0
    Top = 0
    Width = 435
    Height = 399
    ActivePage = tsChatGPT
    Align = alClient
    MultiLine = True
    TabOrder = 0
    OnChange = pgcMainChange
    object tsChatGPT: TTabSheet
      Caption = 'ChatGPT'
      object pnlMain: TPanel
        Left = 0
        Top = 0
        Width = 427
        Height = 371
        Align = alClient
        ParentColor = True
        TabOrder = 0
        object pnlTop: TPanel
          Left = 1
          Top = 1
          Width = 425
          Height = 44
          Align = alTop
          TabOrder = 0
          object btnHelp: TSpeedButton
            Left = 400
            Top = 1
            Width = 24
            Height = 42
            Align = alRight
            Glyph.Data = {
              36090000424D3609000000000000360000002800000018000000180000000100
              2000000000000009000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000008000000170000001E00000022000000260000
              00270000001B0302022C000001270000001E0000002900000026000000230000
              001F000000180000000B00000000000000000000000000000000000000000000
              000000000000000000000000000C00000020000000290000012E000001310000
              002C30150A9D5B2913F0562612E61A0C066D0000002A000001320000012F0000
              002A000000220000001000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000001007
              0429662D15FF652D15FF662D15FF592712DF0000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000001409
              0431662D15FF652D15FF652D15FF5F2B14EE0301010600000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000100
              000245200DA5683013F7663013F42C1408690000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              00000000000031190A6A1F100645000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0001512A0BAB783D11FF723A0FF1170C03300000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000704
              010E7D410FFA804310FF804310FF422308840000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000503
              010A7E440CEF86490EFF86490EFF713E0CD70000000100000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000633708B38D4F0DFF8D4E0CFF8C4E0CFF613609AF02010104000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000190E022B90520AFA93540BFF93540BFF93540BFF704008C20704000C0000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              00000000000028170243925509F19A5A09FF9A5A09FF9A5909FF7B4707CB0704
              010C000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000020100032A1902420F0901170000
              000000000000000000001B10022A915506E5A15F08FFA15F08FFA05F08FF683D
              06A4000000000000000000000000000000000000000000000000000000000000
              00000000000000000000000000000704010B834F05C8A76407FF995D06EA140C
              011E000000000000000000000000180F01259A5D06EBA86507FFA86507FFA764
              07FF150D01200000000000000000000000000000000000000000000000000000
              00000000000000000000000000002D1D0340AF6C06FFAE6A05FFAE6A05FF5C38
              0487000000000000000000000000000000006A41049CAE6A05FFAE6A05FFAF6B
              05FF3420024B0000000000000000000000000000000000000000000000000000
              00000000000000000000000000001C120226BA7608FFB46F03FFB57004FFAA69
              04F02014022D000000000000000000000000925A04CEB57004FFB46F03FFB874
              06FF2D1D033D0000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000976309C6BE7905FFBB7401FFBB75
              02FFB37003F46B430291593801788B5703BDBB7502FFBB7502FFBC7602FFB676
              0AEF0905010C0000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000002316022DC6830DFAC47E04FFC179
              00FFC17A00FFC17A00FFC17A00FFC17A00FFC17900FFC27B01FFC9850CFF5035
              0567000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000002F1F023DB2780DDFC986
              0BFFC68005FFC47E02FFC47E02FFC57F04FFC88409FFCA880EFE6040077A0000
              0000000000000000000000000000000000000000000000000000000000000000
              00000000000000000000000000000000000000000000000000000804000B573A
              066E92620CB6AE760FD8B37A0FDF9E6B0EC5704B098C2215012C000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000001000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            OnClick = btnHelpClick
          end
          object Btn_Clipboard: TButton
            Left = 121
            Top = 8
            Width = 137
            Height = 27
            Caption = 'Copy to Clipboard'
            TabOrder = 1
            WordWrap = True
            OnClick = Btn_ClipboardClick
          end
          object Btn_Ask: TButton
            Left = 40
            Top = 8
            Width = 74
            Height = 27
            Hint = 'Ctrl + Enter'
            Caption = 'Ask'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = Btn_AskClick
          end
          object Btn_Clear: TButton
            Left = 271
            Top = 8
            Width = 78
            Height = 27
            Caption = 'Clear All'
            DropDownMenu = pmClear
            Style = bsSplitButton
            TabOrder = 2
            OnClick = Btn_ClearClick
          end
        end
        object pnlCenter: TPanel
          Left = 1
          Top = 45
          Width = 425
          Height = 325
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object splitter: TSplitter
            Left = 0
            Top = 114
            Width = 425
            Height = 3
            Cursor = crVSplit
            Align = alTop
            ExplicitLeft = 8
            ExplicitTop = 156
            ExplicitWidth = 433
          end
          object pnlAnswer: TPanel
            Left = 0
            Top = 117
            Width = 425
            Height = 208
            Align = alClient
            TabOrder = 0
            object pgcAnswers: TPageControl
              Left = 1
              Top = 1
              Width = 423
              Height = 206
              ActivePage = tsChatGPTAnswer
              Align = alClient
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindow
              Font.Height = -11
              Font.Name = 'Segoe UI'
              Font.Style = []
              HotTrack = True
              ParentFont = False
              TabOrder = 0
              OnChange = pgcAnswersChange
              object tsChatGPTAnswer: TTabSheet
                Caption = 'ChatGPT'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -8
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentFont = False
                object mmoAnswer: TMemo
                  Left = 0
                  Top = 0
                  Width = 415
                  Height = 178
                  Align = alClient
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Consolas'
                  Font.Style = []
                  ParentFont = False
                  ReadOnly = True
                  ScrollBars = ssVertical
                  TabOrder = 0
                end
              end
            end
          end
          object pnlQuestion: TPanel
            Left = 0
            Top = 0
            Width = 425
            Height = 114
            Align = alTop
            TabOrder = 1
            DesignSize = (
              425
              114)
            object Lbl_Question: TLabel
              Left = 7
              Top = 3
              Width = 53
              Height = 15
              Caption = 'Question:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object mmoQuestion: TMemo
              Left = 5
              Top = 20
              Width = 415
              Height = 89
              Hint = 'Type a question and press Ctrl + Enter'
              Anchors = [akLeft, akTop, akRight, akBottom]
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
              ParentShowHint = False
              ScrollBars = ssVertical
              ShowHint = True
              TabOrder = 0
              OnKeyDown = mmoQuestionKeyDown
            end
          end
        end
      end
    end
    object tsClassView: TTabSheet
      Caption = 'Class View'
      ImageIndex = 1
      object splClassView: TSplitter
        Left = 0
        Top = 137
        Width = 427
        Height = 3
        Cursor = crVSplit
        Align = alTop
        ExplicitTop = 113
        ExplicitWidth = 241
      end
      object pnlClasses: TPanel
        Left = 0
        Top = 0
        Width = 427
        Height = 137
        Align = alTop
        TabOrder = 0
      end
      object pnlPredefinedCmdAnswer: TPanel
        Left = 0
        Top = 140
        Width = 427
        Height = 231
        Align = alClient
        TabOrder = 1
        object splClassViewResult: TSplitter
          Left = 238
          Top = 1
          Height = 229
          Align = alRight
          Visible = False
          ExplicitLeft = 216
          ExplicitTop = 64
          ExplicitHeight = 100
        end
        object mmoClassViewDetail: TMemo
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 231
          Height = 223
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
          OnDblClick = mmoClassViewDetailDblClick
        end
        object mmoClassViewResult: TMemo
          Left = 241
          Top = 1
          Width = 185
          Height = 229
          Align = alRight
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 1
          Visible = False
          OnDblClick = mmoClassViewResultDblClick
        end
      end
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 399
    Width = 435
    Height = 34
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      435
      34)
    object chk_AutoCopy: TCheckBox
      AlignWithMargins = True
      Left = 294
      Top = 6
      Width = 132
      Height = 20
      Margins.Right = 4
      Anchors = [akRight, akBottom]
      Caption = 'Auto copy to clipboard'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
  end
  object pmMemo: TPopupMenu
    Left = 56
    Top = 232
    object CopytoClipboard1: TMenuItem
      Caption = 'Copy to Clipboard'
      OnClick = CopytoClipboard1Click
    end
  end
  object pmClassOperations: TPopupMenu
    OnPopup = pmClassOperationsPopup
    Left = 56
    Top = 304
  end
  object pmClear: TPopupMenu
    Left = 160
    Top = 240
    object ClearQuestion1: TMenuItem
      Caption = 'Clear Question'
      OnClick = ClearQuestion1Click
    end
    object ClearAnswer1: TMenuItem
      Caption = 'Clear Answers'
      OnClick = ClearAnswer1Click
    end
  end
end
