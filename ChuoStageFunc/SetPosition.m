function res = SetPosition(s, x, y, z)
%SetPosition Set Position manually
%   �ڍא����������ɋL�q
res = SerialSend(s, sprintf("R:A%dB%dC%d",x,y,z));
end