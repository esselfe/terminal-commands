#!/bin/bash

time {
	rsync -av --ignore-existing rsync://rsync.kernel.org/pub/linux/kernel/v4.x/incr/* patches/v4.x/incr/
	rsync -av --ignore-existing rsync://rsync.kernel.org/pub/linux/kernel/v5.x/incr/* patches/v5.x/incr/
	rsync -av --ignore-existing rsync://rsync.kernel.org/pub/linux/kernel/v6.x/incr/* patches/v6.x/incr/
}

for i in 4 5 6; do
	cd patches/v$i.x/incr
	for f in *.xz; do
		n=${f//.xz/}
		[ -e $n ] || unxz -k $f
	done
	cd ../../..
done

