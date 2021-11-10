unit UntMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, System.Types, Math, UntInCircle,
  Vcl.ComCtrls, Vcl.Samples.Spin, UntAllFunctions, JPEG;

type
  TFrmMain = class(TForm)
    ScrollBox1: TScrollBox;
    ImgMain: TImage;
    Panel1: TPanel;
    SPEScale: TSpinEdit;
    BtnDraw: TButton;
    Label1: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnDrawClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    imageCPt:  TFloatPoint;
    intOutCircleInRadius, intOutCircleOutRadius: integer;
    inCircle: TInCircleType;

    procedure drawOutCircle();
    procedure clearBitmap();
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

procedure TFrmMain.BtnDrawClick(Sender: TObject);
var
   cnt:  integer;
//   jpegImage: TJPEGImage;
begin
   clearBitmap();
   drawOutCircle();

//   jpegImage := TJPEGImage.create();
//   jpegImage.CompressionQuality := 50;

   ImgMain.Picture.Bitmap.Canvas.Pen.Mode := pmNotXor;
   ImgMain.Picture.Bitmap.Canvas.Brush.Style := bsClear;

   inCircle.setPtOnCircle(SPEScale.Value / 10);
   inCircle.circleDraw();

   for cnt := 0 to 2525 div 5 do begin
      inCircle.circleRotate(5);
      ImgMain.refresh();

//      jpegImage.Assign(ImgMain.Picture.Bitmap);
//      jpegImage.SaveToFile('D:\Work\Delphi\Samples\CircleOrbit\Images\' + FormatFloat('0000', cnt) + '.jpg');

      sleep(10);
   end;
//   ImgMain.refresh();
//   freeAndNil(jpegImage);
end;

procedure TFrmMain.clearBitmap();
begin
   ImgMain.Picture.Bitmap.Canvas.brush.Style := bsSolid;
   ImgMain.Picture.Bitmap.Canvas.brush.Color := clBlack;
   ImgMain.Picture.Bitmap.Canvas.FillRect(ImgMain.ClientRect);
end;

procedure TFrmMain.drawOutCircle();
var
   cnt: integer;
   rValue: single;
   rPt: TFloatPoint;
begin
   ImgMain.Picture.Bitmap.Canvas.Pen.Color := clYellow;
   ImgMain.Picture.Bitmap.Canvas.Pen.Mode := pmCopy;

   for cnt := 0 to 180 do begin
      if (cnt mod 2 = 0) then rValue := intOutCircleInRadius + 5
      else rValue := intOutCircleInRadius - 5;

      rPt.X := imageCPt.X + (rValue * cos(degTorad(cnt * 2)));
      rPt.Y := imageCPt.Y + (rValue * sin(degTorad(cnt * 2)));

      if (cnt = 0) then ImgMain.Picture.Bitmap.Canvas.MoveTo(round(rPt.X), round(rPt.Y))
      else ImgMain.Picture.Bitmap.Canvas.LineTo(round(rPt.X), round(rPt.Y));
   end;

   ImgMain.Picture.Bitmap.Canvas.Pen.Color := clRed;
   ImgMain.Picture.Bitmap.Canvas.Pen.Mode := pmNotXor;
end;

procedure TFrmMain.FormActivate(Sender: TObject);
var
   inRadius:   integer;
begin
   ImgMain.Picture.Bitmap.Canvas.Brush.Color := clBlack;
   ImgMain.Picture.Bitmap.Width := ImgMain.Width;
   ImgMain.Picture.Bitmap.Height := ImgMain.Height;
   ImgMain.Picture.Bitmap.Canvas.Pen.width := 3;

   imageCPt := getFloatPoint(ImgMain.Picture.Bitmap.Width / 2, ImgMain.Picture.Bitmap.Height / 2);

   intOutCircleInRadius := 300;
   intOutCircleOutRadius := 500;

   drawOutCircle();

   inRadius := 140;
   inCircle := TInCircleType.create(ImgMain.Picture.Bitmap, getFloatPoint(imageCPt.X + (intOutCircleInRadius - inRadius), imageCPt.Y),
                                    imageCPt, inRadius, intOutCircleInRadius);
   inCircle.setPtOnCircle(SPEScale.Value / 10);
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
   ReportMemoryLeaksOnShutdown := true;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
   freeAndNil(inCircle);
end;

end.
