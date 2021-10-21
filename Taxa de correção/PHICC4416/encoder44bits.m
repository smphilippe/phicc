% PHICC (44,16)
% Encoder
function Encoder= encoder(entrada)
% clear;
% clc;

    %entrada=[0 1 1 0;1 1 0 1; 0 0 0 1; 1 1 1 0];

    datai=zeros(4,4);
    CB=zeros(4,4);
    CBi=zeros(4,4);
    pl=zeros(4,1);
    pc=zeros(4,1);
    pcb=zeros(4,1);

    %% Calculo dos check bits
    for i= 0:3
        CB(i+1,1)= xor(entrada(i+1,1),xor(entrada(i+1,2),entrada(i+1,3)));
        CB(i+1,2)= xor(entrada(i+1,1),xor(entrada(i+1,2),entrada(i+1,4)));
        CB(i+1,3)= xor(entrada(i+1,1),xor(entrada(i+1,3),entrada(i+1,4)));
        CB(i+1,4)= xor(entrada(i+1,2),xor(entrada(i+1,3),entrada(i+1,4)));
    end
    
    %1  2  3  4  5  6  7  8  9  10 11
    %12 13 14 15 16 17 18 19 20 21 22
    %23 24 25 26 27 28 29 30 31 32 33
    %34 35 36 37 38 39 40 41 42 43 44
    

	%% Embaralhamento dos bits
    
    datai(1,1)=entrada(1,1);
    datai(1,2)=entrada(3,1);
    datai(1,3)=entrada(1,3);
    datai(1,4)=entrada(3,3);
    
    datai(2,1)=entrada(2,1);
    datai(2,2)=entrada(4,1);
    datai(2,3)=entrada(2,3);
    datai(2,4)=entrada(4,3);
    
    datai(3,1)=entrada(3,2);
    datai(3,2)=entrada(1,2);
    datai(3,3)=entrada(3,4);
    datai(3,4)=entrada(1,4);
    
    datai(4,1)=entrada(4,2);
    datai(4,2)=entrada(2,2);
    datai(4,3)=entrada(4,4);
    datai(4,4)=entrada(2,4);
    
    CBi(1,1)=CB(1,1);
    CBi(1,2)=CB(3,1);
    CBi(1,3)=CB(1,3);
    CBi(1,4)=CB(3,3);
    
    CBi(2,1)=CB(2,1);
    CBi(2,2)=CB(4,1);
    CBi(2,3)=CB(2,3);
    CBi(2,4)=CB(4,3);
    
    CBi(3,1)=CB(3,2);
    CBi(3,2)=CB(1,2);
    CBi(3,3)=CB(3,4);
    CBi(3,4)=CB(1,4);
    
    CBi(4,1)=CB(4,2);
    CBi(4,2)=CB(2,2);
    CBi(4,3)=CB(4,4);
    CBi(4,4)=CB(2,4);
    

    %% Calculo dos bits de paridade
    
    for i=0:3
    pl(i+1,1)=xor(datai(i+1,1),xor(datai(i+1,2),xor(datai(i+1,3),datai(i+1,4)))); %Paridade de linha dos dados embaralhados
    pc(i+1,1)=xor(datai(1,i+1),xor(datai(2,i+1),xor(datai(3,i+1),datai(4,i+1)))); %Paridade de coluna dos dados embaralhados
    pcb(i+1,1)=xor(CB(i+1,1),xor(CB(i+1,2),xor(CB(i+1,3),CB(i+1,4)))); %Paridade de linha dos CBs desembaralhados
    end

    word=[datai pl pc pcb CBi];
    
    Encoder=word;
end