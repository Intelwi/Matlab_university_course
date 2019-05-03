G2 = zpk([],-2,3);
G1 = zpk([],[-1 -1 -1],10);
C20 = tunablePID('C2','pi');
C10 = tunablePID('C1','pid');
X1 = AnalysisPoint('X1');
X2 = AnalysisPoint('X2');
InnerLoop= feedback(X2*G2*C20,1);
CL0 = feedback(G1*InnerLoop*C10,X1);
CL0.InputName = 'r';
CL0.OutputName = 'y';

Rtrack= TuningGoal.Tracking('r','y',10,0.01);
Rreject= TuningGoal.Gain('X2','y',0.1);
[CL,fSoft] = systune(CL0,[Rtrack,Rreject])