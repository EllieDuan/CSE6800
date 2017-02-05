clc;clear;

states=['S','L','P']; %The N "hidden" states
N=length(states);
emmision_letters=['1','2','3']; % the emission letters.

%Initial Probabilities of states has equalized probablity.
I_prob=[0.2, 0.4,0.4]';
% Transition probabilities of states
T_prob=[0.1 0.5 0.4; 0.9 0.05 0.05; 0.7 0.2 0.1]; 
% Emission prob( Prob of emission letters from given the state)
E_prob=[0.7 0.2 0.1; 0.9 0.05 0.05; 0.6 0.3 0.1]';

input_em={'pasta','salad','lasagna','pasta','salad'}; % emission letters
emlist=[3 1 2 3 1]; %generate the list of the emission letters.


 lem=length(emlist);
 
 M=zeros(N,lem); % the table hold the values
 Back_track=M; % hold the best preceding state's index for back trace
 mx=zeros(1, lem); %hold the best score 
 
 for i=1:lem
     if i==1 
         %Vq(1)=Aq_0q*Eq(x1)
         M(:,i)=I_prob.*E_prob(emlist(i),:)'; %from the start state and use the 1st emission letter
         [p,mx(i)]=max(M(:,i));
         Back_track(:,i)=0;
     continue;
     end
     
    for j=1:N
        [M(j,i),Back_track(j,i)]=max(M(:,i-1).*T_prob(:,j)); % gives the best state's index
    end
   %Vq(i)=max{Vq'(i-1)*Aqq'*Eq(xi)}
    M(:,i)=M(:,i).* E_prob(emlist(i),:)'; 
    [p,mx(i)]=max(M(:,i));  
 end
 
 %print the state path
 
 for i=lem-1:-1:1
    mx(i)=Back_track(mx(i+1),i+1);
 end
 
  state_path=cell(1,lem);
 for i=1:lem
     state_path{i}=states(mx(i));
 end
 
 char(state_path)'
 