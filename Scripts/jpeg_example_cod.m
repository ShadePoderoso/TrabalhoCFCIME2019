clear all;
clc;
close all;

%tabela de quantiza??o ara informa??o de luminancia (ITU-T81)
Q=[16 11 10 16 24 40 51 61;
   12 12 14 19 26 58 60 55;
   14 13 16 24 40 57 69 56;
   14 17 22 29 51 87 80 62;
   18 22 37 56 68 109 103 77;
   24 35 55 64 81 104 113 92;
   49 64 78 87 103 121 120 101;
   72 92 95 98 112 100 103 99];



%tabelas de huffman das componentes DC e AC para luminancia
load comp_DC;
load comp_AC;

%ordenamento ZIG-ZAG 8x8
oi=[1 1 2 3 2 1 1 2 3 4 5 4 3 2 1 1 2 3 4 5 6 7 6 5 4 3 2 1 1 2 3 4 5 6 7 8 ...
    8 7 6 5 4 3 2 3 4 5 6 7 8 8 7 6 5 4 5 6 7 8 8 7 6 7 8 8];
oj=[1 2 1 1 2 3 4 3 2 1 1 2 3 4 5 6 5 4 3 2 1 1 2 3 4 5 6 7 8 7 6 5 4 3 2 1 ...
    2 3 4 5 6 7 8 8 7 6 5 4 3 4 5 6 7 8 8 7 6 5 6 7 8 8 7 8];
ZZ=[oi;oj];

%cell array para guardar a sequencia codificada intermediaria
seq_cell=cell(2,2); %pelo menos a componente DC e EOB.
%cada linha ? um s?mbolo segundo o ordenamento ZZ
%primeira coluna ? o simbolo 1
%segundo coluna ? o simbolo 2



%le a imagem a ser codificada
Imag=imread('Ex4.bmp');

%nr de pixels da imagem - vertical e horizontal
[vlen,hlen]=size(Imag);

linhas=floor(vlen/8);%nr de linhas de blocos 8x8
colunas=floor(hlen/8);%nr de colunas de blocos 8x8

DC_ant=0; %componente DC do bloco anterior



%seq de bits da imagem codificada (array binario): imag_codif
%no inicio colocarei informacao do nr de blocos na horizontal e na vertical
meta=cell(2,1);
[a,b]=amplitude_cod_int(linhas);
meta{1,1}=a;
meta{1,2}=b;
[a,b]=amplitude_cod_int(colunas);
meta{2,1}=a;
meta{2,2}=b;
load comp_DC;

imag_codif=[comp_DC{meta{1,1}+1} meta{1,2} comp_DC{meta{2,1}+1} meta{2,2}]; 
nr_de_blocos=0;
for ii=1:linhas
    
    for jj=1:colunas
        
        codigo_bloco=[]; %seq de bits do bloco codif
        
        %pega o bloco atual e converte para double
        Iuit8=Imag((ii-1)*8+1:ii*8,(jj-1)*8+1:jj*8);
        I=double(Iuit8);
        
        
        %passo 1: passar os valores de [0 255] para [-128 127] 
        Il=I-128;
        
        %passo 2: aplicar a dct2
        J=dct2(Il);
        
        %passo  3: quantiza??o
        Jq=round(J./Q);
        
        %passo 4: criar a sequencia codigo intermediaria
        seqn=1;
        %componente DC
        bi=1; bj=1;
        valor=Jq(bi,bj);
        valor_diff=valor-DC_ant;
        if valor_diff~=0
            [size, amplitude]=amplitude_cod_int(valor_diff);
        else
            size=0; amplitude=[];
        end
        DC_ant=valor;
        seq_cell{seqn,1}=size;
        seq_cell{seqn,2}=amplitude;
        seqn=seqn+1;
        
        %componentes AC
        runlength=0; %runlength atual
        for comp=2:64
            
           bi=ZZ(1,comp);
           bj=ZZ(2,comp);
           valor=Jq(bi,bj);
           if valor==0
               if runlength~=15
                   runlength=runlength+1;
                   continue
               else
                   simbolo1=[15 0];
                   simbolo2=[];
                   runlength=0;
                   seq_cell{seqn,1}=simbolo1;
                   seq_cell{seqn,2}=simbolo2;
                   seqn=seqn+1;
                   continue
                   
               end
           else
               [size, amplitude]=amplitude_cod_int(valor);
               simbolo1=[runlength size];
               simbolo2=amplitude;
               runlength=0;
               seq_cell{seqn,1}=simbolo1;
               seq_cell{seqn,2}=simbolo2;
               seqn=seqn+1;
               continue
           end
             
        end
        %coloca o EOB no ultimo par de simbolos significativo
        %Obs. O if comentado nao foi retirado por questoes historicas
 %       if valor ==0 %significa que cheguei no final com valor 0. 
            %Logo tenho que colocar um EOB no primeiro simbolo (15,0) que
            %encontrar.
            size=0;
            while size==0
                simbolo_teste=seq_cell{seqn-1,1};
                if simbolo_teste(1,2)~=0
                    seq_cell{seqn,1}=[0 0];
                    seq_cell{seqn,2}=[];
                    break
                else
                    seqn=seqn-1;
                    %verifica se chegou na componente DC
                    if seqn==2
                        seq_cell{seqn,1}=[0 0];
                        seq_cell{seqn,2}=[];
                        break
                    end
                        
                end
            end
  %      end
        seq_cell=seq_cell(1:seqn,:); %fica com a sequencia at? o EOB         
            
        codigo_bloco=codifica_huff_baseline_jpeg(seq_cell,comp_DC,comp_AC);
        imag_codif=[imag_codif codigo_bloco];
        %disp('chegou ao fim de um bloco');
        nr_de_blocos=nr_de_blocos+1;
        if nr_de_blocos==137
            save teste_cod seq_cell Iuit8 I J Jq DC_ant;
        end
        
    end
    
end

%salva em uma vari?vel do matlab
save imagem_codificada4 imag_codif

%salva em um arquivo bin?rio
fid = fopen('imagem_codif_4.baseline', 'w');
fwrite(fid, imag_codif, 'ubit1');



