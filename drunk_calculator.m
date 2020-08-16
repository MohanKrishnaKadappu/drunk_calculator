function drunk_calculator


%% create the body of calculator

monsize = get(0,'ScreenSize');

%set up the figure. Note that position corresponds to
%left,bottom,[width,height].
calcfig = figure('Position',[123 456 monsize(3)*.25 monsize(4)*.25],'menubar','none','name','Yes, officier,I''m a calculator','Numbertitle','off');

% fix the size of the calcy
set(calcfig,'resize','off','color',[1 1 1]*.4)

figsize = get(calcfig,'Position');
figsize = figsize(3:4);

%% put some buttons on the body

%locations of the button positions
xfracs = linspace(.1,.5,3);
yfracs = linspace(.6,.1,4);

%create button for digits
for bnum=1:10
    
    h(bnum) = uicontrol('style','pushbutton',...
        'string',num2str(mod(bnum,10)),...
        'Fontsize',11,...
        'Callback',@but,...
        'Position',[xfracs(mod(bnum-1,3)+1)*figsize(1) yfracs(ceil(4*bnum/12))*figsize(2) 60 30]);
end

% buttons for + - / *
symbs = '+-/*';
for si=1:length(symbs)
    
    uicontrol('style','pushbutton',...
        'string',symbs(si),...
        'Fontsize',15,...
        'Callback',@but,...
        'Position',[.8*figsize(1) yfracs(si)*figsize(2) 60 30]);
end

%equals sign
uicontrol('style','pushbutton',...
    'string','=',...
    'Fontsize',15,...
    'Callback',@but,...
    'Position',[.3*figsize(1) .1*figsize(2) 136 30]);

%clear button
uicontrol('style','pushbutton',...
    'string','clear',...
    'Fontsize',15,...
    'Callback',@but,...
    'Position',[.675*figsize(1) .1*figsize(2) 46 30]);
%display bar
txth = uicontrol('style','text',...
    'string','',...
    'Fontsize',15,...
    'Callback',@but,...
    'backgroundcolor',[1 1 1]*.6,...
    'HorizontalAlignment','right',...
    'Position',[.1*figsize(1) .78*figsize(2) .87*figsize(1) 35]);


asdf = 4;

%% create a blank function

function but(source,eventdata)
    
    %flash the color of the calling button
    set(source,'BackgroundColor',[.4 .5 .8])
    pause(.1)
    set(source,'BackgroundColor',[1 1 1]*.94)
    % update the display so that the pressed button shows up
    whichbutton = get(source,'string');
    displaytext = get(txth,'String');
    
    %see if user pressed equals sign
    if isequal(whichbutton,'=')
        
        try
            result = num2str(eval( displaytext ));
            set(txth,'String',[ '= ' result ])
        catch me;
            set(txth,'string',[ '= ' getaphrase]);
        end
        
        
    %if the user clears the screen
    elseif isequal(whichbutton,'clear')
            set(txth,'string','')
    
    %not equals sign; update display
    else
        
        %clean the display if'=' is the first character
        if isempty(displaytext) || isequal(displaytext(1),'=')
            set(txth,'string',whichbutton);
        else
            set(txth,'string',[displaytext whichbutton]);
        end
        
    end
    
end  % end of but function

%randomly change button label
if rand>.9
    changebutton;
end

function msg = getaphrase
    allmsg = {...
        'oh, I have had one too many.',...
        'no, you shut up!',...
        'I''m not drunk, you''re a... wait,what?',...
        'I love you, man.',...
        'Last call? But I just got here!',...
        'Calculator? But I hardly know her!',...
        'Don''t worry about me, I''l get home.'...
        'Tequilla for me? Tequilla for everyone!'
        };
     msg = allmsg{randi(length(allmsg))};
end

function changebutton
    set(h(randi(10)),'string',num2str(randi(10)-1));
end

end