`timescale 1ns / 1ps

module metro(
    input clk, //1 saniyelik ayarlanmasý lazým 24te 1 olacak
    input [5:0] baslangic_duragi, //const
    input yon, //default olabilecek uclarda
    output reg[5:0] istasyon,
    output reg[6:0] sevensd,
    output reg[3:0] an,
    output reg dp
    );
    
    localparam A = 7'b010_0000;
    localparam B = 7'b000_0011;
    localparam CH = 7'b001_0110;
    localparam D = 7'b010_0001;
    localparam E = 7'b000_0110;
    localparam G = 7'b001_0000;
    localparam H = 7'b000_1011;
    localparam I = 7'b110_1110;
    localparam J = 7'b111_0010;
    localparam L = 7'b100_0111;
    localparam M = 7'b010_1010;
    localparam N = 7'b010_1011;
    localparam O = 7'b010_0011;
    localparam P = 7'b000_1100;
    localparam R = 7'b010_1111;
    localparam S = 7'b001_0010;
    localparam T = 7'b000_0111;
    localparam U = 7'b110_0011;
    localparam Y = 7'b001_0001;
    localparam BOSLUK = 7'b111_1111;
    
    //sayac degiskenleri
    reg [4:0] sayac_24s;
    reg [28:0] sayac_arttir;
    reg saniyelik_sayac;
    
    //kayma elemanlari
    localparam sol = 1'b1;
    localparam sag = 1'b0;
    reg kayma;
    
    //duraklar
    localparam ANABINA = 6'b100_000;
    localparam BAHCE = 6'b010_000;
    localparam SPORSALONU = 6'b001_000;
    localparam GARAJ = 6'b000_100;
    localparam YDB = 6'b000_010;
    localparam TM = 6'b000_001;
    
    //iceride kullanilan harfler
    reg[6:0] harf3, harf2, harf1, harf0;
    reg deger_al; //baslangicta duraga deger atamak icin
  
    initial begin
        sayac_24s=5'b0; sayac_arttir=29'b0; saniyelik_sayac=1'b0; dp=1; deger_al=1'b1;
    end
   
    reg[17:0] ancount;
    always @(posedge clk) begin
      
             if(sayac_arttir == 10**8/2) begin
                sayac_arttir=0;
                saniyelik_sayac=~saniyelik_sayac;  
             end
             sayac_arttir=sayac_arttir+1;
            ancount = ancount+1;
       
   end
  
   reg[3:0] dp_calistir=0;
   reg tm_ydb = 0;
   always@(posedge saniyelik_sayac) begin
       if(deger_al) begin
        case(baslangic_duragi)
                6'b100_000: istasyon = 6'b100_000;
                6'b010_000: istasyon = 6'b010_000;
                6'b001_000: istasyon = 6'b001_000;
                6'b000_100: istasyon = 6'b000_100;
                6'b000_010: istasyon = 6'b000_010;
                6'b000_001: istasyon = 6'b000_001;
                default: istasyon = 6'b000_000;
            endcase
            
            if(baslangic_duragi==ANABINA || yon==1'b0) kayma=sag;
            else if(baslangic_duragi==TM || yon==1'b1) kayma=sol;
            if(baslangic_duragi!=6'b000000)deger_al=1'b0;
            
       end
    if(sayac_24s<=19) begin
       
       case(istasyon)
        ANABINA: begin tm_ydb=0; 
            case(sayac_24s % 11)
                4'd0: begin harf3=BOSLUK; harf2=BOSLUK; harf1=BOSLUK; harf0=A; end
                4'd1: begin harf3=BOSLUK; harf2=BOSLUK; harf1=A; harf0=N; end
                4'd2: begin harf3=BOSLUK; harf2=A; harf1=N; harf0=A; end
                4'd3: begin harf3=A; harf2=N; harf1=A; harf0=BOSLUK; end
                4'd4: begin harf3=N; harf2=A; harf1=BOSLUK; harf0=B; end
                4'd5: begin harf3=A; harf2=BOSLUK; harf1=B; harf0=I; end
                4'd6: begin harf3=BOSLUK; harf2=B; harf1=I; harf0=N; end
                4'd7: begin harf3=B; harf2=I; harf1=N; harf0=A; end
                4'd8: begin harf3=I; harf2=N; harf1=A; harf0=BOSLUK; end
                4'd9: begin harf3=N; harf2=A; harf1=BOSLUK; harf0=BOSLUK; end
                4'd10: begin harf3=A; harf2=BOSLUK; harf1=BOSLUK; harf0=BOSLUK; end
            endcase
        end
        BAHCE : begin tm_ydb=0; 
            case(sayac_24s % 8)
                4'd0: begin harf3=BOSLUK; harf2=BOSLUK; harf1=BOSLUK; harf0=B; end
                4'd1: begin harf3=BOSLUK; harf2=BOSLUK; harf1=B; harf0=A; end
                4'd2: begin harf3=BOSLUK; harf2=B; harf1=A; harf0=H; end
                4'd3: begin harf3=B; harf2=A; harf1=H; harf0=CH; end
                4'd4: begin harf3=A; harf2=H; harf1=CH; harf0=E; end
                4'd5: begin harf3=H; harf2=CH; harf1=E; harf0=BOSLUK; end
                4'd6: begin harf3=CH; harf2=E; harf1=BOSLUK; harf0=BOSLUK; end
                4'd7: begin harf3=E; harf2=BOSLUK; harf1=BOSLUK; harf0=BOSLUK; end
            endcase
        end
        SPORSALONU: begin tm_ydb=0; 
            case(sayac_24s % 14)
                4'd0: begin  harf3=BOSLUK; harf2=BOSLUK; harf1=BOSLUK; harf0=S; end
                4'd1: begin  harf3=BOSLUK; harf2=BOSLUK; harf1=S; harf0=P; end
                4'd2: begin  harf3=BOSLUK; harf2=S; harf1=P; harf0=O; end
                4'd3: begin  harf3=S; harf2=P; harf1=O; harf0=R; end
                4'd4: begin  harf3=P; harf2=O; harf1=R; harf0=BOSLUK; end
                4'd5: begin  harf3=O; harf2=R; harf1=BOSLUK; harf0=S; end
                4'd6: begin  harf3=R; harf2=BOSLUK; harf1=S; harf0=A; end
                4'd7: begin  harf3=BOSLUK; harf2=S; harf1=A; harf0=L; end
                4'd8: begin  harf3=S; harf2=A; harf1=L; harf0=O; end
                4'd9: begin  harf3=A; harf2=L; harf1=O; harf0=N; end
                4'd10: begin  harf3=L; harf2=O; harf1=N; harf0=U; end
                4'd11: begin  harf3=O; harf2=N; harf1=U; harf0=BOSLUK; end
                4'd12: begin  harf3=N; harf2=U; harf1=BOSLUK; harf0=BOSLUK; end
                4'd13: begin  harf3=U; harf2=BOSLUK; harf1=BOSLUK; harf0=BOSLUK; end
            endcase
        end
        GARAJ: begin tm_ydb=0; 
            case(sayac_24s % 8)
                4'd0: begin harf3=BOSLUK; harf2=BOSLUK; harf1=BOSLUK; harf0=G; end
                4'd1: begin harf3=BOSLUK; harf2=BOSLUK; harf1=G; harf0=A;end
                4'd2: begin harf3=BOSLUK; harf2=G; harf1=A; harf0=R;end
                4'd3: begin harf3=G; harf2=A; harf1=R; harf0=A;end
                4'd4: begin harf3=A; harf2=R; harf1=A; harf0=J;end
                4'd5: begin harf3=R; harf2=A; harf1=J; harf0=BOSLUK;end
                4'd6: begin harf3=A; harf2=J; harf1=BOSLUK; harf0=BOSLUK;end
                4'd7: begin harf3=J; harf2=BOSLUK; harf1=BOSLUK; harf0=BOSLUK;end
            endcase
        end
        YDB: begin tm_ydb=1;
            case(sayac_24s % 6)
                4'd0: begin harf3=BOSLUK; harf2=BOSLUK; harf1=BOSLUK; harf0=Y;  dp_calistir=4'b1110; end
                4'd1: begin harf3=BOSLUK; harf2=BOSLUK; harf1=Y; harf0=D; dp_calistir=4'b1100; end
                4'd2: begin harf3=BOSLUK; harf2=Y; harf1=D; harf0=B; dp_calistir=4'b1000; end
                4'd3: begin harf3=Y; harf2=D; harf1=B; harf0=BOSLUK; dp_calistir=4'b0001; end
                4'd4: begin harf3=D; harf2=B; harf1=BOSLUK; harf0=BOSLUK;  dp_calistir=4'b0011;end
                4'd5: begin harf3=B; harf2=BOSLUK; harf1=BOSLUK; harf0=BOSLUK; dp_calistir=4'b0111; end
            endcase
        end
        TM: begin tm_ydb=1;
            case(sayac_24s % 5)
                4'd0: begin harf3=BOSLUK; harf2=BOSLUK; harf1=BOSLUK; harf0=T; dp_calistir=4'b1110; end
                4'd1: begin harf3=BOSLUK; harf2=BOSLUK; harf1=T; harf0=M; dp_calistir=4'b1100;end
                4'd2: begin harf3=BOSLUK; harf2=T; harf1=M; harf0=BOSLUK; dp_calistir=4'b1001; end
                4'd3: begin harf3=T; harf2=M; harf1=BOSLUK; harf0=BOSLUK; dp_calistir=4'b0011; end
                4'd4: begin harf3=M; harf2=BOSLUK; harf1=BOSLUK; harf0=BOSLUK; dp_calistir=4'b0111; end
            endcase
        end
        default: begin
                if(istasyon == 6'b000000) begin
                    harf3=BOSLUK; harf2=BOSLUK; harf1=BOSLUK; harf0=BOSLUK;
                end
                end
    endcase
    end        
    else begin 
       harf3=BOSLUK; harf2=BOSLUK; harf1=BOSLUK; harf0=BOSLUK;    
       if(sayac_24s==20)begin
       dp_calistir=4'b1111;
        //sonraki istasyon degiskeni eklenmeli mi?
        case(kayma)
            sag: begin 
                istasyon=istasyon>>1;
                if(istasyon==6'b000_001)
                    kayma=sol;
            end
            sol: begin 
                istasyon=istasyon<<1;
                if(istasyon==6'b100_000)
                    kayma=sag;
            end
        endcase
       end
    end
    if(sayac_24s==5'd23) sayac_24s=0;
    if(deger_al==0) sayac_24s=sayac_24s+1;
   end
  
   always@(*) begin
    case(ancount[17:16])
        2'b00: begin an = 4'b1110; sevensd = harf0;
            if(tm_ydb && dp_calistir[0]==0) dp=0; else dp=1;
        end
        2'b01: begin an = 4'b1101; sevensd = harf1; 
            if(tm_ydb && dp_calistir[1]==0) dp=0; else dp=1;
        end
        2'b10: begin an = 4'b1011; sevensd = harf2; 
            if(tm_ydb && dp_calistir[2]==0) dp=0; else dp=1;
        end
        2'b11: begin an = 4'b0111; sevensd = harf3; 
            if(tm_ydb && dp_calistir[3]==0) dp=0; else dp=1;
        end
    endcase
   end
   
endmodule