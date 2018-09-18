clc;
clear all;
close all;
%%
Infopath = './Data_Mat';
Infoname = fullfile(Infopath,'Avg_Cam_1.mat');
load(Infoname);
Fname = './Feature/Avg_gog_Cam_1.mat';
load(Fname);
timestamps = Avg_timestamp/30;
[timestamps_sort,Index] = sort(timestamps);
[a,b] = hist(Ids,unique(Ids));
Feature_GOG_sort = Avg_feature(Index,:);
Ids_sort = Ids(Index);
T_range = timestamps_sort(1):timestamps_sort(end);
%%
Save_path = './Plot/Case_3/';
if ~exist(Save_path)
    mkdir(Save_path)
end
Case_3 = b(a>=2);
Case_3 = Case_3(Case_3 < 10000);
Num_p = length(Case_3);
Rank_GOG = zeros(Num_p,length(T_range));
Reapp_1 = zeros(Num_p,1);
for p = 1:Num_p
    [Rank_GOG(p,:),Reapp_T] = OneprobeMultireapp(Feature_GOG_sort,Ids_sort,timestamps_sort,Case_3(p));
    Reapp_1(p) = Reapp_T(1);
end
%% Calculate duration of rank persistence of each participants
Rank_GOG_final = Rank_GOG;
Rank_choice = [1 5 10 20 50];
Percent_GOG = calculate_RPC_case3(Rank_choice,Rank_GOG_final);
figure(1);
Dur = 1:size(Percent_GOG,2);
legname = {};
p = [];
for r = 1:5
    p(r) = plot(Dur,Percent_GOG(r,:),'LineWidth',3);
    hold on;
    legname{r} = sprintf('Rank = %d',Rank_choice(r));
end
legend(p,legname,'FontSize',25,'Location','northeast');
ax = gca;
set(gca,'FontSize',25);
set(gca,'YLim',[0 100]);
% % set(gca,'XLim',[0 1]);
set(gca,'XLim',[1 length(Dur)]);
xlabel('Duration (s)');
ylabel('Percentage (%)');
title('Rank Persistence Curve','FontSize',25,'FontWeight','bold');
%% CMC
finalRank = Rank_GOG_final(:,end);
temp = histcounts(finalRank,1:max(finalRank));
Rank_CMC = cumsum(temp)/length(finalRank)*100;
figure(2);
plot(1:50,Rank_CMC(1:50),'LineWidth',3);
ax = gca;
set(gca,'FontSize',25);
set(gca,'YLim',[0 100]);
set(gca,'XLim',[0 50]);
xlabel('Rank');
ylabel('Percentage (%)');
title('Cumulative Match Characteristic Curve','FontSize',20,'FontWeight','bold');
