% New PHICC (32,16)
% Encoder
function Encoder= encoder(entrada)

    %entrada=[0 1 1 1; 0 0 1 0; 0 1 1 1; 0 1 0 1];
    datai=zeros(4,4);
    CB=zeros(4,2);
    CBi=zeros(4,2);
    pd=zeros(4,1);
    pdi=zeros(4,1);
    v=zeros(4,1);
    

    %% Calculo dos check bits
    for i= 0:3
        CB(i+1,1)= xor(entrada(i+1,1),entrada(i+1,2));
        CB(i+1,2)= xor(entrada(i+1,1),entrada(i+1,3));
    end
    CB
    
    CBi(1,1) = CB(1,1);
    CBi(1,2) = CB(3,2);
    CBi(2,1) = CB(2,1);
    CBi(2,2) = CB(4,2);
    CBi(3,1) = CB(3,1);
    CBi(3,2) = CB(1,2);
    CBi(4,1) = CB(4,1);
    CBi(4,2) = CB(2,2);
    
    %1  2  3  4  5  6  7  8
    %9  10 11 12 13 14 15 16
    %17 18 19 20 21 22 23 24
    %25 26 27 28 29 30 31 32
    
    %% Embaralhamento dos bits de dados
    
    datai(1,1)=entrada(3,1);
    datai(1,2)=entrada(1,1);
    datai(1,3)=entrada(3,3);
    datai(1,4)=entrada(1,3);
    
    datai(2,1)=entrada(4,1);
    datai(2,2)=entrada(2,1);
    datai(2,3)=entrada(4,3);
    datai(2,4)=entrada(2,3);
    
    datai(3,1)=entrada(1,2);
    datai(3,2)=entrada(3,2);
    datai(3,3)=entrada(1,4);
    datai(3,4)=entrada(3,4);
    
    datai(4,1)=entrada(2,2);
    datai(4,2)=entrada(4,2);
    datai(4,3)=entrada(2,4);
    datai(4,4)=entrada(4,4);

    %% Calculo dos bits de paridade
    
    for i=0:3
        pd(i+1,1)=xor(entrada(i+1,1),xor(entrada(i+1,2),xor(entrada(i+1,3),entrada(i+1,4)))); %Paridade de linha dos dados desembaralhados
    end
    
    pdi(1,1) = pd(3,1);
    pdi(2,1) = pd(4,1);
    pdi(3,1) = pd(1,1);
    pdi(4,1) = pd(2,1);
    
    v(1,1)=xor(pd(1,1),(xor(CB(1,1),CB(1,2))));
    v(2,1)=xor(pd(2,1),(xor(CB(2,1),CB(2,2))));
    v(3,1)=xor(pd(3,1),(xor(CB(3,1),CB(3,2))));
    v(4,1)=xor(pd(4,1),(xor(CB(4,1),CB(4,2))));

    word=[datai pdi CBi v];
    
    Encoder=word;
end