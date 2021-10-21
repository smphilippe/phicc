%PHICC (32,16)
%Decoder
function [x,y]= decoder(word)
   % temp = [0 0 1 0 0 1 1 1;0 0 0 1 0 0 0 0;1 1 1 1 1 1 1 1;0 1 0 1 1 1 1 1]; 
    
    temp=word;
    word(1:2,1)=temp(1:2,2);
    word(1:2,2)=temp(1:2,1);
    word(1:2,3)=temp(1:2,4);
    word(1:2,4)=temp(1:2,3);
    y=0;
    data=zeros(4,4);
    spl=zeros(1,4);
    spc=zeros(1,4);
    pd=zeros(1,4);
    spd=zeros(1,4);
    soma_spa=0;
    soma_sp=0;
    sv=zeros(4,1);
    sv_flag=0;
    CB=zeros(4,2);
    SCB=zeros(4,2);
    
    %1  2  3  4 | 5 | 6  7 | 8
    %9  10 11 12| 13| 14 15| 16
    %17 18 19 20| 21| 22 23| 24
    %25 26 27 28| 29| 30 31| 32
    
  
    %% Calculo das sindromes de verificação
    sv(1,1)=xor(word(1,8),(xor(word(3,5),(xor(word(1,6),word(3,7))))));
    sv(2,1)=xor(word(2,8),(xor(word(4,5),(xor(word(2,6),word(4,7))))));
    sv(3,1)=xor(word(3,8),(xor(word(1,5),(xor(word(3,6),word(1,7))))));
    sv(4,1)=xor(word(4,8),(xor(word(2,5),(xor(word(4,6),word(2,7))))));
    sv
    sv_flag= sv(1,1)|sv(2,1)|sv(3,1)|sv(1,1);
    sv_flag
%%
%verificação da condição  
    %paridade de linha
    spl(1,1)= (xor(word(3,7),(xor(word(1,7),xor(word(1,1),xor(word(1,2),xor(word(1,3),word(1,4))))))));
    spl(1,2)= (xor(word(2,7),(xor(word(4,7),xor(word(2,1),xor(word(2,2),xor(word(2,3),word(2,4))))))));
    spl(1,3)= (xor(word(3,5),(xor(word(1,5),(xor(word(3,7),(xor(word(1,7),xor(word(3,1),xor(word(3,2),xor(word(3,3),word(3,4))))))))))));
    spl(1,4)= (xor(word(2,5),(xor(word(4,5),(xor(word(4,7),(xor(word(2,7),xor(word(4,1),xor(word(4,2),xor(word(4,3),word(4,4))))))))))));

    %paridade de coluna
    spc(1,1)= (xor(word(2,6),(xor(word(1,6),xor(word(1,1),xor(word(2,1),xor(word(3,1),word(4,1))))))));
    spc(1,2)= (xor(word(4,6),(xor(word(3,6),xor(word(1,2),xor(word(2,2),xor(word(3,2),word(4,2))))))));
    spc(1,3)= (xor(word(3,5),(xor(word(4,5),(xor(word(2,6),(xor(word(1,6),xor(word(1,3),xor(word(2,3),xor(word(3,3),word(4,3))))))))))));
    spc(1,4)= (xor(word(1,5),(xor(word(2,5),(xor(word(4,6),(xor(word(3,6),xor(word(1,4),xor(word(2,4),xor(word(3,4),word(4,4))))))))))));

    spl
    spc
    %% primeiro processo de correcao
    % utilizacao dos bits de paridade
    
    % Os erros detectados são corrigidos antes do processo de 
    % desembaralhamento atraves do cruzamento das posicoes dos
    % bits cujas sindromes resultaram em 1
   if sv_flag==0
        for i=0:3
            if spl(1,i+1)==1
                for j=0:3
                    if spc(1,j+1)==1
                        word(i+1,j+1)=~word(i+1,j+1);
                        word(i+1,j+1)
                    end
                end
            end

        soma_sp=spl(1,i+1)+soma_sp;
        soma_sp=spc(1,i+1)+soma_sp;
        end
   end
        
    %% desembaralhamento dos bits de dados
    data(1,1)=word(1,1);
    data(1,2)=word(3,1);
    data(1,3)=word(1,3);
    data(1,4)=word(3,3);

    data(2,1)=word(2,1);
    data(2,2)=word(4,1);
    data(2,3)=word(2,3);
    data(2,4)=word(4,3);

    data(3,1)=word(1,2);
    data(3,2)=word(3,2);
    data(3,3)=word(1,4);
    data(3,4)=word(3,4);

    data(4,1)=word(2,2);
    data(4,2)=word(4,2);
    data(4,3)=word(2,4);
    data(4,4)=word(4,4);

    CB(1,1)=word(1,6);
    CB(1,2)=word(3,7);
    CB(2,1)=word(2,6);
    CB(2,2)=word(4,7);
    CB(3,1)=word(3,6);
    CB(3,2)=word(1,7);
    CB(4,1)=word(4,6);
    CB(4,2)=word(2,7);

    pd(1,1)=word(3,5);
    pd(2,1)=word(4,5);
    pd(3,1)=word(1,5);
    pd(4,1)=word(2,5);

    %CB       
    %% Calculo das sindromes de paridade

        for i=0:3
            %paridade de dados
            spd(1,i+1)=xor(pd(i+1,1),xor(data(i+1,1),xor(data(i+1,2),xor(data(i+1,3),data(i+1,4)))));
            %sindrome de checkbits
            SCB(i+1,1)=xor(CB(i+1,1),(xor(data(i+1,1),data(i+1,2))));
            SCB(i+1,2)=xor(CB(i+1,2),(xor(data(i+1,1),data(i+1,3))));
            
     %% Decodificação
            if spd(1,i+1)==1 && sv(i+1,1)==0
                if SCB(i+1,1)==1 && SCB(i+1,2)==1
                    data(i+1,1)=~data(i+1,1);%correto
                elseif SCB(i+1,1)==1 && SCB(i+1,2)==0
                    data(i+1,2)=~data(i+1,2);%correto
                elseif SCB(i+1,1)==0 && SCB(i+1,2)==1
                    data(i+1,3)=~data(i+1,3);
                elseif SCB(i+1,1)==0 && SCB(i+1,2)==0
                    data(i+1,4)=~data(i+1,4);
                end
            end
        end
       %spd
       SCB
    x=data;
end