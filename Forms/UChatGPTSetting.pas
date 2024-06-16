{ ***************************************************}
{                                                    }
{   This is the setting form of the plugin.          }
{   Could be found in the main menu.                 }
{   Auhtor: Ali Dehbansiahkarbon(adehban@gmail.com)  }
{   GitHub: https://github.com/AliDehbansiahkarbon   }
{                                                    }
{ ***************************************************}
unit UChatGPTSetting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, System.Win.Registry, System.SyncObjs,
  ToolsAPI, System.StrUtils, System.Generics.Collections, Vcl.Mask,
  Vcl.ComCtrls, DockForm, UConsts;

type
  TQuestionPair = class
  private
    FCaption: string;
    FQuestion: string;
  public
    constructor Create(ACaption, AQuestion: string);
    property Caption: string read FCaption write FCaption;
    property Question: string read FQuestion write FQuestion;
  end;

  TQuestionPairs = TObjectDictionary<Integer, TQuestionPair>;

  // Note: This class is thread-safe, since accessing the class variable is done in a critical section!
  TSingletonSettingObj = class(TObject)
  private
    FApiKey: string;
    FURL: string;
    FModel: string;
    FMaxToken: Integer;
    FTemperature: Integer;
    FIdentifier: string;
    FCodeFormatter: Boolean;
    FRightToLeft: Boolean;
    FRootMenuIndex: Integer;
    FCurrentActiveViewName: string;
    FPredefinedQuestions: TQuestionPairs;
    FAnimatedLetters: Boolean;
    FTimeOut: Integer;
    FMainFormLastQuestion: string;
    FIsOffline: Boolean;

    class var FInstance: TSingletonSettingObj;
    class function GetInstance: TSingletonSettingObj; static;
    constructor Create;
    destructor Destroy; override;

    function GetLeftIdentifier: string;
    function GetRightIdentifier: string;
    procedure LoadDefaults;
    procedure LoadDefaultQuestions;

  public
    procedure ReadRegistry;
    procedure WriteToRegistry;
    function GetSetting: string;
    function TryFindQuestion(ACaption: string; var AQuestion: string): Integer;
    class Procedure RegisterFormClassForTheming(Const AFormClass: TCustomFormClass; Const Component: TComponent = Nil);
//    class function IsValidJson(const AJsonString: string): Boolean;
    class property Instance: TSingletonSettingObj read GetInstance;

    property ApiKey: string read FApiKey write FApiKey;
    property URL: string read FURL write FURL;
    property Model: string read FModel write FModel;
    property MaxToken: Integer read FMaxToken write FMaxToken;
    property Temperature: Integer read FTemperature write FTemperature;
    property CodeFormatter: Boolean read FCodeFormatter write FCodeFormatter;
    property Identifier: string read FIdentifier write FIdentifier;
    property LeftIdentifier: string read GetLeftIdentifier;
    property RightIdentifier: string read GetRightIdentifier;
    property RighToLeft: Boolean read FRightToLeft write FRightToLeft;
    property RootMenuIndex: Integer read FRootMenuIndex write FRootMenuIndex;
    property CurrentActiveViewName: string read FCurrentActiveViewName write FCurrentActiveViewName;
    property PredefinedQuestions: TQuestionPairs read FPredefinedQuestions write FPredefinedQuestions;
    property AnimatedLetters: Boolean read FAnimatedLetters write FAnimatedLetters;
    property TimeOut: Integer read FTimeOut write FTimeOut;
    property MainFormLastQuestion: string read FMainFormLastQuestion write FMainFormLastQuestion;
    property IsOffline: Boolean read FIsOffline write FIsOffline;
  end;

  TFrm_Setting = class(TForm)
    pnlMain: TPanel;
    grp_OpenAI: TGroupBox;
    pnlOpenAI: TPanel;
    lbl_1: TLabel;
    lbl_2: TLabel;
    lbl_3: TLabel;
    lbl_4: TLabel;
    lbl_5: TLabel;
    edt_Url: TEdit;
    edt_ApiKey: TEdit;
    edt_MaxToken: TEdit;
    edt_Temperature: TEdit;
    cbbModel: TComboBox;
    pnlOther: TPanel;
    pnlBottom: TPanel;
    Btn_Default: TButton;
    Btn_Save: TButton;
    grp_Other: TGroupBox;
    pnlIDE: TPanel;
    lbl_6: TLabel;
    Edt_SourceIdentifier: TEdit;
    chk_CodeFormatter: TCheckBox;
    chk_Rtl: TCheckBox;
    pgcSetting: TPageControl;
    tsMainSetting: TTabSheet;
    tsPreDefinedQuestions: TTabSheet;
    Btn_AddQuestion: TButton;
    ScrollBox: TScrollBox;
    GridPanelPredefinedQs: TGridPanel;
    Btn_RemoveQuestion: TButton;
    lbEdt_Timeout: TLabeledEdit;
    pnlPredefinedQ: TPanel;
    chk_AnimatedLetters: TCheckBox;
    chk_Offline: TCheckBox;
    edt_OfflineModel: TEdit;
    procedure Btn_SaveClick(Sender: TObject);
    procedure Btn_DefaultClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure Btn_RemoveQuestionClick(Sender: TObject);
    procedure Btn_AddQuestionClick(Sender: TObject);
    procedure edt_UrlChange(Sender: TObject);
    procedure cbbModelChange(Sender: TObject);
    procedure chk_AnimatedLettersClick(Sender: TObject);
    procedure ColorBox_HighlightChange(Sender: TObject);
    procedure chk_ProxyActiveClick(Sender: TObject);
    procedure pgcSettingChange(Sender: TObject);
    procedure chk_OfflineClick(Sender: TObject);
  private
    procedure AddQuestion(AQuestionpair: TQuestionPair = nil);
    procedure RemoveLatestQuestion;
    procedure ClearGridPanel;
    function ValidateInputs: Boolean;
  public
    HasChanges: Boolean;
    procedure AddAllDefinedQuestions;
  end;

var
  Frm_Setting: TFrm_Setting;
  Cs: TCriticalSection;

implementation
uses
  UChatGptMain;

{$R *.dfm}

{ TSingletonSettingObj }
constructor TSingletonSettingObj.Create;
begin
  inherited;
  FPredefinedQuestions := TObjectDictionary<Integer, TQuestionPair>.Create;
  CurrentActiveViewName := '';
  LoadDefaults;
end;

destructor TSingletonSettingObj.Destroy;
begin
  FPredefinedQuestions.Free;
  inherited;
end;

class function TSingletonSettingObj.GetInstance: TSingletonSettingObj;
begin
  if not Assigned(FInstance) then
    FInstance := TSingletonSettingObj.Create;
  Result := FInstance;
end;

function TSingletonSettingObj.GetLeftIdentifier: string;
begin
  Result := FIdentifier + ':';
end;

function TSingletonSettingObj.GetRightIdentifier: string;
begin
  Result := ':' + FIdentifier;
end;

function TSingletonSettingObj.GetSetting: string;
begin
  Result := EmptyStr;
  ShowMessage('You need an API key, please fill the setting parameters in setting form.');
  Frm_Setting := TFrm_Setting.Create(nil);
  try
    TSingletonSettingObj.RegisterFormClassForTheming(TFrm_Setting, Frm_Setting);
    // Apply Theme
    Frm_Setting.ShowModal;
  finally
    FreeAndNil(Frm_Setting);
  end;
  Result := TSingletonSettingObj.Instance.ApiKey;
end;

//class function TSingletonSettingObj.IsValidJson(const AJsonString: string): Boolean;
//var
//  LvJsonObj: TJSONObject;
//begin
//  Result := False;
//  try
//    LvJsonObj := TJSONObject.ParseJSONValue(AJsonString) as TJSONObject;
//    Result := Assigned(LvJsonObj); // If parsing succeeds, JSON is valid
//    LvJsonObj.Free;
//  except
//    Result := False;
//  end;
//end;

procedure TSingletonSettingObj.LoadDefaultQuestions;
begin
  with FPredefinedQuestions do
  begin
    Clear;
    Add(1, TQuestionPair.Create('Create Test Unit', 'Create a Test Unit for the following class in Delphi:'));
    Add(2, TQuestionPair.Create('Convert to Singleton', 'Convert this class to singleton in Delphi:'));
    Add(3, TQuestionPair.Create('Find possible problems', 'What is wrong with this class in Delphi?'));
    Add(4, TQuestionPair.Create('Improve Naming', 'Improve naming of the members of this class in Delphi:'));
    Add(5, TQuestionPair.Create('Rewrite in modern coding style', 'Rewrite this class with modern coding style in Delphi:'));
    Add(6, TQuestionPair.Create('Create Interface','Create necessary interfaces for this Class in Delphi:'));
    Add(7, TQuestionPair.Create('Convert to Generic Type', 'Convert this class to generic class in Delphi:'));
    Add(8, TQuestionPair.Create('Write XML doc', 'Write Documentation using inline XML based comments for this class in Delphi:'));
  end;
end;

procedure TSingletonSettingObj.LoadDefaults;
begin
  FApiKey := '';
  FURL := DefaultChatGPTURL;
  FModel := DefaultModel;
  FMaxToken := DefaultMaxToken;
  FTemperature := DefaultTemperature;
  FIdentifier := DefaultIdentifier;
  FCodeFormatter := DefaultCodeFormatter;
  FRightToLeft := DefaultRTL;
  FAnimatedLetters := True;
  FTimeOut := 20;
  FMainFormLastQuestion := 'Create a class to make a Zip file in Delphi.';
  FIsOffline := False;

  LoadDefaultQuestions;
end;

procedure TSingletonSettingObj.ReadRegistry;
var
  LvRegKey: TRegistry;
  I: Integer;
begin
  FApiKey := '';

  LvRegKey := TRegistry.Create;
  try
    try
      with LvRegKey do
      begin
        CloseKey;
        RootKey := HKEY_CURRENT_USER;

        if OpenKey('\SOFTWARE\ChatGPTWizard', False) then
        begin
          if ValueExists('ChatGPTApiKey') then
            FApiKey := ReadString('ChatGPTApiKey');

          if ValueExists('ChatGPTURL') then
            FURL := IfThen(ReadString('ChatGPTURL').IsEmpty, DefaultChatGPTURL, ReadString('ChatGPTURL'))
          else
            FURL := DefaultChatGPTURL;

          if ValueExists('ChatGPTModel') then
            FModel := IfThen(ReadString('ChatGPTModel').IsEmpty, DefaultModel, ReadString('ChatGPTModel'))
          else
            FModel := DefaultModel;

          if ValueExists('ChatGPTMaxToken') then
          begin
            FMaxToken := ReadInteger('ChatGPTMaxToken');
            if FMaxToken <= 0 then
              FMaxToken := DefaultMaxToken;
          end
          else
            FMaxToken := DefaultMaxToken;

          if ValueExists('ChatGPTTemperature') then
          begin
            FTemperature := ReadInteger('ChatGPTTemperature');
            if FTemperature <= -1 then
              FTemperature := DefaultTemperature;
          end
          else
            FTemperature := DefaultTemperature;

          if ValueExists('ChatGPTSourceIdentifier') then
            FIdentifier := IfThen(ReadString('ChatGPTSourceIdentifier').IsEmpty, DefaultIdentifier, ReadString('ChatGPTSourceIdentifier'))
          else
            FIdentifier := DefaultIdentifier;

          if ValueExists('ChatGPTCodeFormatter') then
            FCodeFormatter := ReadBool('ChatGPTCodeFormatter')
          else
            FCodeFormatter := DefaultCodeFormatter;

          if ValueExists('ChatGPTRTL') then
            FRightToLeft := ReadBool('ChatGPTRTL')
          else
            FRightToLeft := DefaultRTL;

          if ValueExists('ChatGPTAnimatedLetters') then
            FAnimatedLetters := ReadBool('ChatGPTAnimatedLetters')
          else
            FAnimatedLetters := True;

          if ValueExists('ChatGPTTimeOut') then
            FTimeOut := ReadInteger('ChatGPTTimeOut')
          else
            FTimeOut := 20;

          if ValueExists('ChatGPTMainFormLastQuestion') then
            FMainFormLastQuestion := ReadString('ChatGPTMainFormLastQuestion').Trim
          else
            FMainFormLastQuestion := 'Create a class to make a Zip file in Delphi.';

          //=======================Ollama(Offline)=======================begin
          if ValueExists('ChatGPTIsOffline') then
            FIsOffline := ReadBool('ChatGPTIsOffline')
          else
            FIsOffline := False;
          //=======================Ollama(Offline)========================end
        end;

        if OpenKey('\SOFTWARE\ChatGPTWizard\PredefinedQuestions', False) then
        begin
          FPredefinedQuestions.Clear;
          for I := 1 to 100 do
          begin
            if (ValueExists('Caption' + I.ToString)) and (ValueExists('Question' + I.ToString)) then
              FPredefinedQuestions.Add(I, TQuestionPair.Create(ReadString('Caption' + I.ToString), ReadString('Question' + I.ToString)));
          end;

          if FPredefinedQuestions.Count = 0 then
            LoadDefaultQuestions;
        end
        else
          LoadDefaultQuestions;
      end;
    except
      LoadDefaults;
    end;
  finally
    LvRegKey.Free;
  end;
end;

class procedure TSingletonSettingObj.RegisterFormClassForTheming(const AFormClass: TCustomFormClass; const Component: TComponent);
{$IF CompilerVersion >= 32.0}
Var
{$IF CompilerVersion > 33.0} // Breaking change to the Open Tools API - They fixed the wrongly defined interface
  ITS: IOTAIDEThemingServices;
{$ELSE}
  ITS: IOTAIDEThemingServices250;
{$IFEND}
{$IFEND}
begin
{$IF CompilerVersion >= 32.0}
{$IF CompilerVersion > 33.0}
  If Supports(BorlandIDEServices, IOTAIDEThemingServices, ITS) Then
{$ELSE}
  If Supports(BorlandIDEServices, IOTAIDEThemingServices250, ITS) Then
{$IFEND}
    If ITS.IDEThemingEnabled Then
    begin
      ITS.RegisterFormClass(AFormClass);
      If Assigned(Component) Then
        ITS.ApplyTheme(Component);
    end;
{$IFEND}
end;

function TSingletonSettingObj.TryFindQuestion(ACaption: string; var AQuestion: string): Integer;
var
  LvKey: Integer;
begin
  AQuestion := '';
  Result := -1;

  for LvKey in FPredefinedQuestions.Keys do
  begin
    if FPredefinedQuestions.Items[LvKey].Caption.ToLower.Trim = ACaption.ToLower.Trim then
    begin
      AQuestion := FPredefinedQuestions.Items[LvKey].Question;
      Result := LvKey;
      Break;
    end;
  end;
end;

procedure TSingletonSettingObj.WriteToRegistry;
var
  LvRegKey: TRegistry;
  LvKey: Integer;
  I: Integer;
begin
  LvRegKey := TRegistry.Create;
  try
    with LvRegKey do
    begin
      CloseKey;
      RootKey := HKEY_CURRENT_USER;
      if OpenKey('\SOFTWARE\ChatGPTWizard', True) then
      begin
        WriteString('ChatGPTApiKey', FApiKey);
        WriteString('ChatGPTURL', FURL);
        WriteString('ChatGPTModel', FModel);
        WriteInteger('ChatGPTMaxToken', FMaxToken);
        WriteInteger('ChatGPTTemperature', FTemperature);
        WriteString('ChatGPTSourceIdentifier', FIdentifier);
        WriteBool('ChatGPTCodeFormatter', FCodeFormatter);
        WriteBool('ChatGPTRTL', FRightToLeft);
        WriteBool('ChatGPTAnimatedLetters', FAnimatedLetters);
        WriteInteger('ChatGPTTimeOut', FTimeOut);
        WriteString('ChatGPTMainFormLastQuestion', FMainFormLastQuestion.Trim);
        WriteBool('ChatGPTIsOffline', FIsOffline);

        if OpenKey('\SOFTWARE\ChatGPTWizard\PredefinedQuestions', True) then
        begin
          for I:= 0  to 100 do // Limited to maximum 100 menuitems.
          begin
            if ValueExists('Caption' + I.ToString) then
              DeleteValue('Caption' + I.ToString);

            if ValueExists('Question' + I.ToString) then
              DeleteValue('Question' + I.ToString);
          end;

          for LvKey in FPredefinedQuestions.Keys do
          begin
            WriteString('Caption' + LvKey.ToString, FPredefinedQuestions.Items[LvKey].Caption);
            WriteString('Question' + LvKey.ToString, FPredefinedQuestions.Items[LvKey].Question);
          end;
        end;
      end;
    end;
  finally
    LvRegKey.Free;
  end;
end;

{TFrm_Setting}

procedure TFrm_Setting.Btn_AddQuestionClick(Sender: TObject);
begin
  HasChanges := True;
  AddQuestion;
end;

procedure TFrm_Setting.Btn_DefaultClick(Sender: TObject);
begin
  edt_ApiKey.Text := '';
  edt_Url.Text := DefaultChatGPTURL;
  cbbModel.ItemIndex := 0;
  edt_MaxToken.Text := IntToStr(DefaultMaxToken);
  edt_Temperature.Text := IntToStr(DefaultTemperature);
  chk_CodeFormatter.Checked := DefaultCodeFormatter;
  chk_Rtl.Checked := DefaultRTL;
  chk_AnimatedLetters.Checked := True;
  chk_Offline.Checked := False;
end;

procedure TFrm_Setting.Btn_SaveClick(Sender: TObject);
var
  I: Integer;
  LvSettingObj: TSingletonSettingObj;
  LvCaption, LvQuestion: string;
  LvLabeledEdit: TControl;
  Lvpanel: TControl;
begin
  if not ValidateInputs then
    Exit;

  LvSettingObj := TSingletonSettingObj.Instance;
  LvSettingObj.ApiKey := Trim(edt_ApiKey.Text);
  LvSettingObj.URL := Trim(edt_Url.Text);
  if chk_Offline.Checked then
    LvSettingObj.Model := Trim(edt_OfflineModel.Text)
  else
    LvSettingObj.Model := Trim(cbbModel.Text);

  LvSettingObj.MaxToken := StrToInt(edt_MaxToken.Text);
  LvSettingObj.Temperature := StrToInt(edt_Temperature.Text);
  LvSettingObj.RighToLeft := chk_Rtl.Checked;
  LvSettingObj.CodeFormatter := chk_CodeFormatter.Checked;
  LvSettingObj.Identifier := Edt_SourceIdentifier.Text;
  LvSettingObj.AnimatedLetters := chk_AnimatedLetters.Checked;
  LvSettingObj.TimeOut := StrToInt(Frm_Setting.lbEdt_Timeout.Text);
  LvSettingObj.IsOffline := chk_Offline.Checked;

  LvSettingObj.PredefinedQuestions.Clear;
  for I := 1 to 100 do
  begin
    LvLabeledEdit := nil;
    Lvpanel := nil;

    Lvpanel := GridPanelPredefinedQs.FindChildControl('panel' + I.ToString);
    if Lvpanel <> nil then
    begin  
      LvLabeledEdit := TPanel(Lvpanel).FindChildControl('CustomLbl' + I.ToString);
      if LvLabeledEdit <> nil then
      begin
        LvCaption := TLabeledEdit(LvLabeledEdit).Text;
        LvQuestion := TMemo(TPanel(Lvpanel).FindChildControl('CustomLblQ' + I.ToString)).Lines.Text;
        if (not LvCaption.IsEmpty) and (not LvQuestion.IsEmpty) then
          LvSettingObj.PredefinedQuestions.Add(I, TQuestionPair.Create(LvCaption, LvQuestion));
      end;
    end;      
  end;
  LvSettingObj.WriteToRegistry;
  Close;
end;

procedure TFrm_Setting.Btn_RemoveQuestionClick(Sender: TObject);
begin
  HasChanges := True;
  RemoveLatestQuestion;
end;

procedure TFrm_Setting.cbbModelChange(Sender: TObject);
begin
  HasChanges := True;
end;

procedure TFrm_Setting.chk_AnimatedLettersClick(Sender: TObject);
begin
  HasChanges := True;
end;

procedure TFrm_Setting.chk_OfflineClick(Sender: TObject);
begin
  cbbModel.Enabled := not chk_Offline.Checked;
  edt_MaxToken.Enabled := not chk_Offline.Checked;
  edt_OfflineModel.Enabled := chk_Offline.Checked;
end;

procedure TFrm_Setting.chk_ProxyActiveClick(Sender: TObject);
begin
  HasChanges := True;
end;

procedure TFrm_Setting.ClearGridPanel;
var
  I: Integer;
begin
  for I:= GridPanelPredefinedQs.RowCollection.Count downto 1 do
    RemoveLatestQuestion;
end;

procedure TFrm_Setting.ColorBox_HighlightChange(Sender: TObject);
begin
  HasChanges := True;
end;

procedure TFrm_Setting.edt_UrlChange(Sender: TObject);
begin
  HasChanges := True;
end;

procedure TFrm_Setting.FormCreate(Sender: TObject);
begin
  HasChanges := False;
  GridPanelPredefinedQs.RowCollection.Clear;
  pgcSetting.ActivePageIndex := 0;

  // Styling does not work properly in Tokyo and Rio the following lines will make it better.
  if (CompilerVersion = 32{Tokyo}) or (CompilerVersion = 33{Rio}) then
  begin
    pgcSetting.StyleElements := [seFont, seBorder, seClient];

    pnlMain.StyleElements := [seFont, seBorder];
    pnlOpenAI.StyleElements := [seFont, seBorder];
    pnlOther.StyleElements := [seFont, seBorder];
    chk_CodeFormatter.StyleElements := [seFont, seBorder];
    chk_Rtl.StyleElements := [seFont, seBorder];
    chk_AnimatedLetters.StyleElements := [seFont, seBorder];

    tsPreDefinedQuestions.StyleElements := [seFont, seBorder, seClient];
    pnlPredefinedQ.StyleElements := [seFont, seBorder];
  end;
end;

procedure TFrm_Setting.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Ord(Key) = 27 then
    Close;
end;

procedure TFrm_Setting.pgcSettingChange(Sender: TObject);
begin
  Btn_Default.Visible := pgcSetting.ActivePage = tsMainSetting;
end;

procedure TFrm_Setting.AddAllDefinedQuestions;
var
  LvKey: Integer;
  LvTempSortingArray : TArray<Integer>;
begin
  ClearGridPanel;

  LvTempSortingArray := TSingletonSettingObj.Instance.PredefinedQuestions.Keys.ToArray; // TObjectDictionary is not sorted!
  TArray.Sort<Integer>(LvTempSortingArray);

  for LvKey in LvTempSortingArray do
    AddQuestion(TSingletonSettingObj.Instance.PredefinedQuestions.Items[LvKey]);
end;

procedure TFrm_Setting.AddQuestion(AQuestionpair: TQuestionPair);
var
  LvPanel: Tpanel;
  LvLabeledEditCaption: TLabeledEdit;
  I, LvCounter: Integer;
  LvH: Integer;
begin
  LvH := 0;
  LvCounter := 0;
  with GridPanelPredefinedQs do
  begin
    for I := 0 to Pred(RowCollection.Count + 1) do
      LvH := LvH + 80;

    Height := LvH;
    with RowCollection.Add do
    begin
      SizeStyle := ssAbsolute;
      Value := 80;
    end;
  end;

  LvCounter := GridPanelPredefinedQs.RowCollection.Count;
  LvPanel := TPanel.Create(Self);
  LvPanel.Caption := '';
  LvPanel.Parent := GridPanelPredefinedQs;
  LvPanel.Align := alClient;

  with LvPanel do
  begin
    Name := 'panel' + LvCounter.ToString;
    LvLabeledEditCaption := TLabeledEdit.Create(LvPanel);
    with LvLabeledEditCaption do
    begin
      Name := 'CustomLbl' + LvCounter.ToString;
      Parent := LvPanel;
      AlignWithMargins := True;
      Margins.Left := 55;
      Align := alTop;
      EditLabel.Caption := 'Caption';
      EditLabel.Transparent := True;
      LabelPosition := lpLeft;
      LabelSpacing := 4;
      if Assigned(AQuestionpair) then
        Text := AQuestionpair.Caption
      else
        Text := '';
    end;

    with TMemo.Create(LvPanel) do
    begin
      Name := 'CustomLblQ' + LvCounter.ToString;
      Parent := LvPanel;
      AlignWithMargins := True;
      Margins.Left := 55;
      Align := alClient;
      WordWrap := True;
      if Assigned(AQuestionpair) then
        Lines.Text := AQuestionpair.Question
      else
        Lines.Text := '';
      ScrollBars := ssVertical;
    end;

    with TLabel.Create(LvPanel) do
    begin
      Parent := LvPanel;
      Caption := 'Question';
      Left := 5;
      Top := 57;
    end;
  end;
end;

procedure TFrm_Setting.RemoveLatestQuestion;
begin
  if GridPanelPredefinedQs.RowCollection.Count > 0 then
  begin
    with GridPanelPredefinedQs do
    begin
      FindChildControl('panel' + GridPanelPredefinedQs.RowCollection.Count.ToString).Free;
      RowCollection.Items[Pred(GridPanelPredefinedQs.RowCollection.Count)].Free;
    end;
  end;
end;

function TFrm_Setting.ValidateInputs: Boolean;
var
  LvStr: string;
begin
  Result := False;
  if chk_Offline.Checked then
  begin
    if Trim(edt_OfflineModel.Text).IsEmpty then
    begin
      ShowMessage('Please enter the Offline model name.');
      Exit;
    end;
  end
  else if (cbbModel.ItemIndex = -1) or (Trim(cbbModel.Text).Equals(EmptyStr)) then
  begin
    ShowMessage('Please Select the model name.');
    if cbbModel.CanFocus then
      cbbModel.SetFocus;

    Exit;
  end;

  LvStr := edt_Url.Text;
  if (not chk_Offline.Checked) and (LvStr.Contains('localhost')) or (LvStr.Contains('127.0.0.1')) then
  begin
    if MessageDlg('It seems you are using offline server with an online model, it doesn''t work probably, do you want to save anyway?', mtWarning, [mbYes,mbNo], 0) = mrNo then
      Exit;
  end;

  Result := True;
end;

{ TQuestionPair }

constructor TQuestionPair.Create(ACaption, AQuestion: string);
begin
  FCaption := ACaption;
  FQuestion := AQuestion;
end;

initialization
  Cs := TCriticalSection.Create;

finalization
  Cs.Free;

end.