clear;
clc;
%%
%inicialização das constantes
lambda=10^(-5);     %Taxa de ocorrência de falhas (upset/bit per day)
TDias=40000;        %Tempo em dias 

%%Quantidade de bits para dados para cada código
WMatrix=16;
WReed_Muller=16;
WHamming=16;
WCLC=16;
WExCLC=16;
WPHICC=16;
WMRSC=16;
WPHICC32=16;
WPHICC36=16;
WPHICC44=16;

%Quantidade de bits de redundância para cada código
CMatrix=16;
CReed_Muller=20;
CHamming=24;
CCLC=28;
CExCLC=24;
CPHICC=24;
CMRSC=16;
CPHICC32=16;
CPHICC36=20;
CPHICC44=28;

tempo=linspace(1, TDias,65); %amostragem do tempo
m=16;                %quantidade de palavras

%%
%Leitura dos dados de probabilidade de detecção ou de correção de falhas
%  load dadosDet.txt
%  dados = dadosDet;
load dadosCorrecao.txt
dados = dadosCorrecao;

%O valor da primeira coluna indica se é detecção ou correção

% 1: Detecção
% 2: Correção

% O valor da segunda coluna da matriz indica qual o código
% 1: Dados do Matrix
% 2: Dados do Reed Muller
% 3: Dados de Hamming
% 4: Dados do CLC
% 5: dados do extended CLC
% 6: PHICC(40,16)
% 7: MRSC
% 8: PHICC(32,16)
% 9: PHICC(36,16)
% 10: PHICC(44,16)

for l= 1:length(dados(:,1)) % Laço para a realização dos testes
    
    if dados(l,2)==1 
        PFDC_Matrix=zeros(8,1); 
        for col=3:length(dados(l,:))%leitura dos dados correspondentes ao Matrix
            PFDC_Matrix(col-2,1)=dados(l,col);
        end
        %coverage determina a cobertura de detecção ou correção em relação ao tempo
        fdc_Matrix = coverage(PFDC_Matrix,lambda,tempo, WMatrix, CMatrix);
        
        %Reliability e MTTF são calculados caso os dados sejam de correção      
        if dados(l,1)==2
            %reliability determina a confiabilidade no decorrer do tempo
            R_Matrix = reliability(PFDC_Matrix, lambda, tempo, WMatrix, CMatrix, m);
            %Cálculo do MTTF
            MTTF_matrix=mttf(PFDC_Matrix, lambda, TDias, WMatrix, CMatrix, m);
        end
        
    % As mesmas operações são feitas para os outros ECCs
    elseif dados(l,2)==2
        PFDC_Reed_Muller=zeros(8,1);
        for col=3:length(dados(l,:))%leitura dos dados correspondentes ao RM
            PFDC_Reed_Muller(col-2,1)=dados(l,col);
        end
        %coverage determina a cobertura de detecção ou correção em relação ao tempo
        fdc_Reed_muller = coverage(PFDC_Reed_Muller,lambda,tempo, WReed_Muller, CReed_Muller);
       
        if dados(l,1)==2
            %reliability determina a confiabilidade no decorrer do tempo
            R_Reed_Muller = reliability(PFDC_Reed_Muller, lambda, tempo, WReed_Muller, CReed_Muller, m);
            %Cálculo do MTTF
            MTTF_Reed_Muller=mttf(PFDC_Reed_Muller, lambda, TDias, WReed_Muller, CReed_Muller, m);
        end
    
    elseif dados(l,2)==3
        PFDC_Hamming=zeros(8,1);
        for col=3:length(dados(l,:))%leitura dos dados correspondentes ao Hamming
            PFDC_Hamming(col-2,1)=dados(l,col);
        end
        %coverage determina a cobertura de detecção ou correção em relação ao tempo
        fdc_Hamming = coverage(PFDC_Hamming,lambda,tempo, WHamming, CHamming);
        
        if dados(l,1)==2
            %reliability determina a confiabilidade no decorrer do tempo
            R_Hamming = reliability(PFDC_Hamming, lambda, tempo, WHamming, CHamming, m);
            %Cálculo do MTTF
            MTTF_Hamming=mttf(PFDC_Hamming, lambda, TDias, WHamming, CHamming, m);
        end
    
    elseif dados (l,2)==4
        PFDC_CLC = zeros(8,1);
        for col=3:length(dados(l,:)) %leitura dos dados correspondentes ao CLC
            PFDC_CLC(col-2,1)=dados(l,col);
        end
        %coverage determina a cobertura de detecção ou correção em relação ao tempo
        fdc_CLC = coverage(PFDC_CLC,lambda,tempo, WCLC, CCLC);
               
        if dados(l,1)==2
            %reliability determina a confiabilidade no decorrer do tempo
            R_CLC = reliability(PFDC_CLC, lambda, tempo, WCLC, CCLC, m);
            %Cálculo do MTTF
            MTTF_CLC=mttf(PFDC_CLC, lambda, TDias, WCLC, CCLC, m);
        end
        
    elseif dados (l,2)==5
        PFDC_ExCLC = zeros(8,1);
        for col=3:length(dados(l,:))%leitura dos dados correspondentes ao Extended CLC
            PFDC_ExCLC(col-2,1)=dados(l,col);
        end
        %coverage determina a cobertura de detecção ou correção em relação ao tempo
        fdc_ExCLC = coverage(PFDC_ExCLC,lambda,tempo, WExCLC, CExCLC);
        
        if dados(l,1)==2
            %reliability determina a confiabilidade no decorrer do tempo
            R_ExCLC = reliability(PFDC_ExCLC, lambda, tempo, WExCLC, CExCLC, m);
            %Cálculo do MTTF
            MTTF_ExCLC=mttf(PFDC_ExCLC, lambda, TDias, WExCLC, CExCLC, m);
        end
        
    elseif dados (l,2)==6
        PFDC_PHICC = zeros(8,1);
        for col=3:length(dados(l,:))%leitura dos dados correspondentes ao Extended CLC
            PFDC_PHICC(col-2,1)=dados(l,col);
        end
        %coverage determina a cobertura de detecção ou correção em relação ao tempo
        fdc_PHICC = coverage(PFDC_PHICC,lambda,tempo, WPHICC, CPHICC);
        
        if dados(l,1)==2
            %reliability determina a confiabilidade no decorrer do tempo
            R_PHICC = reliability(PFDC_PHICC, lambda, tempo, WPHICC, CPHICC, m);
            %Cálculo do MTTF
            MTTF_PHICC=mttf(PFDC_PHICC, lambda, TDias, WPHICC, CPHICC, m);
        end
        
    elseif dados (l,2)==7
        PFDC_MRSC = zeros(8,1);
        for col=3:length(dados(l,:))%leitura dos dados correspondentes ao Extended CLC
            PFDC_MRSC(col-2,1)=dados(l,col);
        end
        %coverage determina a cobertura de detecção ou correção em relação ao tempo
        fdc_MRSC = coverage(PFDC_MRSC,lambda,tempo, WMRSC, CMRSC);
        
        if dados(l,1)==2
            %reliability determina a confiabilidade no decorrer do tempo
            R_MRSC = reliability(PFDC_MRSC, lambda, tempo, WMRSC, CMRSC, m);
            %Cálculo do MTTF
            MTTF_MRSC=mttf(PFDC_MRSC, lambda, TDias, WMRSC, CMRSC, m);
        end

    elseif dados (l,2)==8
        PFDC_PHICC32 = zeros(8,1);
        for col=3:length(dados(l,:))%leitura dos dados correspondentes ao Extended CLC
            PFDC_PHICC32(col-2,1)=dados(l,col);
        end
        %coverage determina a cobertura de detecção ou correção em relação ao tempo
        fdc_PHICC32 = coverage(PFDC_PHICC32,lambda,tempo, WPHICC32, CPHICC32);
        
        if dados(l,1)==2
            %reliability determina a confiabilidade no decorrer do tempo
            R_PHICC32 = reliability(PFDC_PHICC32, lambda, tempo, WPHICC32, CPHICC32, m);
            %Cálculo do MTTF
            MTTF_PHICC32=mttf(PFDC_PHICC32, lambda, TDias, WPHICC32, CPHICC32, m);
        end

    elseif dados (l,2)==9
        PFDC_PHICC36 = zeros(8,1);
        for col=3:length(dados(l,:))%leitura dos dados correspondentes ao Extended CLC
            PFDC_PHICC36(col-2,1)=dados(l,col);
        end
        %coverage determina a cobertura de detecção ou correção em relação ao tempo
        fdc_PHICC36 = coverage(PFDC_PHICC36,lambda,tempo, WPHICC36, CPHICC36);
        
        if dados(l,1)==2
            %reliability determina a confiabilidade no decorrer do tempo
            R_PHICC36 = reliability(PFDC_PHICC36, lambda, tempo, WPHICC36, CPHICC36, m);
            %Cálculo do MTTF
            MTTF_PHICC36=mttf(PFDC_PHICC36, lambda, TDias, WPHICC36, CPHICC36, m);
        end
      
    elseif dados (l,2)==10
        PFDC_PHICC44 = zeros(8,1);
        for col=3:length(dados(l,:))%leitura dos dados correspondentes ao Extended CLC
            PFDC_PHICC44(col-2,1)=dados(l,col);
        end
        %coverage determina a cobertura de detecção ou correção em relação ao tempo
        fdc_PHICC44 = coverage(PFDC_PHICC44,lambda,tempo, WPHICC44, CPHICC44);
        
        if dados(l,1)==2
            %reliability determina a confiabilidade no decorrer do tempo
            R_PHICC44 = reliability(PFDC_PHICC44, lambda, tempo, WPHICC44, CPHICC44, m);
            %Cálculo do MTTF
            MTTF_PHICC44=mttf(PFDC_PHICC44, lambda, TDias, WPHICC44, CPHICC44, m);
        end
    end 
end

%%
%Gráficos
%Coverage
figure;
hold on
grid on

%plot(tempo, fdc_Matrix*100, '-r');
plot(tempo, fdc_Reed_muller*100,'-+m');
%plot(tempo, fdc_Hamming*100, '-db');
%plot(tempo, fdc_CLC*100, '-+b');
plot(tempo, fdc_ExCLC*100, '-+k');
plot(tempo, fdc_MRSC*100, '-+g');
plot(tempo, fdc_PHICC32*100, '-rv');
plot(tempo, fdc_PHICC36*100, '-bs');
plot(tempo, fdc_PHICC*100, '-+c');
plot(tempo, fdc_PHICC44*100, '-+y');

legend('Reed Muller','Extended CLC','MRSC','PHICC(32,16)','PHICC(36,16)','PHICC(40,16)','PHICC(44,16)',0);
axis ([0 40000 0 100]);
if dados(1,1)==1
    ylabel('Fault Detection (%)');
else
    ylabel('Fault Correction (%)');
end
xlabel('Time (day)');
hold off

%% Reliability
%
if dados(1,1)==2
    figure;
    hold on
    grid on

    %plot(tempo, R_Matrix, '-.r');
    plot(tempo, R_Reed_Muller, '-xm');
    % plot(tempo, R_Hamming, '-db');
    %plot(tempo, R_CLC, '-+b');
    plot(tempo, R_ExCLC, '-.k');
    plot(tempo, R_MRSC, '-dg');
    plot(tempo, R_PHICC32,'-+r');
    plot(tempo, R_PHICC36,'-hb');
    plot(tempo, R_PHICC,'-*c');
    plot(tempo, R_PHICC44,'-vy');

    legend('Reed Muller','Extended CLC','MRSC','PHICC(32,16)','PHICC(36,16)','PHICC(40,16)','PHICC(44,16)',0);
    
    if m==1
        axis ([0 40000 0 1]);
        ylabel('Reliability of a Word');
    else
        axis ([0 13000 0 1]);
        ylabel('Reliability of a Register File');
    end
    xlabel('Time (day)');
    hold off
end
