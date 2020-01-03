;; [[file:~/.emacs.d/myinit.org::*Repos][Repos:1]]
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
;; Repos:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Ansible][Ansible:1]]
(use-package ansible
:ensure t)
;; Ansible:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Ace-window][Ace-window:1]]
(use-package ace-window
    :ensure t)
(global-set-key (kbd "M-o") 'ace-window)
(setq aw-background nil)
(defvar aw-dispatch-alist
  '((?x aw-delete-window "Delete Window")
	(?m aw-swap-window "Swap Windows")
	(?M aw-move-window "Move Window")
	(?c aw-copy-window "Copy Window")
	(?j aw-switch-buffer-in-window "Select Buffer")
	(?n aw-flip-window)
	(?u aw-switch-buffer-other-window "Switch Buffer Other Window")
	(?c aw-split-window-fair "Split Fair Window")
	(?v aw-split-window-vert "Split Vert Window")
	(?b aw-split-window-horz "Split Horz Window")
	(?o delete-other-windows "Delete Other Windows")
	(?? aw-show-dispatch-help))
  "List of actions for `aw-dispatch-default'.")
;; Ace-window:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Auto-yasnippet][Auto-yasnippet:1]]
(use-package auto-yasnippet
:ensure t)
;; Auto-yasnippet:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Avy][Avy:1]]
(use-package avy
  :ensure t
  :bind ("M-s" . avy-goto-word-1)) ;; changed from char as per jcs
;; Avy:1 ends here

;; [[file:~/.emacs.d/myinit.org::*c++][c++:1]]
(use-package ggtags
:ensure t
:config 
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))
)
;; c++:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Company][Company:1]]
(use-package company
    :ensure t
    :config
        (setq company-idle-delay 0)
        (setq company-minimum-prefix-length 0)
        (setq company-show-numbers t)
        (setq company-tooltip-limit 10)
        (setq company-tooltip-align-annotations t)
        (setq company-tooltip-flip-when-above t)
        (global-company-mode t))
(use-package company-quickhelp
    :ensure t)
(company-quickhelp-mode 1)
(setq company-quickhelp-delay 0)

(use-package company-irony
:ensure t
:config 
(add-to-list 'company-backends 'company-irony))

(use-package irony
:ensure t
:config
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(use-package irony-eldoc
:ensure t
:config
(add-hook 'irony-mode-hook #'irony-eldoc))
;; Company:1 ends here

;; [[file:~/.emacs.d/myinit.org::*DIRED][DIRED:1]]
; wiki melpa problem
;(use-package dired+
;  :ensure t
;  :config (require 'dired+)
;  )
;; DIRED:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Docker][Docker:1]]
(use-package dockerfile-mode
:ensure t)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
;; Docker:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Emmet%20mode][Emmet mode:1]]
(use-package emmet-mode
:ensure t
:config
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'web-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
(add-hook 'less-mode-hook 'emmet-mode)
(add-hook 'emmet-mode-hook
          (lambda ()
            (setq emmet-indentation 2)))
(setq emmet-preview-default nil)
)
;; Emmet mode:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Flycheck][Flycheck:1]]
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))
;; Flycheck:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Hydra][Hydra:1]]
(use-package hydra 
    :ensure hydra
    :init 
    (global-set-key
    (kbd "C-x t")
	    (defhydra toggle (:color blue)
	      "toggle"
	      ("a" abbrev-mode "abbrev")
	      ("s" flyspell-mode "flyspell")
	      ("d" toggle-debug-on-error "debug")
	      ("c" fci-mode "fCi")
	      ("f" auto-fill-mode "fill")
	      ("t" toggle-truncate-lines "truncate")
	      ("w" whitespace-mode "whitespace")
	      ("q" nil "cancel")))
    (global-set-key
     (kbd "C-x j")
     (defhydra gotoline 
       ( :pre (linum-mode 1)
	      :post (linum-mode -1))
       "goto"
       ("t" (lambda () (interactive)(move-to-window-line-top-bottom 0)) "top")
       ("b" (lambda () (interactive)(move-to-window-line-top-bottom -1)) "bottom")
       ("m" (lambda () (interactive)(move-to-window-line-top-bottom)) "middle")
       ("e" (lambda () (interactive)(end-of-buffer)) "end")
       ("c" recenter-top-bottom "recenter")
       ("n" next-line "down")
       ("p" (lambda () (interactive) (forward-line -1))  "up")
       ("g" goto-line "goto-line")
       ))
    (global-set-key
     (kbd "C-c t")
     (defhydra hydra-global-org (:color blue)
       "Org"
       ("t" org-timer-start "Start Timer")
       ("s" org-timer-stop "Stop Timer")
       ("r" org-timer-set-timer "Set Timer") ; This one requires you be in an orgmode doc, as it sets the timer for the header
       ("p" org-timer "Print Timer") ; output timer value to buffer
       ("w" (org-clock-in '(4)) "Clock-In") ; used with (org-clock-persistence-insinuate) (setq org-clock-persist t)
       ("o" org-clock-out "Clock-Out") ; you might also want (setq org-log-note-clock-out t)
       ("j" org-clock-goto "Clock Goto") ; global visit the clocked task
       ("c" org-capture "Capture") ; Don't forget to define the captures you want http://orgmode.org/manual/Capture.html
	     ("l" (or )rg-capture-goto-last-stored "Last Capture"))

     ))

(defhydra multiple-cursors-hydra (:hint nil)
  "
     ^Up^            ^Down^        ^Other^
----------------------------------------------
[_p_]   Next    [_n_]   Next    [_l_] Edit lines
[_P_]   Skip    [_N_]   Skip    [_a_] Mark all
[_M-p_] Unmark  [_M-n_] Unmark  [_r_] Mark by regexp
^ ^             ^ ^             [_q_] Quit
"
  ("l" mc/edit-lines :exit t)
  ("a" mc/mark-all-like-this :exit t)
  ("n" mc/mark-next-like-this)
  ("N" mc/skip-to-next-like-this)
  ("M-n" mc/unmark-next-like-this)
  ("p" mc/mark-previous-like-this)
  ("P" mc/skip-to-previous-like-this)
  ("M-p" mc/unmark-previous-like-this)
  ("r" mc/mark-all-in-region-regexp :exit t)
  ("q" nil)

  ("<mouse-1>" mc/add-cursor-on-click)
  ("<down-mouse-1>" ignore)
  ("<drag-mouse-1>" ignore))
;; Hydra:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Git][Git:1]]
(use-package magit
  :ensure t
  :init
  (progn
  (bind-key "C-x g" 'magit-status)
  ))

  (use-package git-gutter
  :ensure t
  :init
  (global-git-gutter-mode +1))

  (global-set-key (kbd "M-g M-g") 'hydra-git-gutter/body)


  (use-package git-timemachine
  :ensure t
  )
(defhydra hydra-git-gutter (:body-pre (git-gutter-mode 1)
                            :hint nil)
  "
Git gutter:
  _j_: next hunk        _s_tage hunk     _q_uit
  _k_: previous hunk    _r_evert hunk    _Q_uit and deactivate git-gutter
  ^ ^                   _p_opup hunk
  _h_: first hunk
  _l_: last hunk        set start _R_evision
"
  ("j" git-gutter:next-hunk)
  ("k" git-gutter:previous-hunk)
  ("h" (progn (goto-char (point-min))
              (git-gutter:next-hunk 1)))
  ("l" (progn (goto-char (point-min))
              (git-gutter:previous-hunk 1)))
  ("s" git-gutter:stage-hunk)
  ("r" git-gutter:revert-hunk)
  ("p" git-gutter:popup-hunk)
  ("R" git-gutter:set-start-revision)
  ("q" nil :color blue)
  ("Q" (progn (git-gutter-mode -1)
              ;; git-gutter-fringe doesn't seem to
              ;; clear the markup right away
              (sit-for 0.1)
              (git-gutter:clear))
       :color blue))
;; Git:1 ends here

;; [[file:~/.emacs.d/myinit.org::*IBUFFER][IBUFFER:1]]
(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("dired" (mode . dired-mode))
               ("org" (name . "^.*org$"))
               ("magit" (mode . magit-mode))
               ("IRC" (or (mode . circe-channel-mode) (mode . circe-server-mode)))
               ("web" (or (mode . web-mode) (mode . js2-mode)))
               ("shell" (or (mode . eshell-mode) (mode . shell-mode)))
               ("mu4e" (or

                        (mode . mu4e-compose-mode)
                        (name . "\*mu4e\*")
                        ))
               ("programming" (or
                               (mode . python-mode)
                               (mode . c++-mode)
                               (mode . rust-mode)))
               ("emacs" (or
                         (name . "^\\*scratch\\*$")
                         (name . "^\\*Messages\\*$")))
               ))))
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-auto-mode 1)
            (ibuffer-switch-to-saved-filter-groups "default")))

;; don't show these
                                        ;(add-to-list 'ibuffer-never-show-predicates "zowie")
;; Don't show filter groups if there are no buffers in that group
(setq ibuffer-show-empty-filter-groups nil)

;; Don't ask for confirmation to delete marked buffers
(setq ibuffer-expert t)
;; IBUFFER:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Iedit%20and%20narrow%20/%20widen%20dwim][Iedit and narrow / widen dwim:1]]
; mark and edit all copies of the marked region simultaniously. 
(use-package iedit
:ensure t)

; if you're windened, narrow to the region, if you're narrowed, widen
; bound to C-x n
(defun narrow-or-widen-dwim (p)
"If the buffer is narrowed, it widens. Otherwise, it narrows intelligently.
Intelligently means: region, org-src-block, org-subtree, or defun,
whichever applies first.
Narrowing to org-src-block actually calls `org-edit-src-code'.

With prefix P, don't widen, just narrow even if buffer is already
narrowed."
(interactive "P")
(declare (interactive-only))
(cond ((and (buffer-narrowed-p) (not p)) (widen))
((region-active-p)
(narrow-to-region (region-beginning) (region-end)))
((derived-mode-p 'org-mode)
;; `org-edit-src-code' is not a real narrowing command.
;; Remove this first conditional if you don't want it.
(cond ((ignore-errors (org-edit-src-code))
(delete-other-windows))
((org-at-block-p)
(org-narrow-to-block))
(t (org-narrow-to-subtree))))
(t (narrow-to-defun))))

;; (define-key endless/toggle-map "n" #'narrow-or-widen-dwim)
;; This line actually replaces Emacs' entire narrowing keymap, that's
;; how much I like this command. Only copy it if that's what you want.
(define-key ctl-x-map "n" #'narrow-or-widen-dwim)
;; Iedit and narrow / widen dwim:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Interface%20Tweaks][Interface Tweaks:1]]
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "<f5>") 'revert-buffer)
;; Interface Tweaks:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Javascript][Javascript:1]]
(use-package js2-mode
:ensure t
:ensure ac-js2
:init
(progn
(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)
))

(use-package js2-refactor
:ensure t
:config 
(progn
(js2r-add-keybindings-with-prefix "C-c C-m")
;; eg. extract function with `C-c C-m ef`.
(add-hook 'js2-mode-hook #'js2-refactor-mode)))
(use-package tern
:ensure tern
:ensure tern-auto-complete
:config
(progn
(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;;(tern-ac-setup)
))

;;(use-package jade
;;:ensure t
;;)

;; use web-mode for .jsx files
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))


;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; customize flycheck temp file prefix
(setq-default flycheck-temp-prefix ".flycheck")

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(json-jsonlist)))

;; adjust indents for web-mode to 2 spaces
(defun my-web-mode-hook ()
  "Hooks for Web mode. Adjust indents"
  ;;; http://web-mode.org/
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))
(add-hook 'web-mode-hook  'my-web-mode-hook)
;; Javascript:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Keybindings][Keybindings:1]]
(use-package key-chord
:ensure t
:config
(key-chord-mode 1))
(global-set-key (kbd "C-c k") 'kill-sentence)
(global-set-key (kbd "C-c d") 'downcase-word)
(key-chord-define-global "kk" 'forward-word)
(key-chord-define-global "jj" 'backward-word)
(key-chord-define-global "ññ" 'kill-whole-line)
;; duplicate line
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)
(key-chord-define-global "yp" 'duplicate-line)
;; copy line
(defun copy-line (arg)
      "Copy lines (as many as prefix argument) in the kill ring"
      (interactive "p")
      (kill-ring-save (line-beginning-position)
                      (line-beginning-position (+ 1 arg)))
      (message "%d line%s copied" arg (if (= 1 arg) "" "s")))
(key-chord-define-global "yy" 'copy-line)
;; copy word
(defun get-point (symbol &optional arg)
      "get the point"
      (funcall symbol arg)
      (point)
)
(defun copy-thing (begin-of-thing end-of-thing &optional arg)
  "copy thing between beg & end into kill ring"
   (save-excursion
     (let ((beg (get-point begin-of-thing 1))
           (end (get-point end-of-thing arg)))
      (copy-region-as-kill beg end)))
)
(defun copy-word (&optional arg)
      "Copy words at point into kill-ring"
       (interactive "P")
       (copy-thing 'backward-word 'forward-word arg)
       ;;(paste-to-mark arg)
)
(key-chord-define-global "ww" 'copy-word)
(key-chord-define-global "xx" 'save-buffer)
(key-chord-define-global "qq" 'delete-other-windows)
(key-chord-define-global "vv" 'save-buffers-kill-terminal)
;; Keybindings:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Misc%20Packages][Misc Packages:1]]
; Highlights the current cursor line
(global-hl-line-mode t)

; flashes the cursor's line when you scroll
(use-package beacon
:ensure t
:config
(beacon-mode 1)
; (setq beacon-color "#666600")
)

; deletes all the whitespace when you hit backspace or delete
(use-package hungry-delete
:ensure t
:config
(global-hungry-delete-mode))


(use-package multiple-cursors
:ensure t)

; expand the marked region in semantic increments (negative prefix to reduce region)
(use-package expand-region
:ensure t
:config 
(global-set-key (kbd "C-=") 'er/expand-region))

(setq save-interprogram-paste-before-kill t)


(global-auto-revert-mode 1) ;; you might not want this
(setq auto-revert-verbose nil) ;; or this
(global-set-key (kbd "<f6>") 'revert-buffer)

;; highlights parentheses
(use-package highlight-parentheses
:ensure t
:config
(highlight-parentheses-mode 1)
)
;; autocomplete parentheses
(electric-pair-mode 1) 
;; mark parentheses
(show-paren-mode t)
;; Show column number
(setq column-number-mode 1) 
;; Not user GUI dialogs, only minibuffer
(setq use-dialog-box nil)
;; Do not use tabs
(setq-default indent-tabs-mode nil)
;; Replace TAB with 4 spaces
(setq-default tab-width 4) 
;; Set aggressive idennt mode
(use-package aggressive-indent
:ensure t
:config
(add-to-list 'aggressive-indent-excluded-modes 'html-mode))
;; Enable cua-mode ctrl-z, ctrl-v ...
(cua-mode 1)
;; Disable backup/autosave files
(setq backup-inhibited t)
(setq make-backup-files        nil)
(setq auto-save-default        nil)
(setq auto-save-list-file-name nil)
(setq auto-save-default nil)                  
(setq scroll-preserve-screen-position 10)
;; Replace "lambda" to λ, function to
(global-prettify-symbols-mode 1)
;; Display the name of the current buffer in the title bar
(setq frame-title-format "%b")
;; Coding-system settings
(set-language-environment 'UTF-8)
(setq buffer-file-coding-system 'utf-8)
(setq-default coding-system-for-read    'utf-8)
(setq file-name-coding-system           'utf-8)
(set-selection-coding-system            'utf-8)
(set-keyboard-coding-system        'utf-8-unix)
(set-terminal-coding-system             'utf-8)
(prefer-coding-system 'utf-8)
;; Linum plugin
;;(line-number-mode   t) ;; Show line number in mode-line
;;(global-linum-mode t) ;; Show line numbers in all buffers
;; font-lock annotations like TODO in source code
(use-package hl-todo
    :ensure t)
(global-hl-todo-mode 1)
(which-function-mode 1)
;; Fringe settings
(fringe-mode '(8 . 0)) ;; Text delimiter left only
(setq-default indicate-buffer-boundaries 'left) ;; Indication only on the left
(setq visible-bell t) ;; show bell when top or bottom
(scroll-bar-mode -1) ;; Disable scrollbar
;; Fringe settings
(fringe-mode '(8 . 0)) ;; Text delimiter left only
(setq-default indicate-buffer-boundaries 'left) ;; Indication only on the left
;; Display file size/time in mode-line
(setq display-time-24hr-format t) ;; 24-hour time format in mode-lin
(display-time-mode             t) ;; Show hours in mode-line
(size-indication-mode t) ;; File size in% -s
;; Paren face
(set-face-background 'show-paren-match (face-background 'default))
(set-face-foreground 'show-paren-match "#def")
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)
(use-package rainbow-delimiters
:ensure t
:config
(setq rainbow-delimiters-max-face-count 9))
(set-face-attribute 'default nil :height 105)

(when (member "DejaVu Sans Mono" (font-family-list))
(set-face-attribute 'default nil :font "DejaVu Sans Mono"))
;; Misc Packages:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Org%20mode][Org mode:1]]
(use-package org 
  :ensure t
  :pin org)

    (setenv "BROWSER" "chromium-browser")

        (use-package org-bullets
        :ensure t
        :config
        (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

            (custom-set-variables
             '(org-directory "~/Sync/orgfiles")
             '(org-default-notes-file (concat org-directory "/notes.org"))
             '(org-export-html-postamble nil)
             '(org-hide-leading-stars t)
             '(org-startup-folded (quote overview))
             '(org-startup-indented t)
             )

            (setq org-file-apps
  		(append '(
          		  ("\\.pdf\\'" . "evince %s")
 ("\\.x?html?\\'" . "/usr/bin/chromium-browser %s")
          		  ) org-file-apps ))

            (global-set-key "\C-ca" 'org-agenda)
            (setq org-agenda-start-on-weekday nil)
            (setq org-agenda-custom-commands
            '(("c" "Simple agenda view"
            ((agenda "")
            (alltodo "")))))

            (global-set-key (kbd "C-c c") 'org-capture)

            (setq org-agenda-files (list "~/Sync/orgfiles/gcal.org"
            "~/Sync/orgfiles/soe-cal.org"
          			       "~/Sync/orgfiles/i.org"
          			       "~/Sync/orgfiles/schedule.org"))
            (setq org-capture-templates
          			  '(("a" "Appointment" entry (file  "~/Sync/orgfiles/gcal.org" )
          				   "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
          				  ("l" "Link" entry (file+headline "~/Sync/orgfiles/links.org" "Links")
          				   "* %? %^L %^g \n%T" :prepend t)
          				  ("b" "Blog idea" entry (file+headline "~/Sync/orgfiles/i.org" "Blog Topics:")
          				   "* %?\n%T" :prepend t)
          				  ("t" "To Do Item" entry (file+headline "~/Sync/orgfiles/i.org" "To Do and Notes")
          				   "* TODO %?\n%u" :prepend t)
  					  ("m" "Mail To Do" entry (file+headline "~/Sync/orgfiles/i.org" "To Do and Notes")
  					   "* TODO %a\n %?" :prepend t)
  					  ("g" "GMail To Do" entry (file+headline "~/Sync/orgfiles/i.org" "To Do and Notes")
  					   "* TODO %^L\n %?" :prepend t)
  					  ("n" "Note" entry (file+headline "~/Sync/orgfiles/i.org" "Notes")
          				   "* %u %? " :prepend t)
  					  ))
            ;; (setq org-capture-templates
        ;; 		    '(("a" "Appointment" entry (file  "~/Sync/orgfiles/gcal.org" )
        ;; 			     "* TODO %?\n:PROPERTIES:\nDEADLINE: %^T \n\n:END:\n %i\n")
        ;; 			    ("l" "Link" entry (file+headline "~/Sync/orgfiles/links.org" "Links")
        ;; 			     "* %? %^L %^g \n%T" :prepend t)
        ;; 			    ("b" "Blog idea" entry (file+headline "~/Sync/orgfiles/i.org" "POSTS:")
        ;; 			     "* %?\n%T" :prepend t)
        ;; 			    ("t" "To Do Item" entry (file+headline "~/Sync/orgfiles/i.org" "To Do")
        ;; 			     "* TODO %?\n%u" :prepend t)
        ;; 			    ("n" "Note" entry (file+headline "~/Sync/orgfiles/i.org" "Note space")
        ;; 			     "* %?\n%u" :prepend t)

        ;; 			    ("j" "Journal" entry (file+datetree "~/Dropbox/journal.org")
        ;; 			     "* %?\nEntered on %U\n  %i\n  %a")
            ;;                                ("s" "Screencast" entry (file "~/Sync/orgfiles/screencastnotes.org")
            ;;                                "* %?\n%i\n")))


        (defadvice org-capture-finalize 
            (after delete-capture-frame activate)  
        "Advise capture-finalize to close the frame"  
        (if (equal "capture" (frame-parameter nil 'name))  
        (delete-frame)))

        (defadvice org-capture-destroy 
            (after delete-capture-frame activate)  
        "Advise capture-destroy to close the frame"  
        (if (equal "capture" (frame-parameter nil 'name))  
        (delete-frame)))  

        (use-package noflet
        :ensure t )
        (defun make-capture-frame ()
        "Create a new frame and run org-capture."
        (interactive)
        (make-frame '((name . "capture")))
        (select-frame-by-name "capture")
        (delete-other-windows)
        (noflet ((switch-to-buffer-other-window (buf) (switch-to-buffer buf)))
            (org-capture)))

; (require 'ox-beamer)
; for inserting inactive dates
(define-key org-mode-map (kbd "C-c >") (lambda () (interactive (org-time-stamp-inactive))))

(use-package htmlize :ensure t)

(setq org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar")
;; Org mode:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Origami%20Folding][Origami Folding:1]]
(use-package origami
:ensure t)
;; Origami Folding:1 ends here

;; [[file:~/.emacs.d/myinit.org::*PDF%20tools][PDF tools:1]]
(use-package pdf-tools
:ensure t)
(use-package org-pdfview
:ensure t)

(require 'pdf-tools)
(require 'org-pdfview)
;; PDF tools:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Projectile][Projectile:1]]
(use-package projectile
      :ensure t
      :bind ("C-c p" . projectile-command-map)
      :config
      (projectile-global-mode)
      (setq projectile-completion-system 'ivy)
      (setq projectile-globally-ignored-directories
      (cl-union projectile-globally-ignored-directories
      '(".git"
      "node_modules"
      "venv")))
      (setq projectile-globally-ignored-files
          (cl-union projectile-globally-ignored-files
              '(".DS_Store"
              "*.gz"
              "*.pyc"
              "*.png"
              "*.jpg"
              "*.jar"
              "*.svg"
              "*.tgz"
              "*.zip")))
)
;; Projectile:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Python][Python:1]]
(use-package anaconda-mode
    :ensure t)
(use-package company-anaconda
    :ensure t)
(use-package pyenv-mode
    :ensure t)
(add-hook 'python-mode-hook 'pyenv-mode)
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-eldoc-mode)
(eval-after-load "company"
 '(add-to-list 'company-backends '(company-anaconda :with company-capf)))

(defun python--encoding-comment-required-p ()
  (re-search-forward "[^\0-\177]" nil t))

(defun python--detect-encoding ()
  (let ((coding-system
         (or save-buffer-coding-system
             buffer-file-coding-system)))
    (if coding-system
        (symbol-name
         (or (coding-system-get coding-system 'mime-charset)
             (coding-system-change-eol-conversion coding-system nil)))
      "ascii-8bit")))
(use-package yapfify
    :ensure t)
(add-hook 'python-mode-hook 'yapf-mode)
;; Python:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Rust][Rust:1]]
(use-package rust-mode
  :ensure t)
(use-package flymake-rust
  :ensure t)
(use-package flycheck-rust
  :ensure t)
(use-package racer
  :ensure t)
(use-package cargo
  :ensure t)
(add-to-list 'load-path "/path/to/rust-mode/")
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
(with-eval-after-load 'rust-mode
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
  (add-hook 'rust-mode-hook 'cargo-minor-mode)
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'racer-mode-hook #'company-mode))
(setq racer-cmd "~/.cargo/bin/racer") ;; Rustup binaries PATH
;; Rust:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Searching][Searching:1]]
(use-package ag
    :ensure t)
(setq ag-highlight-search t)
;; anzu configuration
(use-package anzu
    :ensure t)
(global-anzu-mode +1)
(global-set-key [remap query-replace] 'anzu-query-replace)
(global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
(set-face-attribute 'anzu-mode-line nil
                    :foreground "yellow" :weight 'bold)
(custom-set-variables
 '(anzu-mode-lighter "")
 '(anzu-deactivate-region t)
 '(anzu-search-threshold 1000)
 '(anzu-replace-threshold 50)
 '(anzu-replace-to-string-separator " => "))
;; Searching:1 ends here

;; [[file:~/.emacs.d/myinit.org::*SmartParens][SmartParens:1]]
(use-package smartparens
    :ensure t
    :config
    (use-package smartparens-config)
    (use-package smartparens-html)
    (use-package smartparens-python)
    (use-package smartparens-latex)
    (smartparens-global-mode t)
    (show-smartparens-global-mode t)
    :bind
    ( ("C-<down>" . sp-down-sexp)
    ("C-<up>"   . sp-up-sexp)
    ("M-<down>" . sp-backward-down-sexp)
    ("M-<up>"   . sp-backward-up-sexp)
    ("C-M-a" . sp-beginning-of-sexp)
    ("C-M-e" . sp-end-of-sexp)



     ("C-M-f" . sp-forward-sexp)
     ("C-M-b" . sp-backward-sexp)

     ("C-M-n" . sp-next-sexp)
     ("C-M-p" . sp-previous-sexp)

     ("C-S-f" . sp-forward-symbol)
     ("C-S-b" . sp-backward-symbol)

     ("C-<right>" . sp-forward-slurp-sexp)
     ("M-<right>" . sp-forward-barf-sexp)
     ("C-<left>"  . sp-backward-slurp-sexp)
     ("M-<left>"  . sp-backward-barf-sexp)

     ("C-M-t" . sp-transpose-sexp)
     ("C-M-k" . sp-kill-sexp)
     ("C-k"   . sp-kill-hybrid-sexp)
     ("M-k"   . sp-backward-kill-sexp)
     ("C-M-w" . sp-copy-sexp)

     ("C-M-d" . delete-sexp)

     ("M-<backspace>" . backward-kill-word)
     ("C-<backspace>" . sp-backward-kill-word)
     ([remap sp-backward-kill-word] . backward-kill-word)

     ("M-[" . sp-backward-unwrap-sexp)
     ("M-]" . sp-unwrap-sexp)

     ("C-x C-t" . sp-transpose-hybrid-sexp)

     ("C-c ("  . wrap-with-parens)
     ("C-c ["  . wrap-with-brackets)
     ("C-c {"  . wrap-with-braces)
     ("C-c '"  . wrap-with-single-quotes)
     ("C-c \"" . wrap-with-double-quotes)
     ("C-c _"  . wrap-with-underscores)
    ("C-c `"  . wrap-with-back-quotes)
    ))
;; SmartParens:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Swiper%20/%20Ivy%20/%20Counsel][Swiper / Ivy / Counsel:1]]
(use-package counsel
:ensure t
:bind
(("M-y" . counsel-yank-pop)
 :map ivy-minibuffer-map
 ("M-y" . ivy-next-line)))




(use-package ivy
:ensure t
:diminish (ivy-mode)
:bind (("C-x b" . ivy-switch-buffer))
:config
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "%d/%d ")
(setq ivy-display-style 'fancy))


(use-package swiper
:ensure t
:bind (("C-s" . swiper)
       ("C-r" . swiper)
       ("C-c C-r" . ivy-resume)
       ("M-x" . counsel-M-x)
       ("C-x C-f" . counsel-find-file))
:config
(progn
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-display-style 'fancy)
  (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
  ))
;; Swiper / Ivy / Counsel:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Themes%20and%20modeline][Themes and modeline:1]]
;;
(use-package lab-themes 
:ensure t
:config
(lab-themes-load-style 'dark)
)
;; Powerline
(use-package powerline
:ensure t
:config
(powerline-default-theme)
)
;; Themes and modeline:1 ends here

;; [[file:~/.emacs.d/myinit.org::*TOML][TOML:1]]
(use-package toml-mode
  :ensure t)
;; TOML:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Treemacs][Treemacs:1]]
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn

    (setq treemacs-follow-after-init          t
          treemacs-width                      35
          treemacs-indentation                2
          treemacs-git-integration            t
          treemacs-collapse-dirs              3
          treemacs-silent-refresh             nil
          treemacs-change-root-without-asking nil
          treemacs-sorting                    'alphabetic-desc
          treemacs-show-hidden-files          t
          treemacs-never-persist              nil
          treemacs-is-never-other-window      nil
          treemacs-goto-tag-strategy          'refetch-index)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t))
  :bind
  (:map global-map
        ([f8]        . treemacs)
        ([f9]        . treemacs-projectile)
        ("M-0"       . treemacs-select-window)
        ("C-c 1"     . treemacs-delete-other-windows)
      ))
  (use-package treemacs-projectile
    :defer t
    :after treemacs projectile
    (setq treemacs-header-function #'treemacs-projectile-create-header)
    :ensure t)
;; Treemacs:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Try][Try:1]]
(use-package try
	:ensure t)
;; Try:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Web%20Mode][Web Mode:1]]
(use-package web-mode
:ensure t
:config
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("/some/react/path/.*\\.js[x]?\\'" . web-mode))
(setq web-mode-engines-alist
'(("django"    . "\\.html\\'")))
(setq web-mode-ac-sources-alist
'(("css" . (ac-source-css-property))
("vue" . (ac-source-words-in-buffer ac-source-abbrev))
("html" . (ac-source-words-in-buffer ac-source-abbrev))))
(add-hook 'web-mode-hook (lambda ()
                           (setq web-mode-markup-indent-offset 2)
                           (setq web-mode-css-indent-offset 2)
                           (setq web-mode-code-indent-offset 2)
                           (setq web-mode-indent-style 2)
                           (setq web-mode-enable-auto-pairing t)
                           (setq web-mode-enable-css-colorization t)
                           (setq web-mode-enable-current-element-highlight t)
                           (setq web-mode-enable-current-column-highlight t)
                           (setq web-mode-enable-auto-closing t)
                           (setq web-mode-enable-auto-quoting t)
                           (setq web-mode-enable-comment-keywords t)
                           (setq web-mode-enable-css-colorization t)
                           (setq web-mode-enable-block-face t)
)))
;; Web Mode:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Which%20Key][Which Key:1]]
(use-package which-key
      :ensure t 
      :config
      (which-key-mode))
;; Which Key:1 ends here

;; [[file:~/.emacs.d/myinit.org::*YAML][YAML:1]]
(use-package yaml-mode
  :ensure t
  :mode ("\\.yml\\'"
         "\\.yaml\\'"))
;; YAML:1 ends here

;; [[file:~/.emacs.d/myinit.org::*Yasnippet][Yasnippet:1]]
(use-package yasnippet
  :ensure t
  :init
    (yas-global-mode 1))
(setq yas-snippet-dirs
  '("~/.emacs.d/snippets"))
(yas-global-mode 1) ;; or M-x yas-reload-all if you've started YASnippet already.
;; Yasnippet:1 ends here
