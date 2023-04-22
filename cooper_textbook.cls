\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cooper_textbook}[2023/04/04 Cooper's Textbook Class]

% Early requirements ----------------------------------------------------------

% Encoding
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}

% Options and base class ------------------------------------------------------

\def\baseclass{book}

% Color or grayscale highlighting
\newcommand{\coop@hlcolor}{yellow}
\DeclareOption{nocolor}{\renewcommand{\coop@hlcolor}{lightgray}}

% Binding offset options
\newcommand{\coop@bindingoffset}{0.25in}
\DeclareOption{nobinding}{\renewcommand{\coop@bindingoffset}{0in}}

% Paper size options
\newcommand{\coop@papersize}{a4paper}
\newcommand{\coop@innermargin}{1.25in}
\newcommand{\coop@outermargin}{2in}
\newcommand{\coop@vmargin}{1.5in}

\DeclareOption{a4paper}{}
\DeclareOption{letterpaper}{\renewcommand{\coop@papersize}{letterpaper}}
\DeclareOption{b5paper}{
    \renewcommand{\coop@papersize}{b5paper}
    \renewcommand{\coop@innermargin}{1in}
    \renewcommand{\coop@outermargin}{1in}
    \renewcommand{\coop@vmargin}{1in}
}

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
    inner=\coop@innermargin,
    outer=\coop@outermargin,
    vmargin=\coop@vmargin,
    bindingoffset=\coop@bindingoffset
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
            left=1in,
            vmargin=\coop@vmargin,
            bindingoffset=\coop@bindingoffset,
            textwidth=4.5in
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