\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cooper_book}[2023/05/13 Cooper's Book Class]

% Early requirements ----------------------------------------------------------

\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}

\RequirePackage{calc}

% Base class and options ------------------------------------------------------

\def\baseclass{book}

% Option to replace title page with custom titlepage.pdf
\DeclareOption{customtitle}{\def\coop@titlepage{titlepage.pdf}}

\newlength{\coop@bindingoffset}
\setlength{\coop@bindingoffset}{0mm}

% Option for binding offset
\DeclareOption{bindingoffset}{\setlength{\coop@bindingoffset}{6mm}}

\newlength{\coop@paperwidth}
\newlength{\coop@paperheight}
\newlength{\coop@basemargin}

% A4 as default paper size with 25 mm margins
\setlength{\coop@paperwidth}{210mm}
\setlength{\coop@paperheight}{297mm}
\setlength{\coop@basemargin}{25mm}

% Paper size options
\DeclareOption{a4paper}{}
\DeclareOption{a5paper}{
    \setlength{\coop@paperwidth}{148mm}
    \setlength{\coop@paperheight}{210mm}
    \setlength{\coop@basemargin}{20mm}
}
\DeclareOption{b5paper}{
    \setlength{\coop@paperwidth}{176mm}
    \setlength{\coop@paperheight}{250mm}
}
\DeclareOption{letterpaper}{
    \setlength{\coop@paperwidth}{8.5in}
    \setlength{\coop@paperheight}{11in}
}
\DeclareOption{octavo}{
    \setlength{\coop@paperwidth}{6in}
    \setlength{\coop@paperheight}{9in}
    \setlength{\coop@basemargin}{20mm}
}

% Option for double-wide outer margin
\DeclareOption{widemargin}{\def\coop@widemargin{1}}

% Option for sentence case in headings
\DeclareOption{sentencecase}{%
    \renewcommand{\listfigurename}{List of figures}
    \renewcommand{\listtablename}{List of tables}
}

% Suppress remaining book class options
\DeclareOption{legalpaper}{\OptionNotUsed}
\DeclareOption{executivepaper}{\OptionNotUsed}
\DeclareOption{landscape}{\OptionNotUsed}
\DeclareOption{openany}{\OptionNotUsed}
\DeclareOption{twocolumn}{\OptionNotUsed}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\baseclass}}

\ProcessOptions\relax
\LoadClass{\baseclass}

% Geometry --------------------------------------------------------------------

\RequirePackage{geometry}

% Calculate outer margin depending on `widemargin` option
\newlength{\coop@outermargin}
\ifdefined\coop@widemargin
    \setlength{\coop@outermargin}{\coop@basemargin*2}
\else
    \setlength{\coop@outermargin}{\coop@basemargin}
\fi

\newlength{\coop@marginpar}
\setlength{\coop@marginpar}{\coop@outermargin-5mm}

\geometry{
    paperwidth=\coop@paperwidth,
    paperheight=\coop@paperheight,
    vmargin=\coop@basemargin,
    inner=\coop@basemargin,
    outer=\coop@outermargin,
    marginpar=\coop@marginpar,
    bindingoffset=\coop@bindingoffset
}

% Headings --------------------------------------------------------------------

\RequirePackage[rigidchapters]{titlesec}

% Where body text starts at new chapters, fixed height from top margin due to
% `rigidchapters` option
\newlength{\coop@textstart}
\setlength{\coop@textstart}%
    {\coop@paperheight*\real{0.333}-\coop@basemargin}

\titleformat{\chapter}[display]%
    {\normalfont\bfseries\Large}%
    {\chaptertitlename\ \thechapter}%
    {0em}%
    {\huge}

\titlespacing*{\chapter}{0pt}{-\f@size pt}{\coop@textstart}
\titlespacing*{\section}{0pt}{7ex plus 1ex minus 0.2ex}{3.5ex plus 0.2ex}
\titlespacing*{\subsection}{0pt}{4ex plus 1ex minus 0.2ex}{2ex plus 0.2ex}

% Command for unnumbered sections
\newcommand{\sectionnumberless}[1]{%
    \section*{#1}%
    \addcontentsline{toc}{section}{#1}%
    \markright{#1}%
}

% Title page ------------------------------------------------------------------

\RequirePackage{pdfpages}

\gdef\@titlepagenotes{\@date}
\newcommand{\titlepagenotes}[1]{\gdef\@titlepagenotes{#1}}

\newlength{\coop@titlewidth}
\setlength{\coop@titlewidth}{\coop@paperwidth*\real{0.667}-\coop@basemargin}

\renewcommand{\maketitle}{%
    \begin{titlepage}%
        \ifdefined\coop@titlepage%
            \includepdf[pages={1}]{\coop@titlepage}%
        \else%
            \noindent\parbox[t][0pt][t]{\coop@titlewidth}%
                {\vspace*{\coop@textstart}\raggedright\Huge\@title}\par
            \raggedright
            \vspace*{-\f@size pt}\Large\@author\par
            \vfill
            \normalsize\@titlepagenotes%
        \fi
    \end{titlepage}
}

% Headers and footers ---------------------------------------------------------

\RequirePackage{fancyhdr}
\RequirePackage{emptypage}

% Chapter and section labels in header
\renewcommand{\sectionmark}[1]%
    {\markright{\thesection\quad#1}}
\renewcommand{\chaptermark}[1]%
    {\markboth{\if@mainmatter\thechapter\quad\fi#1}{}}

\fancypagestyle{plain}{
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
    \fancyfoot[C]{\thepage}
}
\fancypagestyle{standard}{
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
    \fancyhead[LO]{\nouppercase{\rightmark}}
    \fancyhead[RE]{\nouppercase{\leftmark}}
    \fancyhead[LE,RO]{\thepage}
}
\pagestyle{standard}

% Numbered lists --------------------------------------------------------------

\RequirePackage{enumitem}

\newlength{\coop@labelwidth}
\newlength{\coop@labelsep}
% Total space from left margin is half of base margin
\setlength{\coop@labelwidth}{\coop@basemargin*\real{0.375}}
\setlength{\coop@labelsep}{\coop@basemargin*\real{0.125}}

\setlist[enumerate]{
    listparindent=\parindent,
    parsep=\parskip,
    itemsep=\f@size pt,
	labelindent=0pt,
	labelwidth=\coop@labelwidth,
	labelsep*=\coop@labelsep,
	leftmargin=!,
	align=left
}
\setlist[enumerate,1]{label=(\arabic*)}
\setlist[enumerate,2]{label=(\roman*)}

% Links -----------------------------------------------------------------------

\RequirePackage[hidelinks]{hyperref}

% Frontmatter -----------------------------------------------------------------

\newcommand{\coop@prefacename}{Preface}

\newenvironment{preface}[1]{%
    \thispagestyle{plain}
    \chapter{\ifdefined#1 #1\else\coop@prefacename\fi}
}{}