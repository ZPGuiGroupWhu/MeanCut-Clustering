function [] = faceshow(combimg,m,n,cluster)
   [r,s,t] = size(combimg);
   bigimg = zeros(m*r,n*s,3);
   colors = colormap(hsv(max(cluster))); 
   colors = colors(randperm(max(cluster)),:);
   alpha = 0.4;
   for i=1:t
       if(length(find(cluster==cluster(i)))<1)
           tempr = combimg(:,:,i);
           tempg = combimg(:,:,i);
           tempb = combimg(:,:,i);
       else
           tempr = ((1-alpha)*colors(cluster(i),1) + alpha)*combimg(:,:,i);
           tempg = ((1-alpha)*colors(cluster(i),2) + alpha)*combimg(:,:,i);
           tempb = ((1-alpha)*colors(cluster(i),3) + alpha)*combimg(:,:,i);           
       end
           rgbimg = cat(3,tempr,tempg,tempb);
           if(mod(i,m)~=0)
               row_start = r*(mod(i,m)-1)+1;
           else
               row_start = r*(m-1)+1;
           end
           col_start = s*(ceil(i/m)-1)+1; 
           bigimg(row_start:row_start+r-1,col_start:col_start+s-1,:) = rgbimg;
   end
   bigimg = uint8(bigimg);
   imshow(bigimg);
   for i=1:t
       txt = num2str(cluster(i));
       if(mod(i,m)~=0)
           y = r*(mod(i,m)-1)+r/2;
       else
           y = r*(m-1)+r/2;
       end
       x = s*(ceil(i/m)-1)+s/2;
       text(x,y,txt,'horiz','center','Color','white','FontSize',12,'FontWeight','bold');
   end
end