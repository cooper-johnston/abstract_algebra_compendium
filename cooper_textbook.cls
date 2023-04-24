\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cooper_textbook}[2023/04/22 Cooper's Textbook Class]

% Early requirements ----------------------------------------------------------

% Encoding
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}

% Lengths
\RequirePackage{calc}

% Base class, paper size, and margins -----------------------------------------

\def\baseclass{book}

% Binding offset options
\newcommand{\coop@bindingoffset}{0mm}
\DeclareOption{binding}{\renewcommand{\coop@bindingoffset}{6mm}}

% Base paper dimensions (B5)
\newlength{\coop@basepaperwidth}
\setlength{\coop@basepaperwidth}{176mm} % B5 width
\newlength{\coop@basepaperheight}
\setlength{\coop@basepaperheight}{250mm} % B5 height

% Margin size for base paper
\newlength{\coop@margin}
\setlength{\coop@margin}{25mm}

\newlength{\coop@textwidth}
\setlength{\coop@textwidth}{%
    \coop@basepaperwidth-\coop@margin-\coop@margin%
}
\newlength{\coop@textheight}
\setlength{\coop@textheight}{%
    \coop@basepaperheight-\coop@margin-\coop@margin%
}

% Default paper dimensions (B5)
\newlength{\coop@paperwidth}
\setlength{\coop@paperwidth}{176mm} % B5 width
\newlength{\coop@paperheight}
\setlength{\coop@paperheight}{250mm} % B5 heght

\newlength{\coop@topmargin}
\setlength{\coop@topmargin}{\coop@margin}

\newlength{\coop@marginpar}
\setlength{\coop@marginpar}{\coop@margin-\coop@bindingoffset-5mm}

% Options
\DeclareOption{b5paper}{}
\DeclareOption{a4paper}{
    \setlength{\coop@paperwidth}{210mm}
    \setlength{\coop@paperheight}{297mm}
    \setlength{\coop@topmargin}{(\coop@paperheight-\coop@textheight)/2}
    \setlength{\coop@marginpar}%
        {\coop@paperwidth-\coop@bindingoffset-\coop@margin-\coop@textwidth-5mm}
}
\DeclareOption{letterpaper}{
    \setlength{\coop@paperwidth}{8.5in}
    \setlength{\coop@paperheight}{11in}
    \setlength{\coop@topmargin}{(\coop@paperheight-\coop@textheight)/2}
    \setlength{\coop@marginpar}%
        {\coop@paperwidth-\coop@bindingoffset-\coop@margin-\coop@textwidth-5mm}
}

% Other options ---------------------------------------------------------------

% Color or grayscale highlighting
\newcommand{\coop@hlcolor}{yellow}
\DeclareOption{nocolor}{\renewcommand{\coop@hlcolor}{lightgray}}

% Suppress other book class options
\DeclareOption{a5paper}{\OptionNotUsed}
\DeclareOption{legalpaper}{\OptionNotUsed}
\DeclareOption{executivepaper}{\OptionNotUsed}
\DeclareOption{landscape}{\OptionNotUsed}
\DeclareOption{openany}{\OptionNotUsed}
\DeclareOption{twocolumn}{\OptionNotUsed}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\baseclass}}

\ProcessOptions\relax
\LoadClass{\baseclass}

% Implementing geometry -------------------------------------------------------

\RequirePackage{geometry}
\geometry{
    paperwidth=\coop@paperwidth,
    paperheight=\coop@paperheight,
    inner=\coop@margin,
    top=\coop@topmargin,
    bindingoffset=\coop@bindingoffset,
    textwidth=\coop@textwidth,
    textheight=\coop@textheight,
    marginpar=\coop@marginpar
}

% Highlighting and color ------------------------------------------------------

\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{soul}

\sethlcolor{\coop@hlcolor}

% Command for highlighting defined terms
\newcommand{\defnem}[1]{\hl{#1}}

% Title page ------------------------------------------------------------------

\gdef\@titlepagenotes{\@date}
\newcommand{\titlepagenotes}[1]{\gdef\@titlepagenotes{#1}}

\renewcommand{\maketitle}{%
    \begin{titlepage}%
        \newgeometry{
            left=\coop@margin,
            top=\coop@topmargin,
            bindingoffset=\coop@bindingoffset,
            textwidth=110mm,
            textheight=\coop@textheight
        }
        \raggedright
        \Large\@author\par
        \vspace{40mm}
        \Huge\@title\par
        \vfill
        \normalsize\@titlepagenotes
    \end{titlepage}
}

% Headers and footers ---------------------------------------------------------

\RequirePackage{fancyhdr}

% Chapter and section labels in header
\renewcommand{\sectionmark}[1]%
    {\markright{\thesection\quad#1}}
\renewcommand{\chaptermark}[1]%
    {\markboth{\if@mainmatter\thechapter\quad\fi#1}{}}

\newcommand{\hfformat}[1]{\normalfont#1}

\fancypagestyle{plain}{
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
    \fancyfoot[LE,RO]{\hfformat{\thepage}}
}
\fancypagestyle{fancy}{
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
    \fancyhead[LO]{\hfformat{\nouppercase{\rightmark}}}
    \fancyhead[RE]{\hfformat{\nouppercase{\leftmark}}}
    \fancyhead[LE,RO]{\hfformat{\thepage}}
}
\pagestyle{fancy}

\RequirePackage{emptypage}

% Numbered lists --------------------------------------------------------------

\RequirePackage{enumitem}

\setlist[enumerate]{
    listparindent=16pt,
    parsep=0pt,
    itemsep=10pt,
	labelindent=0in,
	labelwidth=8mm,
	labelsep*=4mm,
	leftmargin=!,
	align=left
}
\setlist[enumerate,1]{label=(\arabic*)}
\setlist[enumerate,2]{label=(\roman*)}

% Headings --------------------------------------------------------------------

\RequirePackage{titlesec}

\newcommand{\coop@headingstyle}{\bfseries}

\titleformat{\chapter}[display]%
    {\normalfont\coop@headingstyle\Large}%
    {\chaptertitlename\ \thechapter}%
    {0em}%
    {\huge}
\titlespacing*{\chapter}{0pt}{-24pt}{40mm}

% Command for unnumbered sections
\newcommand{\sectionnumberless}[1]{%
    \section*{#1}%
    \addcontentsline{toc}{section}{#1}%
    \markright{#1}%
}

% Math ------------------------------------------------------------------------

\RequirePackage{amsmath, amssymb, amsthm}

\renewcommand{\qedsymbol}{$ \blacksquare $}

\newenvironment{sltn}%
    {%
        \begin{proof}[Solution]
        \renewcommand{\qedsymbol}{$ \square $}
    }%
    {\end{proof}}

% Links -----------------------------------------------------------------------

\RequirePackage[hidelinks]{hyperref}

% Paragraph spacing and indentation -------------------------------------------

\RequirePackage{parskip}