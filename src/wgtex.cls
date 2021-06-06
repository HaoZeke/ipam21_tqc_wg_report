%% wgtex.cls
%% Copyright 2021 Rohit Goswami
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is Rohit Goswami.
%
% This work consists of the files wgtex.cls
% and the derived file main.tex

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wgtex}

\LoadClass{scrbook}
\RequirePackage{marginnote}
\RequirePackage{changepage}
\RequirePackage[usenames,dvipsnames]{xcolor}
\RequirePackage{pgffor}
\RequirePackage{tikz}
\RequirePackage[%
style=numeric,
% style=alphabetic,%
% citestyle=numeric,%
% sorting=nyt,%
% sortcites=true,%
autopunct=true,%
babel=hyphen,%
hyperref=true,%
abbreviate=false,%
backref=true,%
backend=biber]{biblatex}
\RequirePackage{hyperref}
\RequirePackage{mathtools, amsthm} % For math equations, theorems, symbols, etc

% Define the orange color used for highlighting throughout the book
% 243,102,25
\definecolor{accent}{RGB}{0,0,0}
\definecolor{ocre}{RGB}{160,25,25} % Define the orange color used for highlighting throughout the book
\definecolor{grey}{RGB}{50,50,50} % Define the grey color
\definecolor{page}{HTML}{FFFFFF} % white
\definecolor{text}{HTML}{000000} % black

%----------------------------------------------------------------------------------------
%	CLASS CONFIGURATION
%----------------------------------------------------------------------------------------

% Sets the page size
\KOMAoptions{paper = a4}
% Sets the font size
\KOMAoptions{fontsize = 12pt}
% Same margins left and right
\KOMAoptions{twoside = false}
% Makes the titlepage into the cover page
\KOMAoptions{titlepage = firstiscover}
% Add the bibliography to the table of contents
\KOMAoptions{bibliography = totoc}
% Add the index to the table of contents
\KOMAoptions{index = totoc}
% Add Chapter prefix
\KOMAoption{chapterprefix}{true}

%----------------------------------------------------------------------------------------
%	INDEX CONFIGURATION
%----------------------------------------------------------------------------------------

% making the index
\makeindex

%----------------------------------------------------------------------------------------
%	FONTS
%----------------------------------------------------------------------------------------

\RequirePackage{microtype} % Slightly tweak font spacing for aesthetics
\RequirePackage{fontspec} % Xelatex fontenc
\RequirePackage[english]{babel} % Load characters and hyphenation
\RequirePackage[english=british]{csquotes}	% English quotes

\RequirePackage{avant} % Use the Avantgarde font for headings
\RequirePackage[scaled]{helvet}
\RequirePackage{unicode-math}
% Baskerville variant
\setmainfont[Path = Fonts/Baskervaldx/,%
	Extension = .otf,%
  UprightFont = *-Reg,%
	ItalicFont = *-Ita,%
	BoldFont = *-Bol,%
	BoldItalicFont = *-BolIta,%
  Ligatures=NoRequired,%
  Numbers=OldStyle,%
  SmallCapsFeatures={LetterSpace=6}%
]{Baskervaldx}

% Asana
\setmathfont[%
	Path = Fonts/AsanaMath/,%
	Extension = .otf,%
  StylisticSet=1%
]{Asana-Math}

% Cascadia Code PL
\setmonofont[%
	Path = Fonts/Cascadia/,%
	Extension = .otf,%
	UprightFont = *-Regular,%
	ItalicFont = *Italic-Italic,%
	BoldFont = *-Bold,%
	BoldItalicFont = *Italic-BoldItalic%
]{CascadiaCodePL}

\addtokomafont{part}{\normalfont\scshape\bfseries}
\addtokomafont{chapter}{\normalfont\bfseries}
\addtokomafont{section}{\normalfont\bfseries}
\addtokomafont{subsection}{\normalfont\bfseries}
\addtokomafont{subsubsection}{\normalfont\bfseries}
\addtokomafont{paragraph}{\normalfont\bfseries}
\addtokomafont{partentry}{\normalfont\scshape\bfseries}
\addtokomafont{chapterentry}{\normalfont\bfseries}
\setkomafont{descriptionlabel}{\normalfont\bfseries}

%----------------------------------------------------------------------------------------
%	CODE
%----------------------------------------------------------------------------------------
% From BMC https://github.com/tecosaur/BMC/blob/master/bmc.cls

  \RequirePackage{minted}
  \RequirePackage[many]{tcolorbox}

  \setminted{
	frame=none,
	% framesep=2mm,
	baselinestretch=1.2,
	fontsize=\footnotesize,
	highlightcolor=page!95!text!80!primary,
	linenos,
	breakanywhere=true,
	breakautoindent=true,
	breaklines=true,
	tabsize=4,
	xleftmargin=3.5em,
	autogobble=true,
	obeytabs=true,
	python3=true,
	% texcomments=true,
	framesep=2mm,
	breakbefore=\\\.+,
	breakafter=\,
  }

  \BeforeBeginEnvironment{minted}{
	\begin{tcolorbox}[
	  enhanced,
	  overlay={\fill[page!90!text] (frame.south west) rectangle ([xshift=2.8em]frame.north west);},
	  colback=page!95!text,
	  colframe=page!95!text, % make frame colour same as background
	  breakable,% Allow page breaks
	  arc=0pt,outer arc=0pt,sharp corners, % sharp corners
	  boxsep=0pt,left=0pt,right=0pt,top=0pt,bottom=0pt % no margin/paddding
	  ]
	}
	\AfterEndEnvironment{minted}{\end{tcolorbox}}

	\setminted{
	  style=autumn,
	  breaksymbol=\color{page!60!text}\tiny\ensuremath{\hookrightarrow},
	  breakanywheresymbolpre=\,\footnotesize\ensuremath{_{\color{page!60!text}\rfloor}},
	  breakbeforesymbolpre=\,\footnotesize\ensuremath{_{\color{page!60!text}\rfloor}},
	  breakaftersymbolpre=\,\footnotesize\ensuremath{_{\color{page!60!text}\rfloor}},
	}

  \renewcommand\theFancyVerbLine{\color{text!60!page}\arabic{FancyVerbLine}} % minted line numbering

  \let\mintinlineold\mintinline
  \setmintedinline{breaklines,bgcolor={}}
  % FIXME: issue with line breaking (it doesn't)
  \DeclareTotalTCBox{\mintinline}{v v}{
	nobeforeafter,tcbox raise base,
	enhanced, frame hidden, arc=3pt,
	boxsep=0pt,left=3pt,right=3pt,top=2pt,bottom=2pt, % minimal margin/paddding
	colback=page!94!text,
	outer arc=0pt,
	leftrule=0pt,rightrule=0pt,toprule=0pt,bottomrule=0pt
  }{\mintinlineold{#1}{#2}}

%----------------------------------------------------------------------------------------
%	MAIN TABLE OF CONTENTS
%----------------------------------------------------------------------------------------
\newcommand*\hideentrynumber[1]{}
\DeclareTOCStyleEntry[
    entryformat=\mdseries\Large,
    entrynumberformat=\hideentrynumber,
    numwidth=0pt,
    pagenumberformat=\normalfont\normalsize
  ]{tocline}{part}
\DeclareTOCStyleEntry[
    indent=1em,% decreased to 1em, but: do you really want to indent chapter entries?
    pagenumberformat=\normalfont,
    beforeskip=1pt plus .2pt,
    entryformat=\normalfont
    ]{tocline}{chapter}

% ============
% = Chapters =
% ============
% From https://github.com/love0205/kaobook-zh/
 \renewcommand*{\chapterformat}{%
  \mbox{\chapappifchapterprefix{\nobreakspace}\scalebox{2.85}{\color{ocre}\thechapter\autodot}}

 }
 \renewcommand\chapterlinesformat[3]{%
  \vspace*{-4.5cm}
  \makebox[\textwidth+\marginparsep+\marginparwidth]{%
   \parbox[b]{\textwidth}{\hfill ##3}%
   \makebox[\marginparsep][c]{\rule[-.35cm]{1pt}{5.7cm}}%
   \parbox[b]{\marginparwidth}{##2}%
  }
 }
\RedeclareSectionCommand[beforeskip=0pt,afterskip=4\baselineskip]{chapter}

%----------------------------------------------------------------------------------------
%	THEOREM STYLES
%----------------------------------------------------------------------------------------
% From https://github.com/UppASD/UppASD/blob/master/docs/Manual/structure.tex

\newcommand{\intoo}[2]{\mathopen{]}#1\,;#2\mathclose{[}}
\newcommand{\ud}{\mathop{\mathrm{{}d}}\mathopen{}}
\newcommand{\intff}[2]{\mathopen{[}#1\,;#2\mathclose{]}}
\newtheorem{notation}{Notation}[chapter]

% Boxed/framed environments
\newtheoremstyle{ocrenumbox}% % Theorem style name
{0pt}% Space above
{0pt}% Space below
{\normalfont}% % Body font
{}% Indent amount
{\small\bfseries\sffamily\color{ocre}}% % Theorem head font
{\;}% Punctuation after theorem head
{0.25em}% Space after theorem head
{\small\sffamily\color{ocre}\thmname{#1}\nobreakspace\thmnumber{\@ifnotempty{#1}{}\@upn{#2}}% Theorem text (e.g. Theorem 2.1)
\thmnote{\nobreakspace\the\thm@notefont\sffamily\bfseries\color{black}---\nobreakspace#3.}} % Optional theorem note
\renewcommand{\qedsymbol}{$\blacksquare$}% Optional qed square

\newtheoremstyle{blacknumex}% Theorem style name
{5pt}% Space above
{5pt}% Space below
{\normalfont}% Body font
{} % Indent amount
{\small\bfseries\sffamily}% Theorem head font
{\;}% Punctuation after theorem head
{0.25em}% Space after theorem head
{\small\sffamily{\tiny\ensuremath{\blacksquare}}\nobreakspace\thmname{#1}\nobreakspace\thmnumber{\@ifnotempty{#1}{}\@upn{#2}}% Theorem text (e.g. Theorem 2.1)
\thmnote{\nobreakspace\the\thm@notefont\sffamily\bfseries---\nobreakspace#3.}}% Optional theorem note


\newtheoremstyle{blacknumbox} % Theorem style name
{0pt}% Space above
{0pt}% Space below
{\normalfont}% Body font
{}% Indent amount
{\small\bfseries\sffamily}% Theorem head font
{\;}% Punctuation after theorem head
{0.25em}% Space after theorem head
{\small\sffamily\thmname{#1}\nobreakspace\thmnumber{\@ifnotempty{#1}{}\@upn{#2}}% Theorem text (e.g. Theorem 2.1)
\thmnote{\nobreakspace\the\thm@notefont\sffamily\bfseries---\nobreakspace#3.}}% Optional theorem note

\newtheoremstyle{blacknonumbox} % Theorem style name
{0pt}% Space above
{0pt}% Space below
{\normalfont}% Body font
{}% Indent amount
{\small\bfseries\sffamily}% Theorem head font
{\;}% Punctuation after theorem head
{0.25em}% Space after theorem head
{\small\sffamily\thmname{}\nobreakspace{\@ifnotempty{}{}\@upn{}}% Theorem text (e.g. Theorem 2.1)
\thmnote{\nobreakspace#3}}% Optional theorem note


% Non-boxed/non-framed environments
\newtheoremstyle{ocrenum}% % Theorem style name
{5pt}% Space above
{5pt}% Space below
{\normalfont}% % Body font
{}% Indent amount
{\small\bfseries\sffamily\color{ocre}}% % Theorem head font
{\;}% Punctuation after theorem head
{0.25em}% Space after theorem head
{\small\sffamily\color{ocre}\thmname{#1}\nobreakspace\thmnumber{\@ifnotempty{#1}{}\@upn{#2}}% Theorem text (e.g. Theorem 2.1)
\thmnote{\nobreakspace\the\thm@notefont\sffamily\bfseries\color{black}---\nobreakspace#3.}} % Optional theorem note
\renewcommand{\qedsymbol}{$\blacksquare$}% Optional qed square
\makeatother

% Defines the theorem text style for each type of theorem to one of the three styles above

\newcounter{dummy}
\numberwithin{dummy}{section}
\theoremstyle{ocrenumbox}
\newtheorem{theoremeT}[dummy]{Theorem}
%\newtheorem{equationT}{Equation}
\newtheorem{equationT}{Equation}
\newtheorem{equationC}[dummy]{Equation}
\newtheorem{alignT}[dummy]{Equation}
\newtheorem{problem}{Problem}[chapter]
\newtheorem{exerciseT}{Exercise}[chapter]
\theoremstyle{blacknumex}
\newtheorem{exampleT}{Example}[chapter]
\theoremstyle{blacknumbox}
\newtheorem{vocabulary}{Vocabulary}[chapter]
\newtheorem{definitionT}{Definition}[section]
\newtheorem{corollaryT}[dummy]{Corollary}
\theoremstyle{ocrenum}
\newtheorem{proposition}[dummy]{Proposition}
\theoremstyle{blacknonumbox}
\newtheorem{declarationT}{}

%----------------------------------------------------------------------------------------
%	DEFINITION OF COLORED BOXES
%----------------------------------------------------------------------------------------

\RequirePackage[framemethod=default]{mdframed} % Required for creating the theorem, definition, exercise and corollary boxes

% Theorem box
\newmdenv[skipabove=7pt,
skipbelow=7pt,
backgroundcolor=black!5,
linecolor=ocre,
innerleftmargin=5pt,
innerrightmargin=5pt,
innertopmargin=5pt,
leftmargin=0cm,
rightmargin=0cm,
nobreak=true,
innerbottommargin=5pt]{tBox}

% Gray theorem box
\newmdenv[skipabove=7pt,
skipbelow=7pt,
backgroundcolor=black!5,
linecolor=black!90,
innerleftmargin=5pt,
innerrightmargin=5pt,
innertopmargin=5pt,
leftmargin=0cm,
rightmargin=0cm,
nobreak=true,
innerbottommargin=5pt]{gBox}


% Exercise box
\newmdenv[skipabove=7pt,
skipbelow=7pt,
rightline=false,
leftline=true,
topline=false,
bottomline=false,
backgroundcolor=ocre!10,
linecolor=ocre,
innerleftmargin=5pt,
innerrightmargin=5pt,
innertopmargin=5pt,
innerbottommargin=5pt,
leftmargin=0cm,
rightmargin=0cm,
linewidth=4pt]{eBox}

% Definition box
\newmdenv[skipabove=7pt,
skipbelow=7pt,
rightline=false,
leftline=true,
topline=false,
bottomline=false,
linecolor=ocre,
innerleftmargin=5pt,
innerrightmargin=5pt,
innertopmargin=0pt,
leftmargin=0cm,
rightmargin=0cm,
linewidth=4pt,
innerbottommargin=0pt]{dBox}

% Corollary box
\newmdenv[skipabove=7pt,
skipbelow=7pt,
rightline=false,
leftline=true,
topline=false,
bottomline=false,
linecolor=gray,
backgroundcolor=black!5,
innerleftmargin=5pt,
innerrightmargin=5pt,
innertopmargin=5pt,
leftmargin=0cm,
rightmargin=0cm,
linewidth=4pt,
innerbottommargin=5pt]{cBox}

% Text box
\newmdenv[skipabove=7pt,
skipbelow=7pt,
rightline=false,
leftline=false,
topline=false,
bottomline=false,
linecolor=gray,
backgroundcolor=black!5,
innerleftmargin=5pt,
innerrightmargin=5pt,
innertopmargin=5pt,
leftmargin=0cm,
rightmargin=0cm,
linewidth=4pt,
innerbottommargin=5pt]{fBox}

% Creates an environment for each type of theorem and assigns it a theorem text style from the "Theorem Styles" section above and a colored box from above
\newenvironment{theorem}{\begin{tBox}\begin{theoremeT}}{\end{theoremeT}\end{tBox}}
\newenvironment{equationD}{\begin{tBox} \begin{equationC} }{ \end{equationC}\end{tBox}}
\newenvironment{equationB}{\begin{tBox} \begin{equationT} }{ \end{equationT}\end{tBox}}
%\newenvironment{equationB}{\begin{tBox}\begin{equationT}\begin{center}\begin{equation}}{\end{equation}\end{center}\end{equationT}\end{tBox}}
\newenvironment{alignB}{\begin{tBox}\begin{alignT}\begin{center}\begin{equation}}{\end{equation}\end{center}\end{alignT}\end{tBox}}
\newenvironment{exercise}{\begin{eBox}\begin{exerciseT}}{\hfill{\color{ocre}\tiny\ensuremath{\blacksquare}}\end{exerciseT}\end{eBox}}
\newenvironment{definition}{\begin{dBox}\begin{definitionT}}{\end{definitionT}\end{dBox}}
\newenvironment{declaration}{\begin{dBox}\begin{declarationT}}{\end{declarationT}\end{dBox}}
\newenvironment{example}{\begin{exampleT}}{\hfill{\tiny\ensuremath{\blacksquare}}\end{exampleT}}
\newenvironment{corollary}{\begin{cBox}\begin{corollaryT}}{\end{corollaryT}\end{cBox}}
\newenvironment{fileinfo}{\begin{cBox}\begin{declarationT}}{\end{declarationT}\end{cBox}}
%\newenvironment{textinfo}{\begin{tBox}\begin{lstlisting}}{\end{lstlisting}\end{tBox}}

%----------------------------------------------------------------------------------------
%	REMARK ENVIRONMENT
%----------------------------------------------------------------------------------------

\newenvironment{remark}{\par\vspace{10pt}\small % Vertical white space above the remark and smaller font size
\begin{list}{}{
\leftmargin=35pt % Indentation on the left
\rightmargin=25pt}\item\ignorespaces % Indentation on the right
\makebox[-2.5pt]{\begin{tikzpicture}[overlay]
\node[draw=ocre!60,line width=1pt,circle,fill=ocre!25,font=\sffamily\bfseries,inner sep=2pt,outer sep=0pt] at (-15pt,0pt){\textcolor{ocre}{R}};\end{tikzpicture}} % Orange R in a circle
\advance\baselineskip -1pt}{\end{list}\vskip5pt} % Tighter line spacing and white space after remark
