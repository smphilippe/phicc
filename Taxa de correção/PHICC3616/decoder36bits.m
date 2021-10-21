%PHICC
%Decoder

function [x,y]= decoder(word)
%    word = [0 1 0 0 1 1 0 0 0;0 0 1 0 1 0 0 1 1;1 0 1 1 1 1 1 1 1;1 0 1 1 1 1 1 0 0];  
    y=0;
    data=zeros(4,4);
    spa=zeros(1,4);
    sp=zeros(1,4);
    spd=zeros(1,4);
    soma_spa=0;
    soma_sp=0;
    %1  2  3  4  5  6  7  8  9
    %10 11 12 13 14 15 16 17 18
    %19 20 21 22 23 24 25 26 27
    %28 29 30 31 32 33 34 35 36
    
  
    %% Calculo das sindromes
    for i=0:3
        %paridade de palavra
        spa(1,i+1)=xor(word(i+1,5),xor(word(i+1,1),xor(word(i+1,2),xor(word(i+1,3),word(i+1,4)))));
        %paridade de coluna
        sp(1,i+1)=xor(word(i+1,6),xor(word(1,i+1),xor(word(2,i+1),xor(word(3,i+1),word(4,i+1)))));
    end
    spa
    sp
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
        
    soma_sp=spa(1,i+1)+soma_sp;
    soma_sp=sp(1,i+1)+soma_sp;
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
        spd(1,i+1)=xor(word(i+1,9),xor(data(i+1,1),xor(data(i+1,2),xor(data(i+1,3),data(i+1,4)))));
        %sindrome de checkbits
        if spd(1,i+1)==1 && soma_sp~=0
            if xor(word(i+1,7),(xor(data(i+1,1),data(i+1,2))))==1 && xor(word(i+1,8),(xor(data(i+1,1),data(i+1,3))))==1
                data(i+1,1)=~data(i+1,1);
            elseif xor(word(i+1,7),(xor(data(i+1,1),data(i+1,2))))==1 && xor(word(i+1,9),(xor(word(i+1,8),(xor(data(i+1,2),data(i+1,4))))))==1
                data(i+1,2)=~data(i+1,2);
            elseif xor(word(i+1,9),(xor(word(i+1,7),(xor(data(i+1,3),data(i+1,4))))))==1 && xor(word(i+1,8),(xor(data(i+1,1),data(i+1,3))))==1
                data(i+1,3)=~data(i+1,3);
            elseif xor(word(i+1,9),(xor(word(i+1,7),(xor(data(i+1,3),data(i+1,4))))))==1 && xor(word(i+1,9),(xor(word(i+1,8),(xor(data(i+1,2),data(i+1,4))))))==1
                data(i+1,4)=~data(i+1,4);
            end
        end
    x=data;
    end
end