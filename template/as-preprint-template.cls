\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{as-preprint-template}[2021-03-09 Template for Alberto Santini's preprints]

\LoadClass[11pt,a4paper]{article}
\RequirePackage[margin=2cm]{geometry}
\RequirePackage{parskip}
\RequirePackage{microtype}
\RequirePackage{authblk}
\RequirePackage{paracol}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{xcolor}

%%% The four things each class should contain (according to the Overleaf guide):
% A definition of the font size using \fontsize{<font height>}{<line height>}.
% Here I use the article/11pt defaults (11pt and 13.6pt).
\renewcommand{\normalsize}{\fontsize{11pt}{13.6pt}\selectfont}
% A default value for textwidth:
% I use A4's width (21cm) minus 2cm margin left and 2cm margin right.
\setlength{\textwidth}{17cm}
% A default value for textheight:
% I use A4's height (29.7cm) minus 2cm margin top and 2cm margin bottom.
\setlength{\textheight}{25.7cm}
% Depth of numbering:
% I number sections, subsections, and sub-subsections (i.e., 3 levels).
\setcounter{secnumdepth}{3}

% Note: I am not sure why I cannot inherit the four things above from the article
% class or if loading geometry is going to change them (and why or why not)!

% Command to add an author with their affiliation.
% I first define a counter for the authors.
\newcounter{authorn}
\setcounter{authorn}{1}
% This command takes 3 params: the author's first name(s), his last name(s), and
% his affiliation.
\newcommand{\addAuthor}[3]{%
    \author[\theauthorn]{#1 #2} % Add the author
    \affil[\theauthorn]{#3} % Add his affiliation
    \@namedef{@asauthorfirst\theauthorn}{#1} % Save the author's first name(s)
    \@namedef{@asauthorlast\theauthorn}{#2} % Save the author's last name(s)
    \stepcounter{authorn} % Increase the author number counter
}

% Commands to add paper info.
\newcommand{\setTitle}[1]{%
    \newcommand{\@astitle}{#1} % Save the title
    \title{#1} % Set the title to use with \maketitle
}
\newcommand{\setJournal}[1]{%
    \newcommand{\@asjournal}{#1} % Save the journal name
}
\newcommand{\setVolume}[1]{%
    \newcommand{\@asvolume}{#1} % Save the journal's volume
}
\newcommand{\setNumber}[1]{%
    \newcommand{\@asnumber}{#1} % Save the journal's number
}
\newcommand{\setPages}[1]{%
    \newcommand{\@aspages}{#1} % Save the article's pages in the journal
}
\newcommand{\setDoi}[1]{%
    \newcommand{\@asdoi}{#1} % Save the article's DOI
}
\newcommand{\setYear}[1]{%
    \newcommand{\@asyear}{#1} % Save the article's year
}
\newcommand{\setUrl}[1]{%
    \newcommand{\@asurl}{#1} % Save the article's url
}

% Commands to print the cover page
\newcommand{\printCover}{%
    \clearpage\thispagestyle{empty}
    {\LARGE \@astitle{}}\\[1em]
    
    \setlength{\fboxsep}{1em}
    \framebox[\linewidth]{\centering This preprint is available at \url{https://santini.in/}}\\[1em]
    
    A final version of this preprint is published as follows:
    
    \columnratio{0.2,0.8}
    \newcounter{coverauthn}
    \setcounter{coverauthn}{1}
    \@whilenum{\value{coverauthn}<\value{authorn}}\do{
        \begin{paracol}{2}
            {\bf Author \thecoverauthn:}
        \switchcolumn
            \@nameuse{@asauthorfirst\thecoverauthn} \@nameuse{@asauthorlast\thecoverauthn}
        \end{paracol}
        \stepcounter{coverauthn}
    }
    \begin{paracol}{2}
        {\bf Journal:}
    \switchcolumn
        \@asjournal
        \ifcsname @asnumber\endcsname ~n.~\@asnumber\fi
        \ifcsname @asvolume\endcsname ~(vol.~\@asvolume)\fi
        \ifcsname @aspages\endcsname , pp.~\@aspages\fi
        ~(\@asyear).
    \end{paracol}
    
    \vspace{1em}
    
    The final version is available at: \url{\@asurl}
    
    \vspace{3em}
    
    You can cite the final version of this paper as:
        
    {\tt%
        @article\{\@nameuse{@asauthorlast1}\@asyear,\\
            \-\quad title=\{\@astitle\},\\
            \-\quad journal=\{\@asjournal\},\\
            \ifcsname @asvolume\endcsname%
            \-\quad volume=\{\@asvolume\},\\
            \fi
            \ifcsname @asnumber\endcsname%
            \-\quad number=\{\@asnumber\},\\
            \fi
            \ifcsname @aspages\endcsname%
            \-\quad pages=\{\@aspages\},\\
            \fi
            \ifcsname @asdoi\endcsname%
            \-\quad doi=\{\@asdoi\},\\
            \fi
            \-\quad year=\{\@asyear\}\\
        \}
    }
    \clearpage\pagenumbering{arabic}
}