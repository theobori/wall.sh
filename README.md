# ✨ wall.sh

## How to install it ?

Run `install.sh`

## Requirements

- This packages: `libncurses5-dev coreutils` (Debian/Ubuntu)
- Terminal that supports colors
- Font that supports the unicode character **U+2588**
- bash

### Docker


##### Image

```
docker build -t wall.sh .
docker run -it -d wall.sh
```

##### Bind mount

```
docker run -it -v $PWD:/wallsh ubuntu /bin/bash /wallsh/wall.sh
```

##### Pull and run image

```
docker pull b0thr34l/wall.sh
docker run -it b0thr34l/wall.sh
```
