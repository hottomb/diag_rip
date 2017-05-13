clear all; close all;

im=imread('diag.png');
im2=im2bw(im,0.90);

% imshow(im2)

im_size=size(im2');%niestandardowo [x y]

theta=[0,90];
[R,xp]=radon(~im2,theta);

id_ef{1}=fix(((length(R)-size(im2)*[0;1])/2 : (length(R)+size(im2)*[0;1])/2));
R_ef{1}=R(id_ef{1},1); %x is base
id_ef{2}=fix(((length(R)-size(im2)*[1;0])/2 : (length(R)+size(im2)*[1;0])/2));
R_ef{2}=R(id_ef{2},2); %y is base

id_ef{1}=id_ef{1}-id_ef{1}(1);
id_ef{2}=id_ef{2}-id_ef{2}(1);
%-----------------------------
% Int_f=1;
% i=1;
% id_ef{i}=linspace(id_ef_pr{i}(1),id_ef_pr{i}(end),Int_f*length(id_ef_pr{i}));
% R_ef{i}=smooth(interp1(id_ef_pr{i},R_ef{i},id_ef{i}));
% i=2;
% id_ef{i}=linspace(id_ef_pr{i}(1),id_ef_pr{i}(end),Int_f*length(id_ef_pr{i}));
% R_ef{i}=interp1(id_ef_pr{i},R_ef{i},id_ef{i});

for i=1:2
   b=[60 60]; %"threshold" for x and for y
   [pks{i},lcs{i}]=findpeaks(R_ef{i},'MinPeakProminence',b(i)); 
end

N=40;%no. of edges, N-1 bins
for i=1:2
dist{i}=sort(diff(id_ef{i}(lcs{i})));
cats{i}=linspace(dist{i}(1)-0.1,dist{i}(end)+0.1,N);
[counts{i},ind{i}] = histc(dist{i},cats{i})
end

figure(22);
% i=1;
% subplot(211);histogram(dist{i},N)
% i=2;
% subplot(212);histogram(dist{i},N)
i=1;
subplot(211);bar(cats{i},counts{i},'histc');
i=2;
subplot(212);bar(cats{i},counts{i},'histc');
%dystanse

%wybor dominujacej roznicy - dopracowac na dublowanie wartosci
i=1;
bin=find(counts{i}==max(counts{i}));
dom_dist{i}=mean([cats{i}(bin),cats{i}(bin+1)])
i=2;
bin=find(counts{i}==max(counts{i}));
dom_dist{i}=mean([cats{i}(bin),cats{i}(bin+1)])

figure(1);
i=1;
subplot(211);plot(id_ef{i},R_ef{i},id_ef{i}(lcs{i}),R_ef{i}(lcs{i}),'x');
i=2;
subplot(212);plot(id_ef{i},R_ef{i},id_ef{i}(lcs{i}),R_ef{i}(lcs{i}),'x');

% % % 
% % % %offsety
% % % i=1;
% % % set{i}=1:dom_dist{i}:(im_size(i)) %w x dla i=1
% % % i=2;
% % % set{i}=1:dom_dist{i}:(im_size(i)) %w y dla i=1
% % % 
% % % i=1;
% % % off_err=@(off) id_ef{i}(lcs{i}) - set{i} -off;
% % % fmin=fminbnd(off_err,-50,50)
zastanow sie zez tutej, bo nie dziala raczej


