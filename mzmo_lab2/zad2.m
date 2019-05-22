pkt = 'b'

if pkt == 'a'
    % %2.a
    % %-----------------------
    Kp = 1.14;
    Ki = 0.454;
    C = pid(Kp,Ki);
    s = tf('s');
    P = 1/(s+1)^3;
    F = 1;
    %-----------------------
    L = C*P*F;
    Te = 1/(1+L);
    Tu = C/(1+L);
    Ty = C*P/(1+L);
    figure(1)
    hold on;
    step(Te);
    step(Tu);
    step(Ty);
    hold off;
    
    %-----------------------
    
    E = AnalysisPoint('e');
    U = AnalysisPoint('u');
    Y = AnalysisPoint('y');
    
    T = feedback(Y*P*U*C*E,F);
    T.InputName = 'r';
    T.OutputName = 'y';
    
    Te_ = getIOTransfer(T,'r','e');
    Tu_ = getIOTransfer(T,'r','u');
    Ty_ = getIOTransfer(T,'r','y');
    
    figure(2)
    hold on;
    step(Te_);
    step(Tu_);
    step(Ty_);
    hold off;
end

if pkt == 'b'
    %2.b
    %-----------------------
    C = tunablePID('tpid','PID');
    C.Kp.Value = 6;        % initialize Kp to 4
    C.Ki.Value = 0;
    C.Kd.Value = 30;      % initialize Kd to 0.7
    
    s = tf('s');
    P = 1/((s+1)*(s+1.2)*(s+2));
    F = 1;
    
    Y = AnalysisPoint('y');
    
    T = feedback(Y*P*C,F);
    %T.InputName = 'r';
    %T.OutputName = 'y_';
    
    %Ty_ = getIOTransfer(T,'r','y_');
    req3 = TuningGoal.Margins('y',7,45);
    figure(1)
    viewGoal(req3,T)
    figure(2)
    step(T);
    figure(3)
    margin(T)
    
    [a,b]=systune(T,req3,req3);
    figure(4)
    step(a);
    figure(5)
    viewGoal(req3,a)
    figure(6)
    margin(a)
end
