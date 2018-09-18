% RPC code by Meng Zheng
% Case 1: Identities who re-appear once in camera 1 video
% Case 2: Identities who re-appear multiple times in camera 1 video
% Demo for Camera 1
%%
clc;
clear all;
close all;
%%
Infopath = './Data_Mat';
Infoname = fullfile(Infopath,'Avg_Cam_1.mat');
load(Infoname)
Fname = './Feature/Avg_gog_Cam_1.mat';
load(Fname);
timestamps = Avg_timestamp/30;
[timestamps_sort,Index] = sort(timestamps);
[a,b]=hist(Ids,unique(Ids));
Feature_GOG_sort = Avg_feature(Index,:);
Ids_sort = Ids(Index);
T_range = timestamps_sort(1):timestamps_sort(end);
Unit = 10;
FlowD = zeros(size(T_range));
N_time = floor(length(T_range)/Unit);
for n = 1:N_time
    if n == N_time
        FlowD((n-1)*Unit+1:end) = length(find(timestamps_sort < T_range(end) & timestamps_sort >= T_range((n-1)*Unit+1)));
    else
        FlowD((n-1)*Unit+1:n*Unit) = length(find(timestamps_sort < T_range(n*Unit) & timestamps_sort >= T_range((n-1)*Unit+1)));
    end
end
[~,index] = sort(FlowD);
cmap = cool(length(FlowD));
cmap_sort = cmap(index,:);
%% Case 1: One probe, one reappearance
Savefig_rootp = './Plot';
Case_1 = b(a==2);
Case_1 = Case_1(Case_1 < 10000);
Rank1 = zeros(length(Case_1),length(T_range));
for i = 1:length(Case_1)
    Save_path = fullfile(Savefig_rootp,'Case_1');
    if ~exist(Save_path)
        mkdir(Save_path)
    end
    [Rank,Reapp_T] = OneprobeMultireapp(Feature_GOG_sort,Ids_sort,timestamps_sort,Case_1(i));
    Rank1(i,:) = Rank;
    %% Original
    figure(1)
    plot(timestamps_sort(1):timestamps_sort(end),Rank,'LineWidth',3);
    xlabel('Time (s)', 'FontSize', 25, 'FontWeight', 'bold');
    set(gca,'XLim',[max([T_range(Reapp_T(1))-400 T_range(1)]) T_range(end)]);
    title('Rank vs. Time','FontSize',25,'FontWeight','bold');
    ylim([0 150]);
    ax = gca;
    set(gca,'Ydir','reverse');
    ylabel('Rank','FontSize', 25, 'FontWeight', 'bold');
end
%% Case 2: One probe, multiple reappearance
Case_2 = b(a>2);
Case_2 = Case_2(Case_2 < 10000);
Rank2 = zeros(length(Case_2),length(T_range));
for i = 1:length(Case_2)
    Save_path = fullfile(Savefig_rootp,'Case_2');
    if ~exist(Save_path)
        mkdir(Save_path)
    end
    [Rank,Reapp_T] = OneprobeMultireapp(Feature_GOG_sort,Ids_sort,timestamps_sort,Case_2(i));
    Rank2(i,:) = Rank;
    figure(2);
    plot(T_range,Rank,'LineWidth',3);
    hold on;
    plot(T_range(Reapp_T),Rank(Reapp_T),'x','LineWidth',4,'MarkerSize',13);
    hold off;
    ylim([0 150]);
    ax = gca;
    set(gca,'FontSize',25);
    set(gca,'Ydir','reverse');
    set(gca,'YLim',[0 2*max(Rank)]);
    set(gca,'XLim',[max([T_range(Reapp_T(1))-1000 T_range(1)]) T_range(end)]);
    xlabel('Time (s)','FontWeight','Bold');
    title('Rank vs. Time','FontSize',25,'FontWeight','bold');
end
% % 

