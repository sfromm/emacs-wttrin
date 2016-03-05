# wttrin.el

Emacs frontend for weather web service [wttr.in].

wttrin.el provides the weather information from wttr.in based on your
query condition.

## Usage

Set variable `wttrin-query`:

```elisp
(defvar wttrin-query "Taipei")
```

Run `M-x wttrin-exec` to get the information:

![screenshot]

## LICENSE

MIT

[wttr.in]: http://wttr.in/
[screenshot]: wttrin.png