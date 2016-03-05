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

(defcustom wttring-default-city "Taipei"
  "Specify a defauly city to get the weather information."
  :group 'wttrin
  :type 'string)

(defun wttrin-fetch-raw-string (query)
  "Get the weather information based on your QUERY."
  (let ((url-request-extra-headers '(("User-Agent" . "curl"))))
    (with-current-buffer
        (url-retrieve-synchronously
         (concat "http://wttr.in/" query)
         (lambda (status) (switch-to-buffer (current-buffer))))
      (decode-coding-string (buffer-string) 'utf-8))))

(defun wttrin-query (city-name)
  "Query weather of CITY-NAME via wttrin, and display the result
in another buffer."
  (let ((raw-string (wttrin-fetch-raw-string city-name)))
    (if (string-match "ERROR" raw-string)
        (message "Cannot get weather data. Maybe you inputed a wrong city name?")
      (let ((buffer (get-buffer-create (format "*wttr.in - %s*" city-name))))
        (switch-to-buffer buffer)
        (insert (xterm-color-filter raw-string))
        (goto-char (point-min))
        (re-search-forward "^$")
        (delete-region (point-min) (1+ (point)))
        (setq buffer-read-only t)))))

(defun wttrin (&optional force-ask)
  "Display weather information.
Add C-u prefix to force to ask city name."
  (interactive)
  (let* ((ask? (or current-prefix-arg force-ask))
         (city-name (if ask?
                        (read-from-minibuffer "City name: ")
                      (or wttring-default-city (read-from-minibuffer "City name: ")))))
    (wttrin-query city-name)))


(provide 'wttrin)

;;; wttrin.el ends here
