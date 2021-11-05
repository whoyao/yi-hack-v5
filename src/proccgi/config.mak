#
#  This file is part of yi-hack-v5 (https://github.com/TheCrypt0/yi-hack-v5).
#  Copyright (c) 2018-2019 Davide Maggioni.
# 
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, version 3.
# 
#  This program is distributed in the hope that it will be useful, but
#  WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#  General Public License for more details.
# 
#  You should have received a copy of the GNU General Public License
#  along with this program. If not, see <http://www.gnu.org/licenses/>.
#

CC=arm-hisiv200-linux-gnueabi-gcc
USER_CFLAGS=-march=armv5te -mcpu=arm926ej-s -I/opt/hisi-linux/x86-arm/arm-hisiv200-linux/target/usr/include -L/opt/hisi-linux/x86-arm/arm-hisiv200-linux/target/usr/lib
USER_LDFLAGS=
AR=arm-hisiv200-linux-gnueabi-ar
RANLIB=arm-hisiv200-linux-gnueabi-ranlib
STRIP=arm-hisiv200-linux-gnueabi-strip
