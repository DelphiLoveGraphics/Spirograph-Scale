unit UntAllFunctions;

interface

type TFloatPoint = record
   X: single;
   Y: single;
end;
PFloatPoint = ^TFloatPoint;

function getFloatPoint(X, Y: single): TFloatPoint;

implementation

function getFloatPoint(X, Y: single): TFloatPoint;
begin
   result.X := X;
   result.Y := Y;
end;


end.
