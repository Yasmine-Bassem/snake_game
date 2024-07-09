function snake_game()
                
axis_limit= 15;

x =round(axis_limit/2); %starting point
y =round(axis_limit/2); %starting point
snake(1,1:2)=[x y];%defines the snake for x and y coordinates

a =randi([2 axis_limit-1]);%generates random x coordinate for food 
b =randi([2 axis_limit-1]);%generates random y coordinate for food
food=[a b];%defines food for a and b coordinates
d =randi([1,4]);% generates random direction to start in for snake

size_snake=1;
ate=1;   %snake ate food
exx=0;    % used to exit game

figure('KeyPressFcn',@my_callback);
function my_callback(inputt,event)%callback function for movement
        switch event.Character
            case 'q'
                exx=1;
            case 30               % arrow direction
                if(d~=2)
                    d = 1;              %up d=1
                end
            case 31
                if(d~=1)
                    d = 2;              %down d=2
                end
            case 29
                if(d~=4)
                    d = 3;              %right d=3
                end
            case 28
                if(d~=3)
                    d = 4;              %left d=4
                end
        end
    end
while (exx~=1)%runs the snake as long as q is not pressed
    size_snake=size(snake);
    
    for l=size_snake+ate:-1:2
        snake(l,:)=snake(l-1,:);
    end
    switch d         %calling callback function
        case 1
            snake(1,2)=snake(1,2)+1;%add value of 1 to y position
        case 2
            snake(1,2)=snake(1,2)-1;%subtract value of 1 to y position
        case 3
            snake(1,1)=snake(1,1)+1;%add value of 1 to x position
        case 4
            snake(1,1)=snake(1,1)-1;%subtracts value of 1 to x position
    end
    draw_snake(snake,food,size_snake,axis_limit);%draws the snake
      pause(0.2); %diffculty makes game faster;
      if snake(1,1)==food(1) && snake(1,2)==food(2)%if the snake and food are in the same position
          ate=1;
          food(1) = randi([1 axis_limit-1]);%creates a new x position for the food
          food(2) = randi([1 axis_limit-1]);%creates a new y position for the food
      else
          ate=0;
      end
    
        snake=snake-((snake>axis_limit).*(axis_limit+1));
          snake=snake+((snake<0).*(axis_limit+1));
     
      if (sum(snake(:, 1) ==snake(1, 1)   & snake(:, 2) == snake(1, 2) )>1); %if snake hits itself
          msgbox('YOU LOST! ☺');
          break;
      end
      
      
  end
  close all;
  end
function draw_snake(snake,food,size_snake,axis_limit)
      for p = 1:size_snake
          plot(snake(p,1),snake(p,2), 'ws');
          hold on;
      end
      plot(food(1,1),food(1,2), 'ro')%creates the vectors for the food and snake and plots them
      whitebg([0 0 0]);%creates black background
    
      
      axis([0, axis_limit, 0, axis_limit]);%creates the axis for gameplay
      hold off;
      end