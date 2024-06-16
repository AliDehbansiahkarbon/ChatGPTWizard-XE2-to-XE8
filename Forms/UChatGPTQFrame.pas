{***************************************************}
{                                                   }
{   This unit contains a frame that will be         }
{   used in dockable form.                          }
{   Auhtor: Ali Dehbansiahkarbon(adehban@gmail.com) }
{   GitHub: https://github.com/AliDehbansiahkarbon  }
{                                                   }
{***************************************************}
unit UChatGPTQFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Menus, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Clipbrd,
  UChatGPTThread, UChatGPTSetting, UChatGPTLexer, System.Generics.Collections,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Data.DB, System.DateUtils,System.StrUtils,
  UConsts, Vcl.ImgList, ShellApi;

type
  TOnClickProc = procedure(Sender: TObject) of object;
  TClassList = TObjectDictionary<string, TStringList>;

  TObDicHelper = class helper for TClassList
  public
    procedure FillTreeView(var ATree: TTreeView);
  end;

  TFram_Question = class(TFrame)
    pnlMain: TPanel;
    Lbl_Question: TLabel;
    pnlTop: TPanel;
    Btn_Clipboard: TButton;
    Btn_Ask: TButton;
    pmMemo: TPopupMenu;
    CopytoClipboard1: TMenuItem;
    Btn_Clear: TButton;
    chk_AutoCopy: TCheckBox;
    pnlQuestion: TPanel;
    pnlAnswer: TPanel;
    mmoQuestion: TMemo;
    pnlBottom: TPanel;
    mmoAnswer: TMemo;
    splitter: TSplitter;
    pnlCenter: TPanel;
    pgcMain: TPageControl;
    tsChatGPT: TTabSheet;
    tsClassView: TTabSheet;
    pmClassOperations: TPopupMenu;
    pnlClasses: TPanel;
    pnlPredefinedCmdAnswer: TPanel;
    splClassView: TSplitter;
    mmoClassViewDetail: TMemo;
    mmoClassViewResult: TMemo;
    splClassViewResult: TSplitter;
    pgcAnswers: TPageControl;
    tsChatGPTAnswer: TTabSheet;
    pmClear: TPopupMenu;
    ClearQuestion1: TMenuItem;
    ClearAnswer1: TMenuItem;
    btnHelp: TSpeedButton;
    procedure Btn_AskClick(Sender: TObject);
    procedure Btn_ClipboardClick(Sender: TObject);
    procedure CopytoClipboard1Click(Sender: TObject);
    procedure mmoQuestionKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Btn_ClearClick(Sender: TObject);
    procedure tvOnChange(Sender: TObject; Node: TTreeNode);
    procedure pmClassOperationsPopup(Sender: TObject);
    procedure pgcMainChange(Sender: TObject);
    procedure mmoClassViewDetailDblClick(Sender: TObject);
    procedure mmoClassViewResultDblClick(Sender: TObject);

    // Convert commands.
    procedure CSharpClick(Sender: TObject);
    procedure JavaClick(Sender: TObject);
    procedure PythonClick(Sender: TObject);
    procedure JavascriptClick(Sender: TObject);
    procedure CClick(Sender: TObject);
    procedure GoClick(Sender: TObject);
    procedure RustClick(Sender: TObject);
    procedure CPlusPlusClick(Sender: TObject);

    // Dynamic Commands.
    procedure ClassViewMenuItemClick(Sender: TObject);

    // Custom Command.
    procedure CustomCommandClick(Sender: TObject);
    procedure pgcAnswersChange(Sender: TObject);
    procedure ClearQuestion1Click(Sender: TObject);
    procedure ClearAnswer1Click(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    FChatGPTTrd: TExecutorTrd;
    FClassList: TClassList;
    FClassTreeView: TTreeView;
    FLastQuestion: string;
    FClassViewIsBusy: Boolean;

    procedure CopyToClipBoard;
    procedure CallThread(APrompt: string; AIsClassView: Boolean = False);
    function LowChar(AChar: Char): Char; inline;
    function FuzzyMatchStr(const APattern, AStr: string; AMatchedIndexes: TList; ACaseSensitive: Boolean): Boolean;
    procedure EnableUI(ATaskName: string);
    procedure ClearAnswers;
    function IslegacyModel: Boolean;
  public
    procedure InitialFrame;
    procedure InitialClassViewMenueItems(AClassList: TClassList);
    procedure ReloadClassList(AClassList: TClassList);
    procedure TerminateAll;

    procedure OnUpdateMessage(var Msg: TMessage); message WM_UPDATE_MESSAGE;
    procedure OnProgressMessage(var Msg: TMessage); message WM_PROGRESS_MESSAGE;

    property ClassViewIsBusy: Boolean read FClassViewIsBusy write FClassViewIsBusy;
  end;

implementation

{$R *.dfm}
procedure TFram_Question.btnHelpClick(Sender: TObject);
var
  LvUrl: string;
begin
  LvUrl := 'https://github.com/AliDehbansiahkarbon/ChatGPTWizardLegacy';
  ShellExecute(0, nil, PChar(LvUrl), nil, nil, SW_SHOWNORMAL);
end;

procedure TFram_Question.Btn_AskClick(Sender: TObject);
begin
  if IslegacyModel then
  begin
    ShowMessage('You are trying to use the model"' + TSingletonSettingObj.Instance.Model + '" which is deprecated, you can change the Model in setting form.');
    Exit;
  end;
  
  if mmoQuestion.Lines.Text.Trim.IsEmpty then
  begin
    ShowMessage('Really?!😂' + #13 + 'You need to type a question first.');
    if mmoQuestion.CanFocus then
      mmoQuestion.SetFocus;

    Exit;
  end;
  mmoAnswer.Lines.Clear;
  CallThread(mmoQuestion.Lines.Text);
end;

procedure TFram_Question.Btn_ClearClick(Sender: TObject);
begin
  mmoQuestion.Lines.Clear;
  mmoAnswer.Lines.Clear;
end;

procedure TFram_Question.Btn_ClipboardClick(Sender: TObject);
begin
  CopyToClipBoard;
end;

procedure TFram_Question.CSharpClick(Sender: TObject);
begin
  if FClassTreeView.Selected <> FClassTreeView.TopItem then
  begin
    FLastQuestion := 'Convert this Delphi Code to C# code: ' + #13 + FClassList.Items[FClassTreeView.Selected.Text].Text;
    mmoClassViewResult.Lines.Clear;
    CallThread(FLastQuestion, True);
  end;
end;

procedure TFram_Question.CClick(Sender: TObject);
begin
  if FClassTreeView.Selected <> FClassTreeView.TopItem then
  begin
    FLastQuestion := 'Convert this Delphi Code to C code: ' + #13 + FClassList.Items[FClassTreeView.Selected.Text].Text;
    mmoClassViewResult.Lines.Clear;
    CallThread(FLastQuestion, True);
  end;
end;

procedure TFram_Question.CPlusPlusClick(Sender: TObject);
begin
  if FClassTreeView.Selected <> FClassTreeView.TopItem then
  begin
    FLastQuestion := 'Convert this Delphi Code to C++ code: ' + #13 + FClassList.Items[FClassTreeView.Selected.Text].Text;
    mmoClassViewResult.Lines.Clear;
    CallThread(FLastQuestion, True);
  end;
end;

procedure TFram_Question.CallThread(APrompt: string; AIsClassView: Boolean);
var
  LvChatGPTApiKey: string;
  LvChatGPTBaseUrl: string;

  LvModel: string;
  LvQuestion: string;
  LvMaxToken: Integer;
  LvTemperature: Integer;

  LvAnimatedLetters: Boolean;
  LvTimeOut: Integer;
  LvIsOffline: Boolean;

  LvSetting: TSingletonSettingObj;
begin
  Cs.Enter;
  LvSetting := TSingletonSettingObj.Instance;
  LvChatGPTApiKey := LvSetting.ApiKey;
  LvChatGPTBaseUrl := LvSetting.URL;
  LvModel := LvSetting.Model;

  LvMaxToken := LvSetting.MaxToken;
  LvTemperature := LvSetting.Temperature;
  LvQuestion := APrompt;

  LvAnimatedLetters := LvSetting.AnimatedLetters;
  LvTimeOut := LvSetting.TimeOut;
  LvIsOffline := LvSetting.IsOffline;

  FClassViewIsBusy := AIsClassView;
  Cs.Leave;

  FChatGPTTrd := TExecutorTrd.Create(Self.Handle, LvChatGPTApiKey, LvModel, LvQuestion, LvChatGPTBaseUrl,
    LvMaxToken, LvTemperature, LvAnimatedLetters, LvTimeOut, LvIsOffline);
  FChatGPTTrd.Start;
end;

procedure TFram_Question.ClassViewMenuItemClick(Sender: TObject);
var
  LvSettingObj: TSingletonSettingObj;
  LvQuestion: string;
begin
  if FClassTreeView.Selected <> FClassTreeView.TopItem then // Not applicable to the first node of the TreeView.
  begin
    Cs.Enter;
    LvSettingObj := TSingletonSettingObj.Instance;
    if LvSettingObj.TryFindQuestion(TMenuItem(Sender).Caption.Replace('&', '') , LvQuestion) > -1 then
    begin
      Cs.Leave;
      if not LvQuestion.Trim.IsEmpty then
      begin
        FLastQuestion := LvQuestion + #13 + FClassTreeView.Selected.Text; // Shorter string will be logged.
        LvQuestion  := LvQuestion  + #13 + FClassList.Items[FClassTreeView.Selected.Text].Text;
        mmoClassViewResult.Lines.Clear;
        CallThread(LvQuestion, True);
      end;
    end;
  end;
end;

procedure TFram_Question.ClearAnswer1Click(Sender: TObject);
begin
  ClearAnswers;
end;

procedure TFram_Question.ClearAnswers;
begin
  mmoAnswer.Lines.Clear;
end;

procedure TFram_Question.ClearQuestion1Click(Sender: TObject);
begin
  mmoQuestion.Clear;
end;

procedure TFram_Question.CopyToClipBoard;
begin
  if Assigned(pgcMain) then
  begin
    if pgcMain.ActivePage = tsChatGPT then
      Clipboard.SetTextBuf(pwidechar(mmoAnswer.Lines.Text))
    else if pgcMain.ActivePage = tsClassView then
      Clipboard.SetTextBuf(pwidechar(mmoClassViewDetail.Lines.Text));
  end
  else
    Clipboard.SetTextBuf(pwidechar(mmoAnswer.Lines.Text));
end;

procedure TFram_Question.CopytoClipboard1Click(Sender: TObject);
begin
  CopyToClipBoard;
end;

procedure TFram_Question.CustomCommandClick(Sender: TObject);
begin
  FLastQuestion := '';
  if InputQuery('Custom Command(use @Class to represent the selected class)', 'Write your command here', FLastQuestion) then
  begin
    if FLastQuestion.Trim = '' then
      Exit;
  end
  else
    Exit;

  if FLastQuestion.ToLower.Trim.Contains('@class') then
    FLastQuestion := StringReplace(FLastQuestion, '@class', ' ' + FClassList.Items[FClassTreeView.Selected.Text].Text + ' ', [rfReplaceAll, rfIgnoreCase])
  else
    FLastQuestion := FLastQuestion + #13 + FClassList.Items[FClassTreeView.Selected.Text].Text;

  mmoClassViewResult.Lines.Clear;
  CallThread(FLastQuestion, True);
end;

procedure TFram_Question.EnableUI(ATaskName: string);
begin
  Cs.Enter;
  Btn_Ask.Enabled := True;
  if ATaskName = 'CLS' then
  begin
    FClassViewIsBusy := False;
    mmoClassViewResult.Visible := True;
    splClassViewResult.Visible := True;
  end;
  Cs.Leave;
end;

function TFram_Question.FuzzyMatchStr(const APattern, AStr: string; AMatchedIndexes: TList; ACaseSensitive: Boolean): Boolean;
var
  PIdx, SIdx: Integer;
begin
  Result := False;
  if (APattern = '') or (AStr = '') then
    Exit;

  PIdx := 1;
  SIdx := 1;
  if AMatchedIndexes <> nil then
    AMatchedIndexes.Clear;

  if ACaseSensitive then
  begin
    while (PIdx <= Length(APattern)) and (SIdx <= Length(AStr)) do
    begin
      if APattern[PIdx] = AStr[SIdx] then
      begin
        Inc(PIdx);
        if AMatchedIndexes <> nil then
          AMatchedIndexes.Add(Pointer(SIdx));
      end;
      Inc(SIdx);
    end;
  end
  else
  begin
    while (PIdx <= Length(APattern)) and (SIdx <= Length(AStr)) do
    begin
      if LowChar(APattern[PIdx]) = LowChar(AStr[SIdx]) then
      begin
        Inc(PIdx);
        if AMatchedIndexes <> nil then
          AMatchedIndexes.Add(Pointer(SIdx));
      end;
      Inc(SIdx);
    end;
  end;
  Result := PIdx > Length(APattern);
end;

procedure TFram_Question.GoClick(Sender: TObject);
begin
  if FClassTreeView.Selected <> FClassTreeView.TopItem then
  begin
    FLastQuestion := 'Convert this Delphi Code to the GO programming language code: ' + #13 + FClassList.Items[FClassTreeView.Selected.Text].Text;
    mmoClassViewResult.Lines.Clear;
    CallThread(FLastQuestion, True);
  end;
end;

procedure TFram_Question.InitialClassViewMenueItems(AClassList: TClassList);
var
  LvKey: Integer;
  LvMenuItem: TMenuItem;
  LvTempSortingArray : TArray<Integer>;

  procedure AddMenuItem(ACaption: string);
  begin
    LvMenuItem := TMenuItem.Create(Self);
    LvMenuItem.Caption := ACaption;
    LvMenuItem.OnClick := ClassViewMenuItemClick;
    pmClassOperations.Items.Add(LvMenuItem);
  end;

  procedure AddSubMenu(ACaption: string; AParent: TMenuItem; AOnClickProc: TOnClickProc);
  var
    LvSubMenu: TMenuItem;
  begin
    LvSubMenu := TMenuItem.Create(Self);
    LvSubMenu.Caption := ACaption;
    LvSubMenu.OnClick := AOnClickProc;
    AParent.Add(LvSubMenu);
  end;

begin
  //pmClassOperations.Items.Clear;
  FClassList := AClassList;

  LvTempSortingArray := TSingletonSettingObj.Instance.PredefinedQuestions.Keys.ToArray; // TObjectDictionary is not sorted!
  TArray.Sort<Integer>(LvTempSortingArray);

  for LvKey in LvTempSortingArray do
    AddMenuItem(TSingletonSettingObj.Instance.PredefinedQuestions.Items[LvKey].Caption);

  // Add Convert commands
  LvMenuItem := TMenuItem.Create(Self);
  LvMenuItem.Caption := 'Convert to';
  pmClassOperations.Items.Add(LvMenuItem);

  AddSubMenu('C#', LvMenuItem, CSharpClick);
  AddSubMenu('Java', LvMenuItem, JavaClick);
  AddSubMenu('Python', LvMenuItem, PythonClick);
  AddSubMenu('Javascript', LvMenuItem, JavascriptClick);
  AddSubMenu('C', LvMenuItem, CClick);
  AddSubMenu('C++', LvMenuItem, CPlusPlusClick);
  AddSubMenu('Go', LvMenuItem, GoClick);
  AddSubMenu('Rust', LvMenuItem, RustClick);

  // Add Custom Commands
  LvMenuItem := TMenuItem.Create(Self);
  LvMenuItem.Caption := 'Custom Command';
  LvMenuItem.OnClick := CustomCommandClick;
  pmClassOperations.Items.Add(LvMenuItem);
end;

procedure TFram_Question.InitialFrame;
begin
  FLastQuestion := '';
  FClassViewIsBusy := False;
  Align := alClient;
//  ActivityIndicator1.Visible := False;

  // Styling does not work properly in Tokyo and Rio the following lines will make it better.
  if (CompilerVersion = 32{Tokyo}) or (CompilerVersion = 33{Rio}) then
  begin
    pgcMain.StyleElements := [seFont, seBorder, seClient];
    pnlMain.StyleElements := [seFont, seBorder];
    pnlCenter.StyleElements := [seFont, seBorder];
    pnlAnswer.StyleElements := [seFont, seBorder];
    pgcAnswers.StyleElements := [seFont, seBorder, seClient];
    tsChatGPT.StyleElements := [seFont, seBorder, seClient];
    pnlTop.StyleElements := [seFont, seBorder];
    pnlQuestion.StyleElements := [seFont, seBorder];
  end;

  if TSingletonSettingObj.Instance.IsOffline then
    tsChatGPTAnswer.Caption := 'Ollama(Offline)'
  else
    tsChatGPTAnswer.Caption := 'OpenAI(ChatGPT)';
end;

function TFram_Question.IslegacyModel: Boolean;
begin
  with TSingletonSettingObj.Instance do
  begin
    Result := Model.Equals('text-davinci-003') or URL.Equals('https://api.openai.com/v1/completions');
  end;
end;

procedure TFram_Question.JavaClick(Sender: TObject);
begin
  if FClassTreeView.Selected <> FClassTreeView.TopItem then
  begin
    FLastQuestion := 'Convert this Delphi Code to Java code: ' + #13 + FClassList.Items [FClassTreeView.Selected.Text].Text;
    mmoClassViewResult.Lines.Clear;
    CallThread(FLastQuestion, True);
  end;
end;

procedure TFram_Question.JavascriptClick(Sender: TObject);
begin
  if FClassTreeView.Selected <> FClassTreeView.TopItem then
  begin
    FLastQuestion := 'Convert this Delphi Code to Javascript code: ' + #13 + FClassList.Items[FClassTreeView.Selected.Text].Text;
    mmoClassViewResult.Lines.Clear;
    CallThread(FLastQuestion, True);
  end;
end;

procedure TFram_Question.mmoClassViewDetailDblClick(Sender: TObject);
begin
  mmoClassViewResult.Visible := True;
  splClassViewResult.Visible := True;
end;

procedure TFram_Question.mmoClassViewResultDblClick(Sender: TObject);
begin
  mmoClassViewResult.Visible := False;
  splClassViewResult.Visible := False;
end;

procedure TFram_Question.mmoQuestionKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Ord(Key) = 13) then
    Btn_Ask.Click;
end;

procedure TFram_Question.OnProgressMessage(var Msg: TMessage);
begin
  if Msg.WParam = 0 then
  begin
    Cs.Enter;
    begin
      Btn_Ask.Enabled := True;
//      ActivityIndicator1.Visible := False;
    end;
    Cs.Leave;
  end
  else if Msg.WParam = 1 then
end;

procedure TFram_Question.OnUpdateMessage(var Msg: TMessage);
begin
  if Assigned(pgcMain) then
  begin
    if pgcMain.ActivePage = tsChatGPT then
    begin
      if Msg.LParam = 0 then //whole string in one message.
      begin
        mmoAnswer.Lines.Clear;
        mmoAnswer.Lines.Add(String(Msg.WParam));
      end
      else if Msg.LParam = 1 then // Char by Char.
      begin
        mmoAnswer.Lines[Pred(mmoAnswer.Lines.Count)] := mmoAnswer.Lines[Pred(mmoAnswer.Lines.Count)] + char(Msg.WParam);
      end
      else if Msg.LParam = 2 then // Finished.
        EnableUI('GPT')
      else if Msg.LParam = 3 then // Exception.
      begin
        mmoAnswer.Lines.Clear;
        mmoAnswer.Lines.Add(String(Msg.WParam));
        EnableUI('GPT');
      end;
    end
    else if pgcMain.ActivePage = tsClassView then
    begin
      if Msg.LParam = 0 then //whole string in one message.
      begin
        mmoClassViewResult.Lines.Clear;
        mmoClassViewResult.Lines.Add(String(Msg.WParam));
      end
      else if Msg.LParam = 1 then // Char by Char.
      begin
        mmoClassViewResult.Lines[Pred(mmoClassViewResult.Lines.Count)] := mmoClassViewResult.Lines[Pred(mmoClassViewResult.Lines.Count)] + char(Msg.WParam);
      end
      else if Msg.LParam = 2 then // Finished.
        EnableUI('CLS')
      else if Msg.LParam = 3 then // Exception.
      begin
        EnableUI('CLS');
        mmoClassViewResult.Lines.Clear;
        mmoClassViewResult.Lines.Add(String(Msg.WParam));
      end;
    end;
  end
  else
  begin
    if Msg.LParam = 0 then //whole string in one message.
    begin
      mmoAnswer.Lines.Clear;
      mmoAnswer.Lines.Add(String(Msg.WParam));
    end
    else if Msg.LParam = 1 then // Char by Char.
    begin
      mmoAnswer.Lines[Pred(mmoAnswer.Lines.Count)] := mmoAnswer.Lines[Pred(mmoAnswer.Lines.Count)] + char(Msg.WParam);
    end
    else if Msg.LParam = 2 then // Finished.
      EnableUI('GPT');
  end;

  if Msg.LParam = 2 then
  begin
    if chk_AutoCopy.Checked then
      CopyToClipBoard;
  end;
end;

procedure TFram_Question.pgcAnswersChange(Sender: TObject);
begin
  if chk_AutoCopy.Checked then
    Clipboard.SetTextBuf(pwidechar(mmoAnswer.Lines.Text));

//  ActivityIndicator1.Visible := TSingletonSettingObj.Instance.TaskList.Count > 0;
end;

procedure TFram_Question.pgcMainChange(Sender: TObject);
begin
  if (pgcMain.ActivePage = tsClassView) and (not FClassViewIsBusy) then
    ReloadClassList(FClassList);
end;

procedure TFram_Question.pmClassOperationsPopup(Sender: TObject);
begin
  FClassTreeView.OnChange(FClassTreeView, FClassTreeView.Selected);
  if FClassTreeView.Selected = FClassTreeView.TopItem then
    keybd_event(VK_ESCAPE, Mapvirtualkey(VK_ESCAPE, 0), 0, 0);
end;

procedure TFram_Question.PythonClick(Sender: TObject);
begin
  if FClassTreeView.Selected <> FClassTreeView.TopItem then
  begin
    FLastQuestion := 'Convert this Delphi Code to Pyhton code: ' + #13 + FClassList.Items[FClassTreeView.Selected.Text].Text;
    mmoClassViewResult.Lines.Clear;
    CallThread(FLastQuestion, True);
  end;
end;

procedure TFram_Question.ReloadClassList(AClassList: TClassList);
var
  LvLexer: TcpLexer;
begin
  FClassTreeView := TTreeView.Create(tsClassView);
  with FClassTreeView do
  begin
    Parent := pnlClasses;
    Align := alClient;
    AlignWithMargins := True;
    Indent := 19;
    TabOrder := 0;
    RightClickSelect := True;
    HideSelection := False;
    PopupMenu := pmClassOperations;
    OnChange := tvOnChange;
  end;

  LvLexer := TcpLexer.Create(FClassList);
  try
    LvLexer.Reload;
    FClassList.FillTreeView(FClassTreeView);
    mmoClassViewDetail.Lines.Clear;
  finally
    LvLexer.Free;
  end;
end;

function TFram_Question.LowChar(AChar: Char): Char;
begin
  if AChar in ['A'..'Z'] then
    Result := Chr(Ord(AChar) + 32)
  else
    Result := AChar;
end;

procedure TFram_Question.RustClick(Sender: TObject);
begin
  if FClassTreeView.Selected <> FClassTreeView.TopItem then
  begin
    FLastQuestion := 'Convert this Delphi Code to Rust code: ' + #13 + FClassList.Items[FClassTreeView.Selected.Text].Text;
    mmoClassViewResult.Lines.Clear;
    CallThread(FLastQuestion, True);
  end;
end;

procedure TFram_Question.TerminateAll;
begin
  try
    if Assigned(FChatGPTTrd) then FChatGPTTrd.Terminate;
  except
  end;

  Btn_Ask.Enabled := True;
end;

procedure TFram_Question.tvOnChange(Sender: TObject; Node: TTreeNode);
begin
  mmoClassViewDetail.Lines.Clear;
  mmoClassViewDetail.ScrollBars := TScrollStyle.ssNone;
  if Node <> FClassTreeView.TopItem then
    mmoClassViewDetail.Lines.Add(FClassList.Items[Node.Text].Text);
  mmoClassViewDetail.ScrollBars := TScrollStyle.ssVertical;
end;

{ TObDicHelper }
procedure TObDicHelper.FillTreeView(var ATree: TTreeView);
var
  LvNode: TTreeNode;
  LvKey: string;
begin
  if Assigned(ATree) and (Self.Count > 0) then
  begin
    try
      LvNode := ATree.Items.Add(nil, 'Classes');
      for LvKey in Self.Keys do
        ATree.Items.AddChild(LvNode, LvKey);
    except
    end;

    ATree.AutoExpand := True;
    ATree.FullExpand;
  end;
end;

end.
