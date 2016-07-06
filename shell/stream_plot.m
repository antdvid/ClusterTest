%stream test
close all
clear
%read data
%the data should formated as
%cores copyband copytime scaleband scaletime 
%addband addtime triadband triadtime
Data = load('stream.log');

%handle data
%plot bandwidth
hold on
cores = Data(:,1);
linetype = {'-s','-o','-p','-*'};
colortype = jet(size(Data,1));
for i = 1 : 4
    plot(cores,Data(:,i*2)/1024,linetype{i},'Color',colortype(i,:))
end

%plot perfect line
for i = 1 : 4
    plot(cores,Data(1,i*2).*cores/1024,'--','Color',colortype(i,:))
end
%set(gca,'xscale','log','yscale','log')
legend('Copy bandwidth','Scale bandwidth','Add bandwidth',...
    'Triad bandwidth','Location','NorthWest');
xlabel('Number of cores');
ylabel('Bandwidth (Gb/s)')
set(gca,'XTick',cores,'ygrid','on')
axis tight
box on
hold off
print -djpg stream.jpg
