(add-to-list 'auto-mode-alist '("\\.razor\\'" . csharp-mode))

(add-hook 'emacs-startup-hook
          (lambda()
            (setq inhibit-startup-message t
                  inhibit-startup-message t)))

(setq initial-buffer-choice t)

(setq display-time-format "  %b %e %l:%M %p  "
      display-time-default-load-average nil)
(display-time)

(load-theme 'catppuccin :no-confirm)
(setq catppuccin-flavor 'frappe)
(catppuccin-reload)

(add-to-list 'default-frame-alist `(font . "Iosevka-20"))

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode +1)
(setq-default indent-tabs-mode nil)
(scroll-bar-mode -1)
(menu-bar-mode   -1)
(tool-bar-mode   -1)

(defun pop-next ()
  (forward-line 1)
  (let ((nl (thing-at-point 'line)))
    (kill-whole-line)
    (forward-line -1)
    (string-trim nl)))

(defun join-next ()
  (let ((nl (pop-next)))
    (move-end-of-line nil)
    (insert " " nl)))

(defun dotf ()
  (interactive) 
  (join-next))

(keymap-global-set "C-." 'dotf)

(keymap-global-set "M-p" "C-y")

(add-hook 'prog-mode-hook 'rainbow-identifiers-mode)

(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(require 'org-super-agenda)

(add-hook 'org-super-agenda-mode-hook
          'org-super-agenda-mode)

(setq org-super-agenda-groups
    '((:order-multi (1 (:name "Appointments"
                              :time-grid t
                              :todo "VISIT")
                       (:name "Upcoming Appointments"
                              :time-grid t
                              :todo "APPOINTMENT")))
      (:name "Important"
             :tag "important"
             :priority "A")
      (:name "Personal"
             :tag "personal"
             :priority "B")
      (:name "Chores"
             :tag "chore"
             :priority "C")))

(require 'multiple-cursors)
(global-set-key (kbd "C-:") 'mc/skip-to-previous-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-\"") 'mc/skip-to-next-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(require 'whitespace)

(setq whitespace-style '(face spaces space-mark))

(add-hook 'prog-mode-hook 'whitespace-mode)

(require 'org-recur)

(add-hook 'org-agenda-mode-hook #'org-recur-agenda-mode)
(add-hook 'org-mode-hook #'org-recur-mode)

(define-key org-recur-agenda-mode-map (kbd "C-c d") 'org-recur-finish)
(define-key org-recur-agenda-mode-map (kbd "d") 'org-recur-finish)
(define-key org-recur-mode-map (kbd "C-c d") 'org-recur-finish)

(setq org-recur-finish-done t
      org-recur-finish-archive t)

(defun org-agenda-refresh ()
  "Refresh all `org-agenda' buffers."
  (dolist (buffer (buffer-list))
    (with-current-buffer buffer
      (when (derived-mode-p 'org-agenda-mode)
        (org-agenda-maybe-redo)))))

(defadvice org-schedule (after refresh-agenda activate)
  "Refresh org-agenda."
  (org-agenda-refresh))

(ligature-set-ligatures 'prog-mode '("--" "---" "==" "===" "!=" "!==" "=!="
                                   "=:=" "=/=" "<=" ">=" "&&" "&&&" "&=" "++" "+++" "***" ";;" "!!"
                                   "??" "???" "?:" "?." "?=" "<:" ":<" ":>" ">:" "<:<" "<>" "<<<" ">>>"
                                   "<<" ">>" "||" "-|" "_|_" "|-" "||-" "|=" "||=" "##" "###" "####"
                                   "#{" "#[" "]#" "#(" "#?" "#_" "#_(" "#:" "#!" "#=" "^=" "<$>" "<$"
                                   "$>" "<+>" "<+" "+>" "<*>" "<*" "*>" "</" "</>" "/>" "<!--" "<#--"
                                   "-->" "->" "->>" "<<-" "<-" "<=<" "=<<" "<<=" "<==" "<=>" "<==>"
                                   "==>" "=>" "=>>" ">=>" ">>=" ">>-" ">-" "-<" "-<<" ">->" "<-<" "<-|"
                                   "<=|" "|=>" "|->" "<->" "<~~" "<~" "<~>" "~~" "~~>" "~>" "~-" "-~"
                                   "~@" "[||]" "|]" "[|" "|}" "{|" "[<" ">]" "|>" "<|" "||>" "<||"
                                   "|||>" "<|||" "<|>" "..." ".." ".=" "..<" ".?" "::" ":::" ":=" "::="
                                   ":?" ":?>" "//" "///" "/*" "*/" "/=" "//=" "/==" "@_" "__" "???"
                                   "<:<" ";;;"))
(global-ligature-mode t)

(setq org-roam-directory "~/org/roaming")
(org-roam-db-autosync-mode)

(define-key org-mode-map (kbd "C-c n c") 'org-roam-node-capture)
(define-key org-mode-map (kbd "C-c n i") 'org-roam-node-insert)
(define-key org-mode-map (kbd "C-c n f") 'org-roam-node-find)

(setq compilation-scroll-output t)

(require 'haskell-interactive-mode)
(require 'haskell-process)

(define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
(define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
(define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
(define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
(define-key haskell-mode-map (kbd "C-c i") 'haskell-navigate-imports)
(define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
(define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)

(add-hook 'haskell-mode-hook
          'interactive-haskell-mode)

(with-eval-after-load 'tramp
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path))

(require 'inheritenv)
(envrc-global-mode)

(setq envrc-show-summary-in-minibuffer nil)

(require 'smex)
(smex-initialize)

(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "M-x") 'smex)

(require 'rust-mode)

(defun realbox ()
  "prettify checkboxes to real boxes"
  (push '("[ ]" . "☐") prettify-symbols-alist)
  (push '("[X]" . "☑") prettify-symbols-alist)
  (push '("[-]" . "❍") prettify-symbols-alist)
  (prettify-symbols-mode))
          
(defun uncheck ()
  "uncheck checkboxes if parent is DONE"
  (when (string= org-state "DONE")
    (org-map-entries
     (lambda ()
       (org-reset-checkbox-state-subtree))
     nil 'tree)))

(defun todoful ()
  "set DONE if statistics are set"
  (let (org-log-done org-todo-log-states)
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))
    (when (= n-not-done 0)
      (org-map-entries
       (lambda ()
         (org-todo "TODO"))
       nil 'tree))))

(add-hook 'org-after-todo-state-change-hook 'uncheck)
(add-hook 'org-after-todo-statistics-hook   'todoful)
(add-hook 'org-mode-hook                    'realbox)

(setq org-enforce-todo-checkbox-dependencies t)
(setq org-checkbox-hierarchical-statistics t)
(setq org-read-date-prefer-future 'time)
(setq org-startup-with-inline-images t)
(setq org-enforce-todo-dependencies t)
(setq org-return-follows-link t)
(setq org-startup-folded 'fold)
(setq org-startup-indented t)
(setq org-log-done 'time)

(setq org-todo-keywords
      '((sequence "CHECK"               "|" "DONE")
        (sequence "CALL"                "|" "DONE")
        (sequence "FEED"                "|" "DONE")
        (sequence "TODO"                "|" "DONE")
        (sequence "TASK" "IN-PROGRESS"  "|" "DONE")
        (sequence "BUY"                 "|" "DONE")
        (sequence "TAKE"                "|" "TAKEN" "SKIPPED" "MISSED")
        (sequence "PLAN"                "|" "DONE" "CANCELLED")
        (sequence "APPOINTMENT" "VISIT" "|" "DONE" "CANCELLED")))

(setq org-todo-keyword-faces
      '(("APPOINTMENT" .
         (:foreground "cyan"
                      :weight bold
                      :underline nil))
        ("CANCELLED" .
         (:foreground "maroon"
                      :weight bold
                      :underline t))
        ("IN-PROGRESS" .
         (:foreground "coral"
                      :weight bold
                      :underline nil))
        ("TAKE" .
         (:foreground "light sea green"
                      :weight bold
                      :underline nil))
        ("VISIT" .
         (:foreground "deep sky blue"
                      :weight bold
                      :underline nil))
        ("PLAN" .
         (:foreground "burlywood"
                      :weight bold
                      :underline nil))
        ("TASK" .
         (:foreground "chartreuse"
                      :weight bold
                      :underline nil))
        ("CALL" .
         (:foreground "misty rose"
                      :weight bold
                      :underline nil))
        ("DONE" .
         (:foreground "spring green"
                      :weight bold
                      :underline nil))
        ("BUY" .
         (:foreground "spring green"
                      :weight bold
                      :underline nil))
        ("FEED" .
         (:foreground "gold"
                      :weight bold
                      :underline nil))
        ("CHECK" .
         (:foreground "gold"
                      :weight bold
                      :underline nil))))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((ledger . t)))

(require 'ido)

(ido-everywhere 1)
(ido-mode 1)

(require 'org-caldav)

(setq org-caldav-url "https://p165-caldav.icloud.com/19455960162/calendars")
(setq org-caldav-username "indigopaige@icloud.com")

(setq org-caldav-calendar-id "E54651FE-6681-486D-9B30-3285C2D9C135")

(setq org-caldav-inbox "~/org/inbox.org")
(setq org-caldav-files '("~/org/calendar.org"))
(setq org-caldav-save-directory "~/org/.caldav-saves")
(setq org-caldav-sync-direction 'twoway)
