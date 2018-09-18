function [Rank,Reapp_T] = OneprobeMultireapp(Feature,Ids_sort,timestamps_sort,p_Id)
Time_range = timestamps_sort(1):timestamps_sort(end);
Rank = nan(1,length(Time_range));
p_appear = find(Ids_sort == p_Id);
Reapp_T = zeros(1,length(p_appear)-1);
Probe = Feature(p_appear(1),:);
Query_cur = Feature(1:p_appear(2)-1,:);
Query_cur(p_appear(1),:) = [];
Score_cur = pdist2(Probe,Query_cur);
[Score_sort,Ind_cur] = sort(Score_cur);
for app = p_appear(2):length(Ids_sort)
    %% Find timestamp of the reappearances
    App_index = find(app == p_appear);
    if ~isempty(App_index)
        Reapp_T(App_index-1) = int32(timestamps_sort(app) - timestamps_sort(1));
    end
    %% Calculate score, find rank
    Score_app = pdist2(Probe,Feature(app,:));
    temp = find(Score_sort<Score_app);
    if isempty(temp)
        Score_sort = [Score_app Score_sort];
        Ind_cur = [app-1 Ind_cur];
    else
        Score_sort = [Score_sort(temp) Score_app Score_sort(temp(end)+1:end)];
        Ind_cur = [Ind_cur(temp) app-1 Ind_cur(temp(end)+1:end)];
    end
    Ids_new = Ids_sort;
    Ids_new(p_appear(1)) = [];
    Ids_new = Ids_new(Ind_cur);
    T = int32(timestamps_sort(app) - timestamps_sort(1));
    Temp_index = intersect(Ind_cur,p_appear(2:end)-1,'stable');
    Rank_new = find(Ind_cur == Temp_index(1));
    if (app ~= length(Ids_sort))
        T_next = int32(timestamps_sort(app+1) - timestamps_sort(1));
        Rank(T:T_next) = Rank_new;
    else
        Rank(T:length(Time_range)) = Rank_new;
    end
    
end

end