;;; org2tex.el --- A mass exporter
;;; Commentary:
;; Emacs script for exporting an org file in current directory to LaTeX
;; Use with Emacs --script
;; Inspired by https://github.com/fangohr/template-latex-paper-from-orgmode/blob/master/paper/org-files-to-tex.el
;
;; Author: Rohit Goswami, 5/05/2021
;; Email: rog32@hi.is
;; Date: 5/05/2021
;
;; Original Author (OA): Sam Sinayoko, Hans Fangohr, 27/12/2015
;; OA Email: s.sinayoko@soton.ac.uk
;; Date: 05/10/2014

;;; Code:

; Getting org-ref
;; MELPA setup and initial packages
(require 'package)
(setq package-check-signature nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents   (package-refresh-contents))
(package-install 'use-package)
(package-install 'org)

(dolist (package '(use-package))
   (unless (package-installed-p package)
       (package-install package)))

(use-package org-ref
   :ensure t)

(require 'ox-latex)
;; Got org-ref
(add-to-list 'org-latex-classes
             '("wgtex" "\\documentclass{wgtex}"
               ("\\part{%s}" . "\\part*{%s}")
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(setq org-latex-packages-alist 'nil)
(setq org-latex-minted-options 'nil)
(setq org-latex-listings 'minted)
(setq org-latex-default-packages-alist
  '(
    (""     "graphicx"  t)
    (""     "lipsum"  t)
;; Extra
;;    (""     "minted"   t)
    (""     "rotating"  nil)
    ("normalem" "ulem"  t)
    (""     "mathtools"   t)
    ))


;; Define an interactive function for easy testing
(defun org-beamer-export-to-pdf-directory (files)
  "Export all FILES to latex."
  (interactive "Export org files to tex")

;; the next section allows to add :ignoreheading: to section headers,
;; and the heading will be removed in the latex output, but the section
;; itself be included.
;;
;; This is useful to 'label' paragraphs or sections to draft a document
;; while not wanting to reveal that label/title in the final version to the
;; reader.
(defun sa-ignore-headline (contents backend info)
  "Ignore headlines with tag `ignoreheading', CONTENTS is used to determine the case of the property, BACKEND is the allowed backend, and INFO is also present."
  (when (and (org-export-derived-backend-p backend 'latex 'html 'ascii)
             (string-match "\\(\\`.*\\)ignoreheading\\(.*\n\\)"
                           (downcase contents)))
                                        ;(replace-match "\\1\\2" nil nil contents)  ;; remove only the tag ":ignoreheading:" but keep the rest of the headline
    (replace-match "" nil nil contents)        ;; remove entire headline
    ))
(add-to-list 'org-export-filter-headline-functions 'sa-ignore-headline)
  (save-excursion
    (let ((org-files-lst ))
      (dolist (org-file files)
        (message "*** Exporting file %s ***" org-file)
        (find-file org-file)
        (org-latex-export-to-latex)
        (kill-buffer)))))

;; Export all org files given on the command line
(org-beamer-export-to-pdf-directory argv)

;; Local Variables:
;; mode: emacs-lisp
;; End:
