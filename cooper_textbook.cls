\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cooper_textbook}[2023/04/04 Cooper's Textbook Class]

% Early requirements ----------------------------------------------------------

% Encoding
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}

% Lengths
\RequirePackage{calc}

% Options and base class ------------------------------------------------------

\def\baseclass{book}

% Color or grayscale highlighting
\newcommand{\coop@hlcolor}{yellow}
\DeclareOption{nocolor}{\renewcommand{\coop@hlcolor}{lightgray}}

% Binding offset options
\newcommand{\coop@bindingoffset}{0in}
\DeclareOption{binding}{\renewcommand{\coop@bindingoffset}{0.25in}}

% Paper size options
\newlength{\coop@basepaperwidth}
\setlength{\coop@basepaperwidth}{176mm} % B5 width
\newlength{\coop@basepaperheight}
\setlength{\coop@basepaperheight}{250mm} % B5 height

\newlength{\coop@margin}
\setlength{\coop@margin}{25mm}

\newlength{\coop@textwidth}
\setlength{\coop@textwidth}{%
    \coop@basepaperwidth-\coop@bindingoffset-\coop@margin-\coop@margin%
}
\newlength{\coop@textheight}
\setlength{\coop@textheight}{%
    \coop@basepaperheight-\coop@margin-\coop@margin%
}

\newcommand{\coop@papersize}{b5paper}

\DeclareOption{b5paper}{}
\DeclareOption{a4paper}{\renewcommand{\coop@papersize}{a4paper}}
\DeclareOption{letterpaper}{\renewcommand{\coop@papersize}{letterpaper}}

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

% Implementing paper size -----------------------------------------------------

\RequirePackage{geometry}
\geometry{
    \coop@papersize,
    inner=\coop@margin,
    top=\coop@margin,
    bindingoffset=\coop@bindingoffset,
    textwidth=\coop@textwidth,
    textheight=\coop@textheight,
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
            vmargin=\coop@margin,
            bindingoffset=\coop@bindingoffset,
            textwidth=\textwidth
        }
        \raggedright
        \Large\@author\par
        \vspace{1.5in}
        \Huge\@title\par
        \vfill
        \normalsize\@titlepagenotes
    \end{titlepage}
}

% Headers and footers ---------------------------------------------------------

\RequirePackage{fancyhdr}

\newcommand{\hfformat}[1]{\normalfont#1}

\fancypagestyle{plain}{
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
    \fancyfoot[LE,RO]{\hfformat{\thepage}}
}
\fancypagestyle{fancy}{
	\fancyhf{}
	\renewcommand{\headrulewidth}{0.5pt}
    \fancyhead[LO]{\hfformat{\nouppercase{\leftmark}}}
    \fancyhead[RE]{\hfformat{\nouppercase{\rightmark}}}
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
	labelwidth=0.35in,
	labelsep*=0.15in,
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
\titlespacing*{\chapter}{0in}{-0.4in}{1.5in}

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