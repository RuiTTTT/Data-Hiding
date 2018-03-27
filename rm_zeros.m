function v_rm = rm_zeros(v)
%the function removing trailing zeros
zero_num = numel(v) - find(v,1,'last');
v_rm = v(1:length(v)-zero_num);