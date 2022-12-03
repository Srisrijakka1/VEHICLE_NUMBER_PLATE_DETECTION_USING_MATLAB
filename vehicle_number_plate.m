a=imread(uigetfile('.jpg'));
a=rgb2gray(a);
figure;imshow(a);title('car');
[r c p]=size(a);
b=a(r/3:r,1:c);
 imshow(b);title('LP AREA')
[r c p]=size(b);
Out=zeros(r,c);
for i=1:r
    for j=1:c
      if b(i,j)>150
            Out(i,j)=1;
        else
            Out(i,j)=0;
        end
    end
end
% load Out;
BW3 = bwfill(Out,'holes');
BW3=medfilt2(BW3,[4 4]);
BW3=medfilt2(BW3,[4 4]);
BW3=medfilt2(BW3,[4 4]);
BW3=medfilt2(BW3,[5 5]);
BW3=medfilt2(BW3,[5 5]);
figure;imshow(BW3,[]);
BW3 = bwfill(BW3,'holes');
[L num]=bwlabel(BW3);
STATS=regionprops(L,'all');
disp(num);
% close all;
cc=[];
removed=0;
for i=1:num
dd=STATS(i).Area;
cc(i)=dd;
	if (dd < 50000)
          	L(L==i)=0;
			removed = removed + 1;
            num=num-1;
    end
end
[L2 num2]=bwlabel(L);
figure,imshow(L2);
 STATS = regionprops(L2,'All');
if num2>2
     for i=1:num2    
	aa=  STATS(i).Orientation;    
	if aa > 0
        
	imshow(L==i);    
	end
     end
	disp('exit');
end
 [r c]=size(L2);
Out=zeros(r,c);
k=1;
 B=STATS.BoundingBox;
Xmin=B(2);
Xmax=B(2)+B(4);
Ymin=B(1)
Ymax=B(1)+B(3);
LP=[];
LP=b(Xmin+25:Xmax-20,Ymin+10:Ymax-10);
figure,imshow(LP,[]);