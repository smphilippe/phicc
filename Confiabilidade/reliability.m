%Cálculo de confiabilidade
%
%reliability(PFC, lambda, tempo, w, c, m)
%
%PFC: Probabilidade de correção de falha
% lambda    Parâmetro da distribuição de poisson
% w         Quantidade de bits para dados
% c         Quantidade de bits de redundância
% m         quantidade de palavras

function Reliability= reliability(PFC, lambda, tempo, w, c, m)
    PiF = zeros(length(PFC),length(tempo));
    aux = zeros(length(PFC), length(tempo));
    PMF = zeros(1,length(tempo));
    
    for t = 1:length(tempo)
        PMF(1,t)=1-exp(-lambda*(w+c)*tempo(t)); %Probabilidade de falha na memória
        for p = 1:8
            %Probabilidade da ocorrencia de i falhas
            PiF(p,t) = nchoosek(w+c,p)*((1-exp(-lambda*(tempo(t)))).^p)*exp(-lambda*(w+c-p)*(tempo(t)));
            aux(p,t)=PiF(p,t)*PFC(p,1);
        end    
    end
    PNE=1-PMF; %Probabilidade de não haver erro
    Reliability = (PNE + sum(aux,1)).^m;
end