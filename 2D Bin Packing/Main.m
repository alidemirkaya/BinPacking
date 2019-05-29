clc
clear all
parcalar=xlsread('Parcalar');
for i=1:length(parcalar)
    parca(i).no=parcalar(i,1);
    parca(i).boy=parcalar(i,2);
end

%% Genetik Algoritma Parametreleri
% Pop�lasyon B�y�kl���
popsize=20;
% �aprazlama Oran�
crossoran=0.6;
% Mutasyon Oran�
mutationoran=0.2;
% Max �terasyon Say�s�
Maxiter=1000;
kromozom=zeros(popsize,length(parca));
% BinPacking(parca,sira,15);
it=1;
% Ba�lang�� Pop�lasyonunu Olu�tur
while it<popsize+1
    gelen=parcasecim([parca.no]);
    if(ismember(gelen,kromozom,'rows')~=0)
        parcasecim([parca.no]);
    else
        kromozom(it,:)=gelen;
        it=it+1;
    end
end
% Ba�lang�� ��z�mleri
for i=1:popsize
    Sonuc(i).Sira=kromozom(i,:);
    Sonuc(i).Yerlesim=BinPacking(parca,kromozom(i,:),15);
    Sonuc(i).FV=length(Sonuc(i).Yerlesim);
end

% Genetik Operat�rler
for i=1:Maxiter
    Childs.Sira=[];
    Childs.Yerlesim=[];
    Childs.Fv=[];
    % �aprazlama--------------
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
    % Uygun Olan� / En �yi Olanlar� Se�
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
    % En �yileri G�ster
    disp(['�terasyon :' num2str(i) '--Paket Say�s� :' num2str(min(vertcat(Sonuc.FV)))])
    Childs=[];
end