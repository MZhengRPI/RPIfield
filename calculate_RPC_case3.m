function Percent = calculate_RPC_case3_0219(Rank_choice,Rank_all)
Num_p = size(Rank_all,1);
Mask_app = ones(size(Rank_all));
Mask_app(isnan(Rank_all)) = 0;
App_dur = sum(Mask_app,2);
Duration = zeros(Num_p,length(Rank_choice));
Percent = zeros(length(Rank_choice),max(App_dur));
for r = 1:length(Rank_choice)
    Rank_fixed = Rank_choice(r);
    Mask = zeros(size(Rank_all));
    Mask(Rank_all<=Rank_fixed) = 1;
    Mask(:,end) = [];
    Mask = [zeros(Num_p,1) Mask];
    Rank_change_ind = diff(Mask,1,2);
    Index_change = find(sum(abs(Rank_change_ind),2) ~= 0);
    for ch = 1:length(Index_change)
        Change_t = find(Rank_change_ind(Index_change(ch),:) ~= 0);
        if rem(length(Change_t),2) ~= 0
            Change_t = [Change_t-1 size(Rank_all,2)];
        end
        Temp_matrix = reshape(Change_t,[],2);
        Duration(Index_change(ch),r) = max(Temp_matrix(:,2) - Temp_matrix(:,1));
    end
end
Duration = [Duration;zeros(1,size(Duration,2))];
Duration_sort = sort(Duration,1,'descend');
for r = 1:length(Rank_choice)
    for p = 1:Num_p
        if (Duration_sort(p,r) ~= 0)
            Percent(r,Duration_sort(p+1,r)+1:Duration_sort(p,r)) = p;
        end
    end
end
%%
% % Duration_ratio = Duration./App_dur;
% % Duration_sort = sort(Duration_ratio,1,'descend');
% % for r = 1:length(Rank_choice)
% %     for p = 1:Num_p
% %         if (Duration_sort(p,r) ~= 0)
% %             st = floor(Duration_sort(p+1,r)/0.0001)+1;
% %             en = floor(Duration_sort(p,r)/0.0001);
% %             Percent(r,st:en) = p;
% %         end
% %     end
% % end
Percent = Percent*100./Num_p;
end