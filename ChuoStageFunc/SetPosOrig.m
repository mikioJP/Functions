function res = SetPosOrig(s)
%SetPosition Set Position manually
%   �ڍא����������ɋL�q
    res = SerialSend(s, sprintf("R:A%dB%dC%d", 0, 0, 0));
end