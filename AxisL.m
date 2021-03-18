function [F]=AxisL(y1,y2,x1,x2,x)
F=(y1*x-y2*x+x1*y2-x2*y1)/(x1-x2);
end