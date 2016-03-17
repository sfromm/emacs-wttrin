[![MELPA][melpa-badge]][melpa-package]
[![MELPA Stable][melpa-stable-badge]][melpa-stable-package]

# wttrin.el

Emacs frontend for weather web service [wttr.in].

## Usage

Set a default cities list for completion:

```elisp
(setq wttrin-default-cities '("Taipei" "Tainan"))
```

Then run `M-x wttrin` to get the information.

![screenshot]

## LICENSE

MIT

[wttr.in]: http://wttr.in/
[screenshot]: wttrin.png
[melpa-badge]: http://melpa.org/packages/wttrin-badge.svg
[melpa-package]: http://melpa.org/#/wttrin
[melpa-stable-badge]: http://stable.melpa.org/packages/wttrin-badge.svg
[melpa-stable-package]: http://stable.melpa.org/#/wttrin
