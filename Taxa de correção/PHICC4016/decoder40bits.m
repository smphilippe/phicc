%PHICC
%Decoder

function [x,y]= decoder(word)
   
    y=0;
    data=zeros(4,4);
    spa=zeros(1,4);
    sp=zeros(1,4);
    spd=zeros(1,4);
    scb=zeros(4,3);
    soma_spa=0;
    soma_sp=0;
    soma_spd=0;
    soma_scb=0;
    A=[0 0 1 1];
    B=[0 1 1 0];
    C=[1 1 0 0];
    
    %1  2  3  4  5  6  7  8
    %9  10 11 12 13 14 15 16
    %17 18 19 20 21 22 23 24
    %25 26 27 28 29 30 31 32
    %33 34 35 36 37 38 39 40
    
  
    %% Calculo das sindromes
    for i=0:3
        %paridade de palavra
        spa(1,i+1)=xor(word(i+1,5),xor(word(i+1,1),xor(word(i+1,2),xor(word(i+1,3),word(i+1,4)))));
        %paridade de coluna
        sp(1,i+1)=xor(word(5,i+1),xor(word(1,i+1),xor(word(2,i+1),xor(word(3,i+1),word(4,i+1)))));

        soma_spa=spa(1,i+1)+soma_spa;
        soma_sp=sp(1,i+1)+soma_sp;
    end
    
    %% primeiro processo de correcao
    % utilizacao dos bits de paridade
    
    % Os erros detectados são corrigidos antes do processo de 
    % desembaralhamento atraves do cruzamento das posicoes dos
    % bits cujas sindromes resultaram em 1
    for i=0:3
        if spa(1,i+1)==1
            for j=0:3
                if sp(1,j+1)==1
                    word(i+1,j+1)=~word(i+1,j+1);
                end
            end
        end    
    end

    
    %% desembaralhamento dos bits de dados
    data(1,1)=word(1,1);
    data(1,2)=word(3,1);
    data(1,3)=word(1,3);
    data(1,4)=word(3,3);
    
    data(2,1)=word(2,2);
    data(2,2)=word(4,2);
    data(2,3)=word(2,4);
    data(2,4)=word(4,4);
    
    data(3,1)=word(2,1);
    data(3,2)=word(4,1);
    data(3,3)=word(2,3);
    data(3,4)=word(4,3);
    
    data(4,1)=word(1,2);
    data(4,2)=word(3,2);
    data(4,3)=word(1,4);
    data(4,4)=word(3,4);
    
    %% Calculo das sindromes de paridade
    for i=0:3
        %paridade de dados
        spd(1,i+1)=xor(word(5,i+5),xor(data(i+1,1),xor(data(i+1,2),xor(data(i+1,3),data(i+1,4)))));
        %sindrome de checkbits
        scb(i+1,1)= xor(word(i+1,6),xor(data(i+1,2),xor(data(i+1,3),data(i+1,4))));
        scb(i+1,2)= xor(word(i+1,7),xor(data(i+1,1),xor(data(i+1,3),data(i+1,4))));
        scb(i+1,3)= xor(word(i+1,8),xor(data(i+1,1),xor(data(i+1,2),data(i+1,4))));
        
        soma_spd=spd(1,i+1)+soma_spd;
    end
    
    %% Segundo processo de correção
    %utilizacao dos check bits ocorrera dependendo da condicao
    
    if soma_spd~=0
    %utilização do codigo de hamming
        for i= 0:3
            if scb(i+1,1)==0 && scb(i+1,2)==1 && scb(i+1,3)==1 
                    data(i+1,1)=~data(i+1,1);
                    soma_scb=soma_scb+1;
            elseif scb(i+1,1)==1 && scb(i+1,2)==0 && scb(i+1,3)==1 
                    data(i+1,2)=~data(i+1,2);
                    soma_scb=soma_scb+1;
            elseif scb(i+1,1)==1 && scb(i+1,2)==1 && scb(i+1,3)==0
                    data(i+1,3)=~data(i+1,3);
                    soma_scb=soma_scb+1;                    
            elseif scb(i+1,1)==1 && scb(i+1,2)==1 && scb(i+1,3)==1
                    data(i+1,4)=~data(i+1,4);
                    soma_scb=soma_scb+1;                    
            end
        end
    end
    x=data;
    
    %% Deteccao do numero de falhas
    
    if(soma_spa==1 && soma_sp==1 && soma_spd==0 && soma_scb==0)
        y=1;
    elseif (soma_spd==2 && soma_scb==2)
        y=2;
    elseif(soma_spa==3 || soma_sp==3)
        y=3;
    elseif ((soma_spa==0 && soma_sp==0 && soma_spd==4 && soma_scb==4) || (soma_spd==2 && soma_scb==3))
        y=4;
    elseif((soma_spa==1 && soma_sp==1 && soma_spd==4 && soma_scb==4)||(soma_spd==0 && soma_scb==3))
        y=5;
    elseif((soma_spa==2 || soma_sp==2) && soma_spd==4 && soma_scb==4)
        y=6;
    end
        

end
