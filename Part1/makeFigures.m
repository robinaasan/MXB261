function makeFigures(prob1, prob2)
    fig = figure;
    array_values = assessment1Func(100, 1, prob1, prob2);
    subplot(2, 2, 1)
    bar(1:99, array_values)
    title("N=100, P=1", 'Fontsize', 13)
    subplot(2, 2, 2)
    array_values = assessment1Func(100, 0, prob1, prob2);
    bar(1:99, array_values)
    title("N=100, P=rand", 'Fontsize', 13)
    array_values = assessment1Func(400, 1, prob1, prob2);
    subplot(2, 2, 3)
    bar(1:99, array_values)
    title("N=200, P=1", 'Fontsize', 13)
    subplot(2, 2, 4)
    array_values = assessment1Func(400, 0, prob1, prob2);
    bar(1:99, array_values)
    title("N=200, P=rand", 'Fontsize', 13)

    han=axes(fig,'visible','off'); 
    han.Title.Visible='on';
    han.XLabel.Visible='on';
    han.YLabel.Visible='on';
    ylabel(han,'Number of particles (y)', 'Fontsize', 14);
    xlabel(han,'Unit position (x)', 'Fontsize', 14);
    title(han,'Random Walk', 'Fontsize', 14);
end

