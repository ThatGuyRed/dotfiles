#!/bin/bash
rm -r /var/cache/pacman/pkg/download-*
yay -Scc & yay -Rc
