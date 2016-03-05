;;; wttrin.el --- Emacs frontend for weather web service wttr.in
;; Copyright (C) 2016 Carl X. Su

;; Author: Carl X. Su <bcbcarl@gmail.com>
;; Version: 0.1.0
;; Package-Requires: ((emacs "24.4") (xterm-color "20150823.646"))
;; Keywords: comm, weather, wttrin
;; URL: https://github.com/bcbcarl/emacs-wttrin

;;; Commentary:

;; Provides the weather information from wttr.in based on your query condition.

;;; Code:
(require 'url)
(require 'xterm-color)

(defgroup wttrin nil
  "Emacs frontend for weather web service wttr.in."
  :prefix "wttrin-"
  :group 'comm)

(defcustom wttrin-query "Taipei"
  "Specify a query condition to get the weather information."
  :group 'wttrin
  :type 'string)

(defun wttrin-fetch (query)
  "Get the weather information based on your QUERY."
  (let ((url-request-extra-headers '(("User-Agent" . "curl"))))
    (with-current-buffer
      (url-retrieve-synchronously
        (concat "http://wttr.in/" query)
        (lambda (status) (switch-to-buffer (current-buffer))))
      (decode-coding-string (buffer-string) 'utf-8))))


(defun wttrin-exec ()
  "Display weather information."
  (interactive)
  (let ((buf (get-buffer-create (format "*wttr.in - %s*" wttrin-query))))
    (switch-to-buffer buf))
  (insert (xterm-color-filter (wttrin-fetch wttrin-query)))
  (goto-char (point-min))
  (re-search-forward "^$")
  (delete-region (point-min) (1+ (point)))
  (setq buffer-read-only t))

(provide 'wttrin)

;;; wttrin.el ends here
