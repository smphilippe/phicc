function z=Localdetestesnovo3interleaving(num_falhas,num_testes)%%% olhar unique
%Gerar a palavra de 16 bits para ser codificada


        Numcertos=0;
        Numerrados=0;
        Numdetecs=0;
        numtestes=0;
    for i= 1:num_testes
        entrada=round(rand(4))
        pcode=zeros(5,8);
        perros=zeros(1,40);
        pcode=encoder(entrada)
%         pcode=CodificadorCLC(entrada)
        pcode=reshape(pcode',1,40);%%converte a matriz
        %para vetor, assim fica mais f�cil inserir os erros 
        perros=pcode;
        mperros=zeros(5,8);%matriz de erros
        %%inserir tipos de falhas dependendo do n�mero inserido
        switch num_falhas
            case 1
                flag='Erro em um bit'
                poserro=randi(40,1,1)%%posi��o do erro randomicamente escolhida
                perros(poserro)=~perros(poserro);
                for lin=0:4
                    for col=1:8
                    mperros(lin+1,col)=perros(8*lin+col);
                    end
                end
            vet=[poserro];
            vetunique=unique(vet);
            case 2
                %%1  2  3  4  5  6  7  8
                %%9  10 11 12 13 14 15 16
                %%17 18 19 20 21 22 23 24
                %%25 26 27 28 29 30 31 32
                %%33 34 35 36 37 38 39 40
                
                %%  3     5    11    12    20

%%%%%%%%%%%%%%%%%%%%%%%%%%%%tabela1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                flag='Erro em dois bits adjacentes'
                vp=[-9 -8 -7 -1 1 7 8 9]; %%vp(round((length(vp)-1)*rand(1,1))+1) me dar� um elemento aleat�rio que representaria a posi��o onde a matriz teria o segundo erro
                %% esse vetor contem a diferen�a de posi��es adjacentes de poserro,que ser� onde o segundo erro ira saltar
                %%poserro=randi(40,1,1)%%posi��o do erro randomicamente escolhida
                poserro = round(39*rand(1,1))+1
                for i=2:7
                    if(poserro==i)
                        vp=[-1 1 7 8 9];
                    elseif(poserro==32+i)
                        vp=[-1 1 -9 -8 -7];
                    end
                end
                for i=1:5
                    if(poserro==(i-1)*8 +1)
                        if(poserro==1)
                            vp=[1 8 9];
                        elseif(poserro==33)
                            vp=[1 -8 -7];
                        else
                            vp=[1 -8 8 9 -7]; 
                        end
                    elseif(poserro==i*8)
                        if(poserro==8)
                            vp=[-1 7 8];
                        elseif(poserro==40)
                            vp=[-1 -9 -8];
                       
                        else
                            vp=[-1 -8 -9 7 8];
                        end
                    end
                end
                %%perros(poserro)=~perros(poserro);
                num=vp(round((length(vp)-1)*rand(1,1))+1)
                %% atribui o valor aleat�rio para o segundo erro                 
                poserro2 = poserro + num
                
                vet=[poserro poserro2]
                vetunique=unique(vet)
                if(length(vet)==length(vetunique))
                    vetorcorreto=entrada
                    perros(poserro)=~perros(poserro);
                    perros(poserro2)=~perros(poserro2);
                    for lin=0:4
                        for col=1:8
                        mperros(lin+1,col)=perros(8*lin+col);
                        end
                    end
                    numtestes=numtestes+1
                end

            case 3
                flag='Erro em tr�s bits adjacentes'
                vp=[-9 -8 -7 -1 1 7 8 9]; %%vp(round((length(vp)-1)*rand(1,1))+1) me dar� um elemento aleat�rio que representaria a posi��o onde a matriz teria o segundo erro
                %% esse vetor contem a diferen�a de posi��es adjacentes de poserro,que ser� onde o segundo erro ira saltar
                %%poserro=randi(40,1,1)%%posi��o do erro randomicamente escolhida
                poserro = round(39*rand(1,1))+1
                %%perros(poserro)=~perros(poserro);
                for i=2:7
                    if(poserro==i)
                        vp=[-1 1 7 8 9];
                    elseif(poserro==32+i)
                        vp=[-1 1 -9 -8 -7];
                    end
                end
                for i=1:5
                    if(poserro==(i-1)*8 +1)
                        if(poserro==1)
                            vp=[1 8 9];
                        elseif(poserro==33)
                            vp=[1 -8 -7];
                        else
                            vp=[1 -8 8 9 -7]; 
                        end
                    elseif(poserro==i*8)
                        if(poserro==8)
                            vp=[-1 7 8];
                        elseif(poserro==40)
                            vp=[-1 -9 -8];
                       
                        else
                            vp=[-1 -8 -9 7 8];
                        end
                    end
                end
                num=vp(round((length(vp)-1)*rand(1,1))+1)
                num2=vp(round((length(vp)-1)*rand(1,1))+1)
                %% atribui o valor aleat�rio para o segundo erro 
                poserro2 = poserro + num
                poserro3 = poserro + num2
                %% Caso os valores escolhidos n�o sejam compativeis com a tabela1
                vet=[poserro poserro2 poserro3]
                vetunique=unique(vet)
                if(length(vet)==length(vetunique))
                perros(poserro)=~perros(poserro);
                    perros(poserro2)=~perros(poserro2);
                    perros(poserro3)=~perros(poserro3);
                    for lin=0:4
                        for col=1:8
                        mperros(lin+1,col)=perros(8*lin+col);
                        end
                    end
                    vetorcorreto=entrada
                    numtestes=numtestes+1
                end
            case 4
                flag='Erro em quarto bits adjacentes'
                vp=[-9 -8 -7 -1 1 7 8 9]; %%vp(round((length(vp)-1)*rand(1,1))+1) me dar� um elemento aleat�rio que representaria a posi��o onde a matriz teria o segundo erro
                %% esse vetor contem a diferen�a de posi��es adjacentes de poserro,que ser� onde o segundo erro ira saltar
                %%poserro=randi(40,1,1)%%posi��o do erro randomicamente escolhida
                poserro = round(39*rand(1,1))+1
                for i=2:7
                    if(poserro==i)
                        vp=[-1 1 7 8 9];
                    elseif(poserro==32+i)
                        vp=[-1 1 -9 -8 -7];
                    end
                end
                for i=1:5
                    if(poserro==(i-1)*8 +1)
                        if(poserro==1)
                            vp=[1 8 9];
                        elseif(poserro==33)
                            vp=[1 -8 -7];
                        else
                            vp=[1 -8 8 9 -7]; 
                        end
                    elseif(poserro==i*8)
                        if(poserro==8)
                            vp=[-1 7 8];
                        elseif(poserro==40)
                            vp=[-1 -9 -8];
                       
                        else
                            vp=[-1 -8 -9 7 8];
                        end
                    end
                end
                %%perros(poserro)=~perros(poserro);
                num=vp(round((length(vp)-1)*rand(1,1))+1)
                num2=vp(round((length(vp)-1)*rand(1,1))+1)
                num3=vp(round((length(vp)-1)*rand(1,1))+1)
                %% atribui o valor aleat�rio para o segundo erro 
                poserro2 = poserro + num
                poserro3 = poserro + num2
                poserro4 = poserro + num3
                %% Caso os valores escolhidos n�o sejam compativeis com a tabela1
                vet=[poserro poserro2 poserro3 poserro4]
                vetunique=unique(vet)
            if(length(vet)==length(vetunique))
                perros(poserro)=~perros(poserro);
                perros(poserro2)=~perros(poserro2);
                perros(poserro3)=~perros(poserro3);
                perros(poserro4)=~perros(poserro4);
                for lin=0:4
                    for col=1:8
                    mperros(lin+1,col)=perros(8*lin+col);
                    end
                end
                vetorcorreto=entrada
                numtestes=numtestes+1
            end
            case 5
                flag='Erro em cinco bits adjacentes'
                vp=[-9 -8 -7 -1 1 7 8 9]; %%vp(round((length(vp)-1)*rand(1,1))+1) me dar� um elemento aleat�rio que representaria a posi��o onde a matriz teria o segundo erro
                %% esse vetor contem a diferen�a de posi��es adjacentes de poserro,que ser� onde o segundo erro ira saltar
                %%poserro=randi(40,1,1)%%posi��o do erro randomicamente escolhida
                poserro = round(39*rand(1,1))+1
                for i=2:7
                    if(poserro==i)
                        vp=[-1 1 7 8 9];
                    elseif(poserro==32+i)
                        vp=[-1 1 -9 -8 -7];
                    end
                end
                for i=1:5
                    if(poserro==(i-1)*8 +1)
                        if(poserro==1)
                            vp=[1 8 9];
                        elseif(poserro==33)
                            vp=[1 -8 -7];
                        else
                            vp=[1 -8 8 9 -7]; 
                        end
                    elseif(poserro==i*8)
                        if(poserro==8)
                            vp=[-1 7 8];
                        elseif(poserro==40)
                            vp=[-1 -9 -8];
                       
                        else
                            vp=[-1 -8 -9 7 8];
                        end
                    end
                end
                %%perros(poserro)=~perros(poserro);
                num=vp(round((length(vp)-1)*rand(1,1))+1)
                num2=vp(round((length(vp)-1)*rand(1,1))+1)
                num3=vp(round((length(vp)-1)*rand(1,1))+1)
                num4=vp(round((length(vp)-1)*rand(1,1))+1)
                %% atribui o valor aleat�rio para o segundo erro 
                poserro2 = poserro + num
                poserro3 = poserro + num2
                poserro4 = poserro + num3
                poserro5 = poserro + num4
                
                %% Caso os valores escolhidos n�o sejam compativeis com a tabela1
                vet=[poserro poserro2 poserro3 poserro4 poserro5]
                vetunique=unique(vet)
                if(length(vet)==length(vetunique))
                    perros(poserro)=~perros(poserro);
                    perros(poserro2)=~perros(poserro2);
                    perros(poserro3)=~perros(poserro3);
                    perros(poserro4)=~perros(poserro4);
                    perros(poserro5)=~perros(poserro5);                
                    for lin=0:4
                        for col=1:8
                        mperros(lin+1,col)=perros(8*lin+col);
                        end
                    end
                    vetorcorreto=entrada
                    numtestes=numtestes+1
                end
            case 6
                flag='Erro em seis bits adjacentes'
                vp=[-9 -8 -7 -1 1 7 8 9]; %%vp(round((length(vp)-1)*rand(1,1))+1) me dar� um elemento aleat�rio que representaria a posi��o onde a matriz teria o segundo erro
                %% esse vetor contem a diferen�a de posi��es adjacentes de poserro,que ser� onde o segundo erro ira saltar
                %%poserro=randi(40,1,1)%%posi��o do erro randomicamente escolhida
                poserro = round(39*rand(1,1))+1
                for i=2:7
                    if(poserro==i)
                        vp=[-1 1 7 8 9];
                    elseif(poserro==32+i)
                        vp=[-1 1 -9 -8 -7];
                    end
                end
                for i=1:5
                    if(poserro==(i-1)*8 +1)
                        if(poserro==1)
                            vp=[1 8 9];
                        elseif(poserro==33)
                            vp=[1 -8 -7];
                        else
                            vp=[1 -8 8 9 -7]; 
                        end
                    elseif(poserro==i*8)
                        if(poserro==8)
                            vp=[-1 7 8];
                        elseif(poserro==40)
                            vp=[-1 -9 -8];
                       
                        else
                            vp=[-1 -8 -9 7 8];
                        end
                    end
                end
                %%perros(poserro)=~perros(poserro);
                num=vp(round((length(vp)-1)*rand(1,1))+1)
                num2=vp(round((length(vp)-1)*rand(1,1))+1)
                num3=vp(round((length(vp)-1)*rand(1,1))+1)
                num4=vp(round((length(vp)-1)*rand(1,1))+1)
                num5=vp(round((length(vp)-1)*rand(1,1))+1)
                %% atribui o valor aleat�rio para o segundo erro 
                poserro2 = poserro + num
                poserro3 = poserro + num2
                poserro4 = poserro + num3
                poserro5 = poserro + num4
                poserro6 = poserro + num5
                %% Caso os valores escolhidos n�o sejam compativeis com a tabela1
                vet=[poserro poserro2 poserro3 poserro4 poserro5 poserro6]
                vetunique=unique(vet)
                if(length(vet)==length(vetunique))
                    perros(poserro)=~perros(poserro);
                    perros(poserro2)=~perros(poserro2);
                    perros(poserro3)=~perros(poserro3);
                    perros(poserro4)=~perros(poserro4);
                    perros(poserro5)=~perros(poserro5);
                    perros(poserro6)=~perros(poserro6);  
                    for lin=0:4
                        for col=1:8
                        mperros(lin+1,col)=perros(8*lin+col);
                        end
                    end
                    vetorcorreto=entrada
                    numtestes=numtestes+1
                end
            case 7
                flag='Erro em sete bits adjacentes'
                vp=[-9 -8 -7 -1 1 7 8 9]; %%vp(round((length(vp)-1)*rand(1,1))+1) me dar� um elemento aleat�rio que representaria a posi��o onde a matriz teria o segundo erro
                %% esse vetor contem a diferen�a de posi��es adjacentes de poserro,que ser� onde o segundo erro ira saltar
                %%poserro=randi(40,1,1)%%posi��o do erro randomicamente escolhida
                poserro = round(39*rand(1,1))+1
                for i=2:7
                    if(poserro==i)
                        vp=[-1 1 7 8 9];
                    elseif(poserro==32+i)
                        vp=[-1 1 -9 -8 -7];
                    end
                end
                for i=1:5
                    if(poserro==(i-1)*8 +1)
                        if(poserro==1)
                            vp=[1 8 9];
                        elseif(poserro==33)
                            vp=[1 -8 -7];
                        else
                            vp=[1 -8 8 9 -7]; 
                        end
                    elseif(poserro==i*8)
                        if(poserro==8)
                            vp=[-1 7 8];
                        elseif(poserro==40)
                            vp=[-1 -9 -8];
                       
                        else
                            vp=[-1 -8 -9 7 8];
                        end
                    end
                end
                %%perros(poserro)=~perros(poserro);
                num=vp(round((length(vp)-1)*rand(1,1))+1)
                num2=vp(round((length(vp)-1)*rand(1,1))+1)
                num3=vp(round((length(vp)-1)*rand(1,1))+1)
                num4=vp(round((length(vp)-1)*rand(1,1))+1)
                num5=vp(round((length(vp)-1)*rand(1,1))+1)
                num6=vp(round((length(vp)-1)*rand(1,1))+1)
                %% atribui o valor aleat�rio para o segundo erro 
                poserro2 = poserro + num
                poserro3 = poserro + num2
                poserro4 = poserro + num3
                poserro5 = poserro + num4
                poserro6 = poserro + num5
                poserro7 = poserro + num6
                %% Caso os valores escolhidos n�o sejam compativeis com a tabela1
                vet=[poserro poserro2 poserro3 poserro4 poserro5 poserro6 poserro7]
                vetunique=unique(vet)
                if(length(vet)==length(vetunique))
                    perros(poserro)=~perros(poserro);
                    perros(poserro2)=~perros(poserro2);
                    perros(poserro3)=~perros(poserro3);
                    perros(poserro4)=~perros(poserro4);
                    perros(poserro5)=~perros(poserro5);
                    perros(poserro6)=~perros(poserro6);  
                    perros(poserro7)=~perros(poserro7);
                    for lin=0:4
                        for col=1:8
                        mperros(lin+1,col)=perros(8*lin+col);
                        end
                    end
                    vetorcorreto=entrada
                    numtestes=numtestes+1
                end
            case 8
                flag='Erro em oito bits adjacentes'
                vp=[-9 -8 -7 -1 1 7 8 9]; %%vp(round((length(vp)-1)*rand(1,1))+1) me dar� um elemento aleat�rio que representaria a posi��o onde a matriz teria o segundo erro
                %% esse vetor contem a diferen�a de posi��es adjacentes de poserro,que ser� onde o segundo erro ira saltar
                %%poserro=randi(40,1,1)%%posi��o do erro randomicamente escolhida
                poserro = round(39*rand(1,1))+1
                 for i=2:7
                    if(poserro==i)
                        vp=[-1 1 7 8 9];
                    elseif(poserro==32+i)
                        vp=[-1 1 -9 -8 -7];
                    end
                end
                for i=1:5
                    if(poserro==(i-1)*8 +1)
                        if(poserro==1)
                            vp=[1 8 9];
                        elseif(poserro==33)
                            vp=[1 -8 -7];
                        else
                            vp=[1 -8 8 9 -7]; 
                        end
                    elseif(poserro==i*8)
                        if(poserro==8)
                            vp=[-1 7 8];
                        elseif(poserro==40)
                            vp=[-1 -9 -8];
                       
                        else
                            vp=[-1 -8 -9 7 8];
                        end
                    end
                end
                %%perros(poserro)=~perros(poserro);
                num=vp(round((length(vp)-1)*rand(1,1))+1)
                num2=vp(round((length(vp)-1)*rand(1,1))+1)
                num3=vp(round((length(vp)-1)*rand(1,1))+1)
                num4=vp(round((length(vp)-1)*rand(1,1))+1)
                num5=vp(round((length(vp)-1)*rand(1,1))+1)
                num6=vp(round((length(vp)-1)*rand(1,1))+1)
                num7=vp(round((length(vp)-1)*rand(1,1))+1)
                %% atribui o valor aleat�rio para o segundo erro 
                poserro2 = poserro + num
                poserro3 = poserro + num2
                poserro4 = poserro + num3
                poserro5 = poserro + num4
                poserro6 = poserro + num5
                poserro7 = poserro + num6
                poserro8 = poserro + num7
                %% Caso os valores escolhidos n�o sejam compativeis com a tabela1
                vet=[poserro poserro2 poserro3 poserro4 poserro5 poserro6 poserro7 poserro8]
                vetunique=unique(vet)
                if(length(vet)==length(vetunique))
                    perros(poserro)=~perros(poserro);
                    perros(poserro2)=~perros(poserro2);
                    perros(poserro3)=~perros(poserro3);
                    perros(poserro4)=~perros(poserro4);
                    perros(poserro5)=~perros(poserro5);
                    perros(poserro6)=~perros(poserro6);  
                    perros(poserro7)=~perros(poserro7);
                    perros(poserro8)=~perros(poserro8);
                    for lin=0:4
                        for col=1:8
                        mperros(lin+1,col)=perros(8*lin+col);
                        end
                    end
                    numtestes=numtestes+1
                end
            otherwise
        end
        %%atribuindo de volta a perros o valor da matriz
        perros=zeros(5,8);
        perros=mperros
        %%Ap�s inser��o de erros a palavra ser� passada para o decodificador
%         [saidacode,numdetec]=DecodificadorCLC(perros)
        [saidacode,numdetec]=decoder(perros)
        if(length(vet)==length(vetunique))
            if(saidacode == entrada)
                Numcertos=Numcertos+1
            else
                Numerrados=Numerrados+1
            end
            if (numdetec==1)
                Numdetecs=Numdetecs +1
            end
        end
    end
    numerodecertos=Numcertos
    numerodeerrados=Numerrados
    numerodetestes=Numdetecs
    naorepetidos=100*(numtestes/num_testes)
    Taxaacerto=100*(Numcertos/numtestes)
    Taxaerros=100*(Numerrados/numtestes)
    Taxadetecs=100*(Numdetecs/numtestes)