%Simulation
%of the total communication system
%By Senrui Chen
%main.main
%by Senrui Chen
%
%A test program. without Encryption, without Encryption.
%
M = 3;
m = 3;
N = 8001; %number of bits

Pt_list = [];
Ps_list = [];
enr_list = [-4:1:16];
ep = 1;%卷积码没法估算误码率
for enr = enr_list;
    err = 0;
    tot = 0;
    en = 10^(enr/10);
    
    %P_theo = 2/3*qfunc(sqrt(en*3*(1-2^-0.5)));
    % if(P_theo<5*10e-5)
        % break
    % end
    % ep = max(1,round(500/N/P_theo));%确保估计精确度
    
    for (ep_cnt = 1:ep)
        message = randi(2,1,N)-1;
        sstream = bits2syms(message,M,0,m);
        res = syms2bits(WaveChannel(sstream,M,m,enr),M,0,m);
        res = res(1:N);%卷积码可能有残留尾巴
        err = err + sum(abs(res - message));  
        tot = tot + N;
    end
    %Pt_list = [Pt_list,P_theo];
    Ps_list = [Ps_list,err/tot];
    %[enr err/tot P_theo]
    [enr err/tot]
    
    
    ep = max(ep,round(1000/N/(err/tot)))
    if(ep>80)
        break
    end
end
