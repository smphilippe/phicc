%C�lculo de MTTF
% 
%mttf(PFC, lambda, w, c)
% 
%PFC: Probabilidade de corre��o de falha
% lambda    Taxa de ocorr�ncia de falhas (upset/bit per day)
% w         Quantidade de bits para dados
% c         Quantidade de bits de redund�ncia

function MTTF = mttf(PFC, lambda, TDias, w, c, m)

    delta=10;% intervalo entre os pontos utilizados para integra��o
    tempo= 0:delta:TDias;
    PiF = zeros(length(PFC),length(tempo));
    aux = zeros(length(PFC), length(tempo));
    PMF = zeros(1,length(tempo));
    areas = zeros(1,length(tempo)-1);
         
    for t = 1:length(tempo)
        PMF(1,t)=1-exp(-lambda*(w+c)*tempo(t)); %Probabilidade de falha na mem�ria
        for p = 1:8
            %Probabilidade da ocorrencia de i falhas
            PiF(p,t) = nchoosek(w+c,p)*((1-exp(-lambda*(tempo(t)))).^p)*exp(-lambda*(w+c-p)*(tempo(t)));
            aux(p,t)=PiF(p,t)*PFC(p,1);
        end    
    end
    PNE=1-PMF; %Probabilidade de n�o haver erro
    R= (PNE + sum(aux,1)).^m;  %C�uculo de confiabilidade
    

    for n=1:length(tempo)
        %areas(1,n)=(R(1,n)+R(1,n+1))*delta/2;  Regra dos trap�zios
        %Regra de Simpson
        if n==1||n==length(tempo)
            areas(1,n)=R(1,n);
        elseif mod(n,2)==1 && n~=1
            areas (1,n)=R(1,n)*2;
        elseif mod(n,2)~=1 && n~=length(tempo)
            areas (1,n)=R(1,n)*4;
        end
           
    end
    
    MTTF= sum(areas,2)*delta/3;
end