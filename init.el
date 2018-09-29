(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)


(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages
  '(
    async
    better-defaults
    ;; Clojure & friends
    clojure-mode
    cider
    ;; Lisps
    rainbow-delimiters
    paxedit
    ;; Completion popup
    ;;company
    ;;popup
    ;; Project navigation
    projectile
    ;; Purescript
    purescript-mode
    psc-ide
    ;; Haskell
    haskell-mode
    ;; Arduino
    arduino-mode
    ;; Idris
    idris-mode
    ;; Misc.
    helm
    idle-highlight-mode
    ido
    smex
    ido-completing-read+
    json-mode
    yalinum
    sass-mode
    markdown-mode
    color-theme-sanityinc-tomorrow
    powerline
    yasnippet
    buffer-move
    color-identifiers-mode
    highlight
    git-link
    expand-region
    avy
    whitespace
    yaml-mode)
  "A list of packages to ensure are installed at launch.")

;; Automaticaly install any missing packages
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(async-bytecomp-package-mode 1)

;; Load key bindings.
(load (concat user-emacs-directory "keybinds.el"))

(require 'better-defaults)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 120 :weight bold))))
 '(font-lock-warning-face ((((class color) (min-colors 89)) (:weight bold :foreground "#cc0000"))))
 '(idle-highlight ((t (:inherit region :background "maroon4"))))
 '(linum-face ((t (:background "gray20" :foreground "#e2c648")))))
;; face was height 116

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#cccccc" "#f2777a" "#99cc99" "#ffcc66" "#6699cc" "#cc99cc" "#66cccc" "#2d2d2d"))
 '(auto-save-default nil)
 '(backup-inhibited t t)
 '(blink-matching-paren nil)
 '(cider-buffer-name-show-port t)
 '(cljr-favor-prefix-notation nil)
 '(cljr-favor-private-functions nil)
 '(custom-enabled-themes (quote (sanityinc-tomorrow-bright)))
 '(custom-safe-themes
   (quote
    ("1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" default)))
 '(delete-selection-mode t)
 '(fci-rule-color "#393939")
 '(git-link-open-in-browser t)
 '(haskell-process-args-cabal-repl (quote ("--ghc-option=-ferror-spans")))
 '(inhibit-startup-screen t)
 '(magit-emacsclient-executable "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient")
 '(nrepl-host "localhost")
 '(package-selected-packages
   (quote
    (sass-mode rainbow-delimiters purescript-mode projectile powerline paxedit markdown-mode json-mode idris-mode haskell-mode git-link expand-region color-theme-sanityinc-tomorrow color-identifiers-mode clojure-snippets clj-refactor cider-eval-sexp-fu buffer-move avy arduino-mode align-cljlet)))
 '(projectile-use-git-grep t)
 '(show-paren-delay 0)
 '(show-paren-mode t)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#f2777a")
     (40 . "#f99157")
     (60 . "#ffcc66")
     (80 . "#99cc99")
     (100 . "#66cccc")
     (120 . "#6699cc")
     (140 . "#cc99cc")
     (160 . "#f2777a")
     (180 . "#f99157")
     (200 . "#ffcc66")
     (220 . "#99cc99")
     (240 . "#66cccc")
     (260 . "#6699cc")
     (280 . "#cc99cc")
     (300 . "#f2777a")
     (320 . "#f99157")
     (340 . "#ffcc66")
     (360 . "#99cc99"))))
 '(vc-annotate-very-old-color nil))

(split-window-right)

(setq ring-bell-function 'ignore)

(blink-cursor-mode 0)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(require 'helm-config)
;;;;;;;;;;;;;;;

(require 'ido)
(ido-mode 1)
(ido-everywhere 1)
(require 'ido-completing-read+)
(ido-ubiquitous-mode 1)

(require 'smex) ; Not needed if you use package.el
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; ;; This is your old M-x.
;; (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; (require 'ido-vertical-mode)
;; (ido-vertical-mode 1)
;;(setq ido-vertical-define-keys 'C-n-and-C-p-only)


(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(require 'powerline)
(powerline-center-theme)

;; Ido-mode customizations
(setq ido-decorations
      (quote
       ("\n-> "           ; Opening bracket around prospect list
        ""                ; Closing bracket around prospect list
        "\n   "           ; separator between prospects
        "\n   ..."        ; appears at end of truncated list of prospects
        "["               ; opening bracket around common match string
        "]"               ; closing bracket around common match string
        " [No match]"     ; displayed when there is no match
        " [Matched]"      ; displayed if there is a single match
        " [Not readable]" ; current diretory is not readable
        " [Too big]"      ; directory too big
        " [Confirm]")))   ; confirm creation of new file or buffer

(add-hook 'ido-setup-hook
          (lambda ()
            (define-key ido-completion-map [down] 'ido-next-match)
            (define-key ido-completion-map [up] 'ido-prev-match)
            (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
            (define-key ido-completion-map (kbd "C-p") 'ido-prev-match)))

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(remove-hook 'text-mode-hook #'turn-on-auto-fill)
(add-hook 'text-mode-hook 'visual-line-mode)
(auto-fill-mode -1)

;; (require 'yalinum)
(global-linum-mode t)
(setq linum-format "%3d ")

(set-face-foreground 'linum "#B9CA4A")
(set-face-background 'linum "#424242")

(setq-default left-fringe-width  15)

(setq-default right-fringe-width 15)

(set-face-attribute 'fringe nil :background "#424242")


(setq-default tab-width 2)

;; (global-linum-mode t)
;; (setq linum-format "%3d ")

(show-paren-mode 1)
(setq-default blink-matching-paren nil
              show-paren-style 'parenthesis
              show-paren-delay 0)

(require 'idle-highlight-mode)

(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'idle-highlight-mode)

;; (defun haskell-mode-setup ()
;;   (setq haskell-process-type 'stack-ghci))
;;; 
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'haskell-mode-setup)

(setq haskell-process-args-stack-ghci
      '("--with-ghc=ghci"
        "--ghci-options=-ferror-spans"
        "--no-build" "--no-load" "--test" "--bench"))

;; (setq haskell-process-args-stack-ghci
;;       ;; '("--ghci-options='-ferror-spans'")
;;       '("--ghc-options=-ferror-spans"
;;           ;; -fshow-loaded-modules is because haskell-mode doesn't work with GHC 8.2.2 yet
;;           ;; see https://github.com/haskell/haskell-mode/issues/1553
;;           ;; "--ghc-options=-fshow-loaded-modules"

;;           ;; these two are the ones that appear to work...
;;           ;; this is for the same thing via the same
;;           ;; "--ghci-options=-fno-diagnostics-show-caret"
;;           ;; this is for the same thing via the same
;;           ;; "--ghci-options=-fshow-loaded-modules"

;;         "--test"
;;         ))

(defun longboyeee ()
  ;;    (interactive "r")
    (interactive)
    (when (eq major-mode 'haskell-mode)
      (let ((start    1)
            (end      (+ 1 (buffer-size)))
            (program "longboye"))
        (let ((saved-cursor-position (point)))
            (call-process-region start
                                 end
                                 program
                                 t         ;; delete
                                 t         ;; destination
                                 nil       ;; display
                                 "imports"
                                 "-"
                                 )
            (goto-char saved-cursor-position)))))

;;  (add-hook 'before-save-hook #'longboyeee)


(defun revert-all-buffers ()
  "Refresh all open file buffers without confirmation.
Buffers in modified (not yet saved) state in emacs will not be reverted. They
will be reverted though if they were modified outside emacs.
Buffers visiting files which do not exist any more or are no longer readable
will be killed."
  (interactive)
  (dolist (buf (buffer-list))
    (let ((filename (buffer-file-name buf)))
      ;; Revert only buffers containing files, which are not modified;
      ;; do not try to revert non-file buffers like *Messages*.
      (when (and filename
                 (not (buffer-modified-p buf)))
        (if (file-readable-p filename)
            ;; If the file exists and is readable, revert the buffer.
            (with-current-buffer buf
              (revert-buffer :ignore-auto :noconfirm :preserve-modes))
          ;; Otherwise, kill the buffer.
          (let (kill-buffer-query-functions) ; No query done when killing buffer
            (kill-buffer buf)
            (message "Killed non-existing/unreadable file buffer: %s" filename))))))
  (message "Finished reverting buffers containing unmodified files."))


;;;;;;;; purescript

(require 'psc-ide)

(add-hook 'purescript-mode-hook
  (lambda ()
    (psc-ide-mode)
    (company-mode)
    (flycheck-mode)
    (turn-on-purescript-indentation)))

;;;;;;;

(add-hook 'elm-mode-hook
          (lambda ()
            (setq elm-indent-offset 4)
            (setq elm-format-on-save t)))
