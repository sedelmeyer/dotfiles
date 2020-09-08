
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode nil)
 '(custom-enabled-themes (quote (misterioso)))
 '(global-linum-mode t)
 '(global-visual-line-mode t)
 '(make-backup-files nil)
 '(mouse-wheel-scroll-amount (quote (1 ((shift) . 1) ((control)))))
 '(package-enable-at-startup t)
 '(package-selected-packages (quote (wcheck-mode adaptive-wrap)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; set adaptive-wrap-prefix-mode for indentation on long wrapped
;; lines as default when visual-line-mode is turned-on
(add-hook 'visual-line-mode-hook 'adaptive-wrap-prefix-mode)
