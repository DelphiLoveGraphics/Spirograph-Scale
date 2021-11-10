unit UntInCircle;

interface

uses Vcl.Graphics, System.Types, Math, UntAllFunctions, Classes, SysUtils;

type TInCircleType = class
   private
      drawBitmap:                TBitmap;
      cPtCircle:                 TFloatPoint;
      cPtOutcircle:              TFloatPoint;
      intRadius, intOutRadius:   integer;
      ptCircles: Array[1..2] of  TFloatPoint;
      borderPtList:              TList;

      function ptRotate(pt, oldPtCenter, newPtCenter: TFloatPoint; sAngle: single): TFloatPoint;
      procedure lineDraw(ptStart, ptEnd: TFloatPoint);
      procedure generateBorderPtList();
      procedure rotateBorderPtList(oldPtCenter, newPtCenter: TFloatPoint; deg: single);
   public
      constructor create(bmp: TBitmap; ptCenter, outPtCenter: TFloatPoint; iRadius, oRadius: integer);
      destructor destroy(); override;

      procedure setInRadius(iRadius: integer);
      procedure circleRotate(deg: single);
      procedure circleDraw();
      procedure setPtOnCircle(fScale: single);

end;

implementation

{ TInCircleType }

constructor TInCircleType.create(bmp: TBitmap; ptCenter, outPtCenter: TFloatPoint; iRadius, oRadius: integer);
begin
   drawBitmap := bmp;
   cPtCircle := ptCenter;
   cPtOutcircle := outPtCenter;
   intRadius := iRadius;
   intOutRadius := oRadius;

   ptCircles[1] := getFloatPoint(cPtCircle.X + (intRadius * 0.3), cPtCircle.Y);

   borderPtList := TList.create();
   generateBorderPtList();
end;

destructor TInCircleType.destroy();
var
   iCnt:  integer;
   PPoint: PFloatPoint;
begin
   inherited;

   for iCnt := 0 to borderPtList.Count - 1 do begin
      PPoint := borderPtList.Items[iCnt];
      dispose(PPoint);
   end;
   borderPtList.clear();
   freeAndNil(borderPtList);
end;

procedure TInCircleType.circleDraw();
var
   iCnt, ptRadius:   integer;
   PPoint:           PFloatPoint;
begin
   for iCnt := 0 to borderPtList.Count - 1 do begin
      PPoint := borderPtList.items[iCnt];

      if (iCnt = 0) then drawBitmap.Canvas.MoveTo(round(PPoint.X), round(PPoint.Y))
      else drawBitmap.Canvas.LineTo(round(PPoint.X), round(PPoint.Y));
   end;

   ptRadius := 4;

   drawBitmap.Canvas.Ellipse(round(ptCircles[1].X - ptRadius),
                             round(ptCircles[1].Y - ptRadius),
                             round(ptCircles[1].X + ptRadius),
                             round(ptCircles[1].Y + ptRadius));
   drawBitmap.Canvas.Ellipse(round(ptCircles[2].X - ptRadius),
                             round(ptCircles[2].Y - ptRadius),
                             round(ptCircles[2].X + ptRadius),
                             round(ptCircles[2].Y + ptRadius));

   drawBitmap.Canvas.MoveTo(round(ptCircles[1].X),
                            round(ptCircles[1].Y));
   drawBitmap.Canvas.LineTo(round(ptCircles[2].X),
                            round(ptCircles[2].Y));
end;

procedure TInCircleType.generateBorderPtList();
var
   iCnt:    integer;
   rValue:  single;
   PPoint:  PFloatPoint;
begin
   for iCnt := 0 to 90 do begin
      if (iCnt mod 2 = 0) then rValue := intRadius + 5
      else rValue := intRadius - 5;

      new(PPoint);
      PPoint.X := cPtCircle.X + (rValue * cos(degTorad(iCnt * 4)));
      PPoint.Y := cPtCircle.Y + (rValue * sin(degTorad(iCnt * 4)));
      borderPtList.Add(PPoint);
   end;
end;

procedure TInCircleType.rotateBorderPtList(oldPtCenter, newPtCenter: TFloatPoint; deg: single);
var
   iCnt:    integer;
   PPoint:  PFloatPoint;
   rPt:     TFloatPoint;
begin
   for iCnt := 0 to borderPtList.Count - 1 do begin
      PPoint := borderPtList.Items[iCnt];
      rPt := ptRotate(PPoint^, oldPtCenter, newPtCenter, deg);
      PPoint^ := rPt;
   end;
end;

procedure TInCircleType.circleRotate(deg: single);
var
   iCnt: integer;
   sngInDeg, outRLength:  single;
   oldPtCenter, oldPtOnCircle:  TFloatPoint;
begin
   drawBitmap.Canvas.Pen.Mode := pmNotXor;
   circleDraw();

   oldPtOnCircle := ptCircles[1];
   oldPtCenter := cPtCircle;
   cPtCircle := ptRotate(cPtCircle, cPtOutcircle, cPtOutcircle, deg);

   outRLength := DegToRad(deg) * intOutRadius;
   sngInDeg := RadToDeg(outRLength / intRadius);

   for iCnt := 1 to 2 do begin
      ptCircles[iCnt] := ptRotate(ptCircles[iCnt], oldPtCenter, cPtCircle, -sngInDeg);
   end;
   rotateBorderPtList(oldPtCenter, cPtCircle, -deg);

   drawBitmap.Canvas.Pen.Mode := pmCopy;
   lineDraw(oldPtOnCircle, ptCircles[1]);

   drawBitmap.Canvas.Pen.Mode := pmNotXor;
   circleDraw();
end;

procedure TInCircleType.setInRadius(iRadius: integer);
begin
   intRadius := iRadius;
end;

procedure TInCircleType.setPtOnCircle(fScale: single);
begin
   ptCircles[1] := getFloatPoint(cPtCircle.X + (intRadius * fScale), cPtCircle.Y);
   ptCircles[2] := getFloatPoint(cPtCircle.X - (intRadius * fScale), cPtCircle.Y);
end;

procedure TInCircleType.lineDraw(ptStart, ptEnd: TFloatPoint);
begin
   drawBitmap.Canvas.MoveTo(round(ptStart.X), round(ptStart.Y));
   drawBitmap.Canvas.LineTo(round(ptEnd.X), round(ptEnd.Y));
end;

function TInCircleType.ptRotate(pt, oldPtCenter, newPtCenter: TFloatPoint; sAngle: single): TFloatPoint;
begin
   result.X := newPtCenter.X + ((pt.X - oldPtCenter.X) * cos(DegToRad(sAngle)) - (pt.Y - oldPtCenter.Y) * sin(DegToRad(sAngle)) );
   result.Y := newPtCenter.Y + ((pt.X - oldPtCenter.X) * sin(DegToRad(sAngle)) + (pt.Y - oldPtCenter.Y) * cos(DegToRad(sAngle)) );
end;

end.
