unit Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, System.Sensors, System.Sensors.Components, System.Actions,
  FMX.ActnList, FMX.Ani, System.Math.Vectors, FMX.Controls3D, FMX.Layers3D,
  FMX.Controls.Presentation, FMX.StdCtrls, System.ImageList, FMX.ImgList,
  {$IFDEF MSWINDOWS}
     Winapi.Windows, FMX.Media;
  {$ELSE}
     Macapi.AppKit, Macapi.CoreGraphics;
  {$ENDIF}

type

  TPlayerData = class(TFMXObject)
  public
    SpeedX: Single;
    SpeedY: Single;
    MaxSpeedX: Single;
    MaxSpeedY: Single;
    MaxReverseSpeedX: Single;
    MaxReverseSpeedY: Single;
    AccelerationX: Single;
    AccelerationY: Single;
    EnemiesDestroyed: Integer;
    EnemiesSpawned: Integer;
    CanWarp: Boolean;

    Lives: Integer;
    Health: Integer;
    Bombs: Integer;
    Invulnerable: Integer;
    InvulnerableInterval: Integer;
    Score: Integer;
    Level: Integer;
    FireSpeed: Integer;
    FireInterval: Integer;
    ProjDuration: Single;
  end;

  TFrm_Principal = class(TForm)
    Layout2: TLayout;
    MontanhaRect: TRectangle;
    CeuRect: TRectangle;
    HorzScrollBox2: THorzScrollBox;
    FloatAnimation1: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    Rectangle1: TRectangle;
    HorzScrollBoxMiniatura: THorzScrollBox;
    MiniaturaMontanhaRect: TRectangle;
    FloatAnimation3: TFloatAnimation;
    Helicoptero: TRectangle;
    AnimaHelicoptero: TFloatAnimation;
    BitmapListAnimation1: TBitmapListAnimation;
    ImageList1: TImageList;
    BitmapListAnimation2: TBitmapListAnimation;
    MiniHelicoptero: TRectangle;
    Timer_LoopPrincipal: TTimer;
    MediaPlayerHelicoptero: TMediaPlayer;
    Layout1: TLayout;
    Lbl_Lives: TLabel;
    Layout3: TLayout;
    Lbl_Score: TLabel;
    procedure FormCreate(Sender: TObject);
    Procedure ControleTeclado;
    procedure Timer_LoopPrincipalTimer(Sender: TObject);
    procedure Loop_Audio;
  private
    { Private declarations }
    ProporcaoY : Real;
  public
    { Public declarations }
  end;

var
  Frm_Principal: TFrm_Principal;

implementation

{$R *.fmx}

procedure TFrm_Principal.ControleTeclado;
  function tbKeyIsDown(const Key: integer): boolean;
  begin
    Result := GetKeyState(Key) and 128 > 0;
  end;
begin
//  vkLeft  = { 37 } / vkA   = { 65 }
//  vkRight = { 39 } / vkA   = { 68 }
//  vkUp    = { 38 } / vkA   = { 87 }
//  vkDown  = { 40 } / vkA   = { 83 }
  if (tbKeyIsDown(37))or(tbKeyIsDown(65)) then // move para direita - tecla D ou seta para direita
  begin
    CeuRect.Position.X := CeuRect.Position.X +0.3;
    MiniaturaMontanhaRect.Position.X := MiniaturaMontanhaRect.Position.X +0.5;
    MontanhaRect.Position.X := MontanhaRect.Position.X +2;

    CeuRect.Position.X := CeuRect.Position.X +0.3;
    MiniaturaMontanhaRect.Position.X := MiniaturaMontanhaRect.Position.X +0.5;
    MontanhaRect.Position.X := MontanhaRect.Position.X +2;

    BitmapListAnimation1.Enabled := False;
    BitmapListAnimation2.Enabled := True;
  end;
  if (tbKeyIsDown(39))or(tbKeyIsDown(68)) then // move para esquerda - tecla A ou seta para esquerda
  begin
    CeuRect.Position.X := CeuRect.Position.X -0.3;
    MiniaturaMontanhaRect.Position.X := MiniaturaMontanhaRect.Position.X -0.5;
    MontanhaRect.Position.X := MontanhaRect.Position.X -2;

    CeuRect.Position.X := CeuRect.Position.X -0.3;
    MiniaturaMontanhaRect.Position.X := MiniaturaMontanhaRect.Position.X -0.5;
    MontanhaRect.Position.X := MontanhaRect.Position.X -2;

    BitmapListAnimation1.Enabled := True;
    BitmapListAnimation2.Enabled := False;
  end;
  if (tbKeyIsDown(40))or(tbKeyIsDown(83)) then  // move para baixo - tecla S ou seta para baixo
  begin
    if Helicoptero.Position.Y >= 530 then
    begin
      Helicoptero.Position.Y := 529;
      exit;
    end;
    Helicoptero.Position.Y := Helicoptero.Position.Y  + 2;
  end;
  if (tbKeyIsDown(38))or(tbKeyIsDown(87)) then  // move para cima - tecla W ou seta para cima
  begin
    if Helicoptero.Position.Y <= 10 then
    begin
      Helicoptero.Position.Y := 11;
      exit;
    end;
    Helicoptero.Position.Y := Helicoptero.Position.Y  - 2;
  end;
  MiniHelicoptero.Position.Y := (Helicoptero.Position.Y / ProporcaoY);
end;

procedure TFrm_Principal.FormCreate(Sender: TObject);
begin
  MediaPlayerHelicoptero.FileName := ExtractFileDir(ParamStr(0)) + '/Sounds/' + 'Helicoptero.mp3';
  MediaPlayerHelicoptero.Volume := 0.7;
  MediaPlayerHelicoptero.Play;

  ProporcaoY := (Frm_Principal.Height / HorzScrollBoxMiniatura.Height); // Variável com a proporção da altura para a miniatura
  MiniHelicoptero.Position.Y := (Helicoptero.Position.Y / ProporcaoY);  // Ajusta posição inicial da miniatura do helicóptero
end;

procedure TFrm_Principal.Loop_Audio;
begin
  if MediaPlayerHelicoptero.CurrentTime = MediaPlayerHelicoptero.Duration then
  begin
    MediaPlayerHelicoptero.CurrentTime := 0;
    MediaPlayerHelicoptero.Play;
  end;
end;

procedure TFrm_Principal.Timer_LoopPrincipalTimer(Sender: TObject);
begin
  ControleTeclado; // Verifica as teclas pressionadas
  Loop_Audio;      // Verifica se audio acabou e reinicia o audio
end;

end.




