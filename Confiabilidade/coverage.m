% Cobertura de correção ou detecção de falhas
% PFDC      Probabilidade de detecção ou correção de falha
% lambda    Parâmetro da distribuição de poisson
% TDias     tempo em dias 
% w         Quantidade de bits para dados
% c         Quantidade de bits de redundância


function Coverage = coverage(PFDC, lambda, tempo, w, c)
    PiF = zeros(length(PFDC),length(tempo));     %Probabilidade de i erros
    PMF = zeros(1,length(tempo));               %Probabilidade de falha na memória
    aux = zeros(length(PFDC), length(tempo));    %variável auxiliar
     
    for t = 1:length(tempo)                     
        PMF(1,t)=1-exp(-lambda*(w+c)*tempo(t)); %Probabilidade de falha na memória

        for p = 1:length(PFDC)
            %Probabilidade da ocorrencia de i falhas
            PiF(p,t) = nchoosek(w+c,p)*((1-exp(-lambda*(tempo(t)))).^p)*exp(-lambda*(w+c-p)*(tempo(t)));
            aux(p,t)=PFDC(p,1).*(PiF(p,t)/PMF(1,t)); %cálculo da capacidade de detecção de falhas
        end    
    end
        Coverage = sum(aux,1);
end

