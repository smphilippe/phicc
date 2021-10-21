`timescale 1ns / 1ps

module MRSC_Decoder(data_in, data_out, en);
    input [0:31] data_in;
    input en;
    output[0:15] data_out;
    reg [0:7] signal[0:3];
    reg [0:1] linsin[0:3];
    reg [0:3] SP;
    reg [0:3] SDi;
    reg [0:2] quads[0:2];
    integer b=0;
    integer j=0;
    integer sumSL=0;
    integer numnonzero=0;
    integer maxquads=0;
    integer reg_errada;
    integer empate_em;
    always@(posedge en)
    begin
        signal[0][0:7]=data_in[0:7];
        signal[1][0:7]=data_in[8:15];
        signal[2][0:7]=data_in[16:23];
        signal[3][0:7]=data_in[24:31];
        for(b=0;b<4;b=b+1)
        begin
            linsin[b][0]=signal[b][0]^signal[b][2]^signal[b][6];
            linsin[b][1]=signal[b][1]^signal[b][3]^signal[b][7];
        end

        SP[0]=signal[0][0]^signal[1][0]^signal[2][0]^signal[3][0]^signal[2][4];
        SP[1]=signal[0][1]^signal[1][1]^signal[2][1]^signal[3][1]^signal[3][4];
        SP[2]=signal[0][2]^signal[1][2]^signal[2][2]^signal[3][2]^signal[2][5];
        SP[3]=signal[0][3]^signal[1][3]^signal[2][3]^signal[3][3]^signal[3][5];

        SDi[0]=signal[0][0]^signal[1][1]^signal[2][0]^signal[3][1]^signal[0][4];
        SDi[1]=signal[0][1]^signal[1][0]^signal[2][1]^signal[3][0]^signal[1][4];
        SDi[2]=signal[0][2]^signal[1][3]^signal[2][2]^signal[3][3]^signal[0][5];
        SDi[3]=signal[0][3]^signal[1][2]^signal[2][3]^signal[3][2]^signal[1][5];

        sumSL=1*linsin[1][0] + 1*linsin[1][1]+ 1*linsin[2][0]+ 1*linsin[2][1]+
              1*linsin[3][0] + 1*linsin[3][1]+ 1*linsin[0][0]+ 1*linsin[0][1];
			  
        quads[0][0:2]=1*SP[0]+1*SP[1]+1*SDi[0]+1*SDi[1];
        quads[1][0:2]=1*SP[2]+1*SP[3]+1*SDi[2]+1*SDi[3];

        
        if(((SP[0:3] !=8'b0000) & (SDi[0:3] !=8'b0000)) |  sumSL>1)
        begin
            reg_errada=4;
            empate_em=4;
            for(b=0;b<1;b=b+1)
            begin
            //$monitor("reg_errada %d empate_em %d",reg_errada,empate_em);
                if(((quads[b][0:2] == quads[b+1][0:2])) & (quads[b][0:2]!=0))
                begin
                    empate_em = b;
                end
            end   
                   
            //$monitor("FINAL reg_errada %d empate_em %d",reg_errada,empate_em);
            if(empate_em == 4)
            begin
                for(b=0;b<1;b=b+1)
                begin
                    if(quads[b][0:2]>quads[b+1][0:2])
                    begin
                    //$monitor("reg_errada = %d",reg_errada);
                        reg_errada=b;
                    end
                    else if(quads[b][0:2]<quads[b+1][0:2])
                    begin
                    //$monitor("reg_errada = %d",reg_errada);
                        reg_errada=b+1;
                    end
                end
                if(reg_errada==0)
                begin
                //$monitor("entrei");
                    for(b=0;b<4;b=b+1)
                        if(linsin[b][0:1]!=2'b00)
                            signal[b][0:1]=signal[b][0:1]^linsin[b][0:1];
                end
                else if(reg_errada==1)
                begin
                    for(b=0;b<4;b=b+1)
                        if(linsin[b][0:1]!=2'b00)
                            signal[b][2:3]=signal[b][2:3]^linsin[b][0:1];
                end
                else if(reg_errada==2)
                begin
                    for(b=0;b<4;b=b+1)
                        if(linsin[b][0:1]!=2'b00)
                            signal[b][4:5]=signal[b][4:5]^linsin[b][0:1];
                end
                else if(reg_errada==3)
                begin
                    for(b=0;b<4;b=b+1)
                        if(linsin[b][0:1]!=2'b00)
                            signal[b][6:7]=signal[b][6:7]^linsin[b][0:1];
                end
            end
            else if(empate_em !=4)
            begin
             //$monitor("monitor numnonzero %d ", numnonzero);
                if(empate_em==0) 
                begin 
                //$monitor("monitor numnonzero %d ", 1);
                    for(b=0;b<4;b=b+1)
                    if(linsin[b][0:1]!=2'b00)
                    signal[b][1:2]=signal[b][1:2]^{linsin[b][1],linsin[b][0]};
                end
                if(empate_em==1)
                begin 
                //$monitor("monitor numnonzero %d ", 2);
                    for(b=0;b<4;b=b+1)
                    if(linsin[b][0:1]!=2'b00)
                    signal[b][3:4]=signal[b][3:4]^{linsin[b][1],linsin[b][0]};
                end
                if(empate_em==2) 
                begin 
                    //$monitor("monitor numnonzero %d ", 3);
                    for(b=0;b<4;b=b+1)
                    if(linsin[b][0:1]!=2'b00)
                    signal[b][5:6]=signal[b][5:6]^{linsin[b][1],linsin[b][0]};
                end
            end
        end
    end
    assign data_out={signal[0][0:3],
                    signal[1][0:3],
                    signal[2][0:3],
                    signal[3][0:3]};
    
endmodule
