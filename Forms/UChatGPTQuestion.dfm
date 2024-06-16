object FrmChatGPT: TFrmChatGPT
  Left = 0
  Top = 0
  BiDiMode = bdLeftToRight
  Caption = 'ChatGPT'
  ClientHeight = 485
  ClientWidth = 421
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  inline Fram_Question: TFram_Question
    Left = 0
    Top = 0
    Width = 421
    Height = 485
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 421
    ExplicitHeight = 485
    inherited pgcMain: TPageControl
      Width = 421
      Height = 451
      ExplicitWidth = 421
      ExplicitHeight = 451
      inherited tsChatGPT: TTabSheet
        ExplicitTop = 26
        ExplicitWidth = 413
        ExplicitHeight = 421
        inherited pnlMain: TPanel
          Width = 413
          Height = 421
          ExplicitWidth = 413
          ExplicitHeight = 421
          inherited pnlTop: TPanel
            Width = 411
            ExplicitWidth = 411
            inherited btnHelp: TSpeedButton
              Left = 386
              ExplicitLeft = 390
            end
          end
          inherited pnlCenter: TPanel
            Width = 411
            Height = 375
            ExplicitWidth = 411
            ExplicitHeight = 375
            inherited splitter: TSplitter
              Width = 411
              ExplicitWidth = 419
            end
            inherited pnlAnswer: TPanel
              Width = 411
              Height = 258
              ExplicitWidth = 411
              ExplicitHeight = 258
              inherited pgcAnswers: TPageControl
                Width = 409
                Height = 256
                ExplicitWidth = 409
                ExplicitHeight = 256
                inherited tsChatGPTAnswer: TTabSheet
                  ExplicitWidth = 401
                  ExplicitHeight = 228
                  inherited mmoAnswer: TMemo
                    Width = 401
                    Height = 228
                    ExplicitWidth = 401
                    ExplicitHeight = 228
                  end
                end
              end
            end
            inherited pnlQuestion: TPanel
              Width = 411
              ExplicitWidth = 411
              inherited mmoQuestion: TMemo
                Width = 411
                ExplicitWidth = 411
              end
            end
          end
        end
      end
      inherited tsClassView: TTabSheet
        inherited splClassView: TSplitter
          ExplicitWidth = 421
        end
      end
    end
    inherited pnlBottom: TPanel
      Top = 451
      Width = 421
      ExplicitTop = 451
      ExplicitWidth = 421
      inherited chk_AutoCopy: TCheckBox
        Left = 261
        ExplicitLeft = 261
      end
    end
  end
end
