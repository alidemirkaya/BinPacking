clc
clear all
parcalar=xlsread('Parcalar');
for i=1:length(parcalar)
    parca(i).no=parcalar(i,1);
    parca(i).boy=parcalar(i,2);
end

%% Genetik Algoritma Parametreleri
% Popülasyon Büyüklüðü
popsize=20;
% Çaprazlama Oraný
crossoran=0.6;
% Mutasyon Oraný
mutationoran=0.2;
% Max Ýterasyon Sayýsý
Maxiter=1000;
kromozom=zeros(popsize,length(parca));
% BinPacking(parca,sira,15);
it=1;
% Baþlangýç Popülasyonunu Oluþtur
while it<popsize+1
    gelen=parcasecim([parca.no]);
    if(ismember(gelen,kromozom,'rows')~=0)
        parcasecim([parca.no]);
    else
        kromozom(it,:)=gelen;
        it=it+1;
    end
end
% Baþlangýç Çözümleri
for i=1:popsize
    Sonuc(i).Sira=kromozom(i,:);
    Sonuc(i).Yerlesim=BinPacking(parca,kromozom(i,:),15);
    Sonuc(i).FV=length(Sonuc(i).Yerlesim);
end

% Genetik Operatörler
for i=1:Maxiter
    Childs.Sira=[];
    Childs.Yerlesim=[];
    Childs.Fv=[];
    % Çaprazlama--------------
    if crossoran==0
    else
        for k=1:(crossoran*popsize)
            fs=RouletteWheelSelection(vertcat(Sonuc.FV));
            ss=RouletteWheelSelection(vertcat(Sonuc.FV));
            YeniBirey=Crossover(Sonuc(fs).Sira,Sonuc(ss).Sira);
            for t=1:2
                if(k==1)
                    Childs(1).Sira=YeniBirey(t,:);
                    Childs(1).Yerlesim=BinPacking(parca,YeniBirey(t,:),15);
                    Childs(1).FV=length(Childs(1).Yerlesim);
                else
                    Childs(end+1).Sira=YeniBirey(t,:);
                    Childs(end).Yerlesim=BinPacking(parca,YeniBirey(t,:),15);
                    Childs(end).FV=length(Childs(end).Yerlesim);
                end
            end
        end
    end
    % Mutasyon----------
    if mutationoran==0
    else
        for k=1:mutationoran*popsize
            ms=RouletteWheelSelection(vertcat(Sonuc.FV));
            Msira=PermutationMutate(Sonuc(ms).Sira);
            Childs(end+1).Sira=Msira;
            Childs(end).Yerlesim=BinPacking(parca,Msira,15);
            Childs(end).FV=length(Childs(end).Yerlesim);
        end
    end
    % Uygun Olaný / En Ýyi Olanlarý Seç
    aktarim=1;
    while aktarim==1
        [A,B]=min(vertcat(Childs.FV));
        [C,D]=max(vertcat(Sonuc.FV));
        if(A<C)
            Sonuc(D).Sira=Childs(B).Sira;
            Sonuc(D).Yerlesim=Childs(B).Yerlesim;
            Sonuc(D).FV=Childs(B).FV;
            Childs(B)=[];
        else
            aktarim=2;
        end
    end
    % En Ýyileri Göster
    disp(['Ýterasyon :' num2str(i) '--Paket Sayýsý :' num2str(min(vertcat(Sonuc.FV)))])
    Childs=[];
end