(require-package 'projectile)

(setq projectile-cache-file (concat dotemacs-cache-directory "projectile.cache"))
(setq projectile-known-projects-file (concat dotemacs-cache-directory "projectile-bookmarks.eld"))
(setq projectile-indexing-method 'turbo-alien)
(setq projectile-enable-caching t)
(setq projectile-completion-system dotemacs-switch-engine)

(after 'helm-projectile
  (add-to-list 'helm-projectile-sources-list 'helm-source-projectile-recentf-list))

(projectile-mode)

(dolist (dir dotemacs-globally-ignored-directories)
  (add-to-list 'projectile-globally-ignored-directories dir))

(cond
 ((executable-find "rg")
  (setq projectile-generic-command
        (concat "rg -0 --files --color never "
                (mapconcat (lambda (dir) (concat "--glob " "'!" dir "'")) projectile-globally-ignored-directories " "))))
 ((executable-find "ag")
  (setq projectile-generic-command
        (concat "ag -0 -l --nocolor "
                (mapconcat (lambda (dir) (concat "--ignore-dir=" dir)) projectile-globally-ignored-directories " "))))
 ((executable-find "ack")
  (setq projectile-generic-command
        (concat "ack -f --print0"
                (mapconcat (lambda (dir) (concat "--ignore-dir=" dir)) projectile-globally-ignored-directories " ")))))

(provide 'config-projectile)
