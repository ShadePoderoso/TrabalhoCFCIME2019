clear all;
clc;
close all;

load comp_AC; load comp_DC;

AC_Tree = BinarySearchTree();
DC_Tree = BinarySearchTree();

%popula a DC_Tree
for ii=1:length(comp_DC)
    key='';
    key_array=comp_DC{ii};
    for jj=1:length(key_array)
        key=[key num2str(key_array(jj))];
    end
    
    DC_Tree.Insert(bin2dec(key),ii-1);
end


%popula a AC_Tree
for ii=1:length(comp_AC)
    AC_row=comp_AC(ii,:);
    for jj=1:length(AC_row)
        key='';
        key_array=AC_row{1,jj};
        for kk=1:length(key_array)
            key=[key num2str(key_array(kk))];
        end
        if ii==1 || ii==16
            AC_Tree.Insert(bin2dec(key),[ii-1 jj-1]);
        else
            AC_Tree.Insert(bin2dec(key),[ii-1 jj]);
        end
        
    end
end

save AC_Tree AC_Tree;
save DC_Tree DC_Tree;
