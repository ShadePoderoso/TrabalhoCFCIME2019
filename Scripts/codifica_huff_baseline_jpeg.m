function saida=codifica_huff_baseline_jpeg(seq_cell,comp_DC,comp_AC)

%C?lula da componente DC:
% a linha se refere ao valor de size (come?a no 0)
% o array daquela linha ? o c?digo daquele size
% comp_DC={[0 0];
%     [0 1 0];
%     [0 1 1];
%     [1 0 0];
%     [1 0 1];
%     [1 1 0];
%     [1 1 1 0];
%     [1 1 1 1 0];
%     [1 1 1 1 1 0];
%     [1 1 1 1 1 1 0];
%     [1 1 1 1 1 1 1 0];
%     [1 1 1 1 1 1 1 1 0]};
load comp_DC;

%C?lula da componente AC:
% a linha se refere ? RUNLENGTH, a coluna se refere ao SIZE (come?a no 0)
% o array daquela (linha, coluna) ? o c?digo daquele (runlength,size)
% comp_AC(1,1:11)={
%     [1 0 1 0];
%     [0 0];
%     [0 1];
%     [1 0 0];
%     [1 0 1 1];
%     [1 1 0 1 0];
%     [1 1 1 1 0 0 0];
%     [1 1 1 1 1 0 0 0];
%     [1 1 1 1 1 1 0 1 1 0];
%     [1 1 1 1 1 1 1 1 1 0 0 0 0 0 1 0];
%     [1 1 1 1 1 1 1 1 1 0 0 0 0 0 1 1]
%     }';
% 
% comp_AC(2,1:10)={
%     [1 1 0 0];
%     [1 1 0 1 1];
%     [1 1 1 1 0 0 1];
%     [1 1 1 1 1 0 1 1 0];
%     [1 1 1 1 1 1 1 0 1 1 0];
%     [1 1 1 1 1 1 1 1 1 0 0 0 0 1 0 0];
%     [1 1 1 1 1 1 1 1 1 0 0 0 0 1 0 1];
%     [1 1 1 1 1 1 1 1 1 0 0 0 0 1 1 0];
%     [1 1 1 1 1 1 1 1 1 0 0 0 0 1 1 1];
%     [1 1 1 1 1 1 1 1 1 0 0 0 1 0 0 0]
%     }';
% 
% comp_AC(3,1:10)={
%     [1 1 1 0 0];
%     [1 1 1 1 1 0 0 1];
%     [1 1 1 1 1 1 0 1 1 1];
%     [1 1 1 1 1 1 1 1 0 1 0 0];
%     [1 1 1 1 1 1 1 1 1 0 0 0 1 0 0 1];
%     [1 1 1 1 1 1 1 1 1 0 0 0 1 0 1 0];
%     [1 1 1 1 1 1 1 1 1 0 0 0 1 0 1 1];
%     [1 1 1 1 1 1 1 1 1 0 0 0 1 1 0 0];
%     [1 1 1 1 1 1 1 1 1 0 0 0 1 1 0 1];
%     [1 1 1 1 1 1 1 1 1 0 0 0 1 1 1 0]
%     }';
% 
% comp_AC(4,1:10)={
%     [1 1 1 0 1 0];
%     [1 1 1 1 1 0 1 1 1];
%     [1 1 1 1 1 1 1 1 0 1 0 1];
%     [1 1 1 1 1 1 1 1 1 0 0 0 1 1 1 1];
%     [1 1 1 1 1 1 1 1 1 0 0 1 0 0 0 0];
%     [1 1 1 1 1 1 1 1 1 0 0 1 0 0 0 1];
%     [1 1 1 1 1 1 1 1 1 0 0 1 0 0 1 0];
%     [1 1 1 1 1 1 1 1 1 0 0 1 0 0 1 1];
%     [1 1 1 1 1 1 1 1 1 0 0 1 0 1 0 0];
%     [1 1 1 1 1 1 1 1 1 0 0 1 0 1 0 1]
%     }';
% 
% comp_AC(5,1:10)={
%     [1 1 1 0 1 1];
%     [1 1 1 1 1 1 1 0 0 0];
%     [1 1 1 1 1 1 1 1 1 0 0 1 0 1 1 0];
%     [1 1 1 1 1 1 1 1 1 0 0 1 0 1 1 1];
%     [1 1 1 1 1 1 1 1 1 0 0 1 1 0 0 0];
%     [1 1 1 1 1 1 1 1 1 0 0 1 1 0 0 1];
%     [1 1 1 1 1 1 1 1 1 0 0 1 1 0 1 0];
%     [1 1 1 1 1 1 1 1 1 0 0 1 1 0 1 1];
%     [1 1 1 1 1 1 1 1 1 0 0 1 1 1 0 0];
%     [1 1 1 1 1 1 1 1 1 0 0 1 1 1 0 1]
%     }';
% 
% comp_AC(6,1:10)={
%     [1 1 1 1 0 1 0];
%     [1 1 1 1 1 1 1 0 1 1 1];
%     [1 1 1 1 1 1 1 1 1 0 0 1 1 1 1 0];
%     [1 1 1 1 1 1 1 1 1 0 0 1 1 1 1 1];
%     [1 1 1 1 1 1 1 1 1 0 1 0 0 0 0 0];
%     [1 1 1 1 1 1 1 1 1 0 1 0 0 0 0 1];
%     [1 1 1 1 1 1 1 1 1 0 1 0 0 0 1 0];
%     [1 1 1 1 1 1 1 1 1 0 1 0 0 0 1 1];
%     [1 1 1 1 1 1 1 1 1 0 1 0 0 1 0 0];
%     [1 1 1 1 1 1 1 1 1 0 1 0 0 1 0 1]
%     }';
% 
% comp_AC(7,1:10)={
%     [1 1 1 1 0 1 1];
%     [1 1 1 1 1 1 1 1 0 1 1 0];
%     [1 1 1 1 1 1 1 1 1 0 1 0 0 1 1 0];
%     [1 1 1 1 1 1 1 1 1 0 1 0 0 1 1 1];
%     [1 1 1 1 1 1 1 1 1 0 1 0 1 0 0 0];
%     [1 1 1 1 1 1 1 1 1 0 1 0 1 0 0 1];
%     [1 1 1 1 1 1 1 1 1 0 1 0 1 0 1 0];
%     [1 1 1 1 1 1 1 1 1 0 1 0 1 0 1 1];
%     [1 1 1 1 1 1 1 1 1 0 1 0 1 1 0 0];
%     [1 1 1 1 1 1 1 1 1 0 1 0 1 1 0 1]
%     }';
% 
% comp_AC(8,1:10)={
%     [1 1 1 1 1 0 1 0];
%     [1 1 1 1 1 1 1 1 0 1 1 1];
%     [1 1 1 1 1 1 1 1 1 0 1 0 1 1 1 0];
%     [1 1 1 1 1 1 1 1 1 0 1 0 1 1 1 1];
%     [1 1 1 1 1 1 1 1 1 0 1 1 0 0 0 0];
%     [1 1 1 1 1 1 1 1 1 0 1 1 0 0 0 1];
%     [1 1 1 1 1 1 1 1 1 0 1 1 0 0 1 0];
%     [1 1 1 1 1 1 1 1 1 0 1 1 0 0 1 1];
%     [1 1 1 1 1 1 1 1 1 0 1 1 0 1 0 0];
%     [1 1 1 1 1 1 1 1 1 0 1 1 0 1 0 1]
%     }';
% 
% comp_AC(9,1:10)={
%     [1 1 1 1 1 1 0 0 0];
%     [1 1 1 1 1 1 1 1 1 0 0 0 0 0 0];
%     [1 1 1 1 1 1 1 1 1 0 1 1 0 1 1 0];
%     [1 1 1 1 1 1 1 1 1 0 1 1 0 1 1 1];
%     [1 1 1 1 1 1 1 1 1 0 1 1 1 0 0 0];
%     [1 1 1 1 1 1 1 1 1 0 1 1 1 0 0 1];
%     [1 1 1 1 1 1 1 1 1 0 1 1 1 0 1 0];
%     [1 1 1 1 1 1 1 1 1 0 1 1 1 0 1 1];
%     [1 1 1 1 1 1 1 1 1 0 1 1 1 1 0 0];
%     [1 1 1 1 1 1 1 1 1 0 1 1 1 1 0 1];
%     }';
% 
% comp_AC(10,1:10)={
%     [1 1 1 1 1 1 0 0 1];
%     [1 1 1 1 1 1 1 1 1 0 1 1 1 1 1 0];
%     [1 1 1 1 1 1 1 1 1 0 1 1 1 1 1 1];
%     [1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0];
%     [1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 1];
%     [1 1 1 1 1 1 1 1 1 1 0 0 0 0 1 0];
%     [1 1 1 1 1 1 1 1 1 1 0 0 0 0 1 1];
%     [1 1 1 1 1 1 1 1 1 1 0 0 0 1 0 0];
%     [1 1 1 1 1 1 1 1 1 1 0 0 0 1 0 1];
%     [1 1 1 1 1 1 1 1 1 1 0 0 0 1 1 0]
%     }';
% 
% comp_AC(11,1:10)={
%     [1 1 1 1 1 1 0 1 0];
%     [1 1 1 1 1 1 1 1 1 1 0 0 0 1 1 1];
%     [1 1 1 1 1 1 1 1 1 1 0 0 1 0 0 0];
%     [1 1 1 1 1 1 1 1 1 1 0 0 1 0 0 1];
%     [1 1 1 1 1 1 1 1 1 1 0 0 1 0 1 0];
%     [1 1 1 1 1 1 1 1 1 1 0 0 1 0 1 1];
%     [1 1 1 1 1 1 1 1 1 1 0 0 1 1 0 0];
%     [1 1 1 1 1 1 1 1 1 1 0 0 1 1 0 1];
%     [1 1 1 1 1 1 1 1 1 1 0 0 1 1 1 0];
%     [1 1 1 1 1 1 1 1 1 1 0 0 1 1 1 1]
%     }';
% 
% comp_AC(12,1:10)={
%     [1 1 1 1 1 1 1 0 0 1];
%     [1 1 1 1 1 1 1 1 1 1 0 1 0 0 0 0];
%     [1 1 1 1 1 1 1 1 1 1 0 1 0 0 0 1];
%     [1 1 1 1 1 1 1 1 1 1 0 1 0 0 1 0];
%     [1 1 1 1 1 1 1 1 1 1 0 1 0 0 1 1];
%     [1 1 1 1 1 1 1 1 1 1 0 1 0 1 0 0];
%     [1 1 1 1 1 1 1 1 1 1 0 1 0 1 0 1];
%     [1 1 1 1 1 1 1 1 1 1 0 1 0 1 1 0];
%     [1 1 1 1 1 1 1 1 1 1 0 1 0 1 1 1];
%     [1 1 1 1 1 1 1 1 1 1 0 1 1 0 0 0]
%     }';
% 
% comp_AC(13,1:10)={
%     [1 1 1 1 1 1 1 0 1 0];
%     [1 1 1 1 1 1 1 1 1 1 0 1 1 0 0 1];
%     [1 1 1 1 1 1 1 1 1 1 0 1 1 0 1 0];
%     [1 1 1 1 1 1 1 1 1 1 0 1 1 0 1 1];
%     [1 1 1 1 1 1 1 1 1 1 0 1 1 1 0 0];
%     [1 1 1 1 1 1 1 1 1 1 0 1 1 1 0 1];
%     [1 1 1 1 1 1 1 1 1 1 0 1 1 1 1 0];
%     [1 1 1 1 1 1 1 1 1 1 0 1 1 1 1 1];
%     [1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0];
%     [1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 1]
%     }';
% 
% comp_AC(14,1:10)={
%     [1 1 1 1 1 1 1 1 0 0 0];
%     [1 1 1 1 1 1 1 1 1 1 1 0 0 0 1 0];
%     [1 1 1 1 1 1 1 1 1 1 1 0 0 0 1 1];
%     [1 1 1 1 1 1 1 1 1 1 1 0 0 1 0 0];
%     [1 1 1 1 1 1 1 1 1 1 1 0 0 1 0 1];
%     [1 1 1 1 1 1 1 1 1 1 1 0 0 1 1 0];
%     [1 1 1 1 1 1 1 1 1 1 1 0 0 1 1 1];
%     [1 1 1 1 1 1 1 1 1 1 1 0 1 0 0 0];
%     [1 1 1 1 1 1 1 1 1 1 1 0 1 0 0 1];
%     [1 1 1 1 1 1 1 1 1 1 1 0 1 0 1 0]
%     }';
% 
% comp_AC(15,1:10)={
%     [1 1 1 1 1 1 1 1 1 1 1 0 1 0 1 1];
%     [1 1 1 1 1 1 1 1 1 1 1 0 1 1 0 0];
%     [1 1 1 1 1 1 1 1 1 1 1 0 1 1 0 1];
%     [1 1 1 1 1 1 1 1 1 1 1 0 1 1 1 0];
%     [1 1 1 1 1 1 1 1 1 1 1 0 1 1 1 1];
%     [1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0];
%     [1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 1];
%     [1 1 1 1 1 1 1 1 1 1 1 1 0 0 1 0];
%     [1 1 1 1 1 1 1 1 1 1 1 1 0 0 1 1];
%     [1 1 1 1 1 1 1 1 1 1 1 1 0 1 0 0]
%     }'; 
% 
% comp_AC(16,1:11)={
%     [1 1 1 1 1 1 1 1 0 0 1];
%     [1 1 1 1 1 1 1 1 1 1 1 1 0 1 0 1];
%     [1 1 1 1 1 1 1 1 1 1 1 1 0 1 1 0];
%     [1 1 1 1 1 1 1 1 1 1 1 1 0 1 1 1];
%     [1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0];
%     [1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 1];
%     [1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 0];
%     [1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 1];
%     [1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0];
%     [1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 1];
%     [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0]
%     }';
% 
load comp_AC;

saida=[];
tamanho_seq=length(seq_cell);

%codigo da componente DC
saida=[saida comp_DC{seq_cell{1,1}+1} seq_cell{1,2}];

%codigos das componentes AC
for i=2:tamanho_seq
    simbolo1=seq_cell{i,1};
    simbolo2=seq_cell{i,2};
    if simbolo1(1,1)==0 || simbolo1(1,1)==15
        saida=[saida comp_AC{simbolo1(1,1)+1,simbolo1(1,2)+1} simbolo2];
    else
        saida=[saida comp_AC{simbolo1(1,1)+1,simbolo1(1,2)} simbolo2];
    end
end

end